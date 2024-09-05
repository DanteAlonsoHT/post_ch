class Api::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authorize_user!, only: [:update, :destroy]
  before_action :validate_pagination_params, only: [:index]

  # GET /api/posts?page=1
  def index
    @posts = Post.with_user_email.page(@page).per(10)

    render json: {
      posts: @posts,
      total_pages: @posts.total_pages
    }, status: :ok
  end

  # GET /api/posts/:id
  def show
    render json: @post, status: :ok
  end

  # POST /api/posts
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render json: {
        post: @post,
        notice: I18n.t('posts.create.success')  # Success message
      }, status: :created
    else
      render json: {
        errors: @post.errors.full_messages,
        alert: I18n.t('posts.create.failure')  # Failure message
      }, status: :unprocessable_entity
    end
  end

  # PATCH /api/posts/:id
  def update
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/posts/:id
  def destroy
    @post.destroy
    head :no_content
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    render json: { error: 'Post not found' }, status: :not_found unless @post
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def authorize_user!
    render json: { error: 'Not authorized' }, status: :forbidden unless @post.user == current_user
  end

  def validate_pagination_params
    @page = (params[:page] || 1).to_i
    if @page <= 0 || @page > Post.with_user_email.page(@page).per(10).total_pages
      render json: { error: 'Invalid page number' }, status: :unprocessable_entity
    end
  end
end
