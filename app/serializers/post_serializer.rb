class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :user_email

  def user_email
    object.user.email if object.user.present?
  end
end
