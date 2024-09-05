require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:other_user) { User.create!(email: "other@example.com", password: "password") }
  let(:post1) { Post.create!(title: "Test Post 1", body: "This is a test post", user: user) }
  let(:post2) { Post.create!(title: "Test Post 2", body: "This is another test post", user: user) }
  
  describe 'GET #index' do
    before do
      post1
      post2
    end

    it 'returns a successful response' do
      get :index, params: { page: 1 }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct number of posts' do
      get :index, params: { page: 1 }
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['posts'].size).to eq(2)
    end

    it 'returns an error for invalid page number' do
      get :index, params: { page: -1 }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #show' do
    it 'returns the post' do
      get :show, params: { id: post1.id }
      expect(response).to have_http_status(:ok)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['title']).to eq(post1.title)
    end

    it 'returns an error when the post is not found' do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    context 'when authenticated' do
      before { sign_in user }

      it 'creates a new post' do
        expect {
          post :create, params: { post: { title: 'New Post', body: 'This is a new post' } }
        }.to change(Post, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it 'returns errors when post creation fails' do
        post :create, params: { post: { title: '', body: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to include("Title can't be blank")
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized status' do
        post :create, params: { post: { title: 'New Post', body: 'This is a new post' } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when authenticated as post owner' do
      before { sign_in user }

      it 'updates the post' do
        patch :update, params: { id: post1.id, post: { title: 'Updated Title' } }
        expect(response).to have_http_status(:ok)
        post1.reload
        expect(post1.title).to eq('Updated Title')
      end

      it 'returns errors when update fails' do
        patch :update, params: { id: post1.id, post: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to include("Title can't be blank")
      end
    end

    context 'when authenticated as non-owner' do
      before { sign_in other_user }

      it 'returns forbidden status' do
        patch :update, params: { id: post1.id, post: { title: 'Updated Title' } }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when authenticated as post owner' do
      before { sign_in user }

      it 'deletes the post' do
        delete :destroy, params: { id: post1.id }
        expect(response).to have_http_status(:no_content)
        expect(Post.find_by(id: post1.id)).to be_nil
      end
    end

    context 'when authenticated as non-owner' do
      before { sign_in other_user }

      it 'returns forbidden status' do
        delete :destroy, params: { id: post1.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end