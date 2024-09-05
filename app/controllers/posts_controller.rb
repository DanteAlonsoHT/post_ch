class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  # Muestra todas las publicaciones (vista HTML)
  def index
    @posts = Post.with_user_email.page(params[:page]).per(10)
    @total_pages = @posts.total_pages

    respond_to do |format|
      format.html # Renders the regular HTML page
      format.js   # Renders the `posts.js.erb` file
    end  
  end
  

  # Muestra una sola publicación
  def show
    respond_to do |format|
      format.html # Renders the regular HTML page
      format.js   # Renders the `posts.js.erb` file
    end 
  end

  # Formulario para nueva publicación
  def new
    @post = Post.new
  end

  # Crear nueva publicación
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Publicación creada con éxito.'
    else
      render :new
    end
  end

  # Formulario para editar publicación
  def edit
  end

  # Actualizar publicación existente
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Publicación actualizada con éxito.'
    else
      render :edit
    end
  end

  # Eliminar publicación
  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Publicación eliminada con éxito.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
