module ProfilesHelper
  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium), id: 'image-preview',
      class: 'img-responsive img-circle' if user.avatar.exists?
    image_tag 'default-avatar.jpg', id: 'image-preview',
      class: 'img-responsive img-circle'
  end

  def current_user_is_following(current_user_id, followed_user_id)
    relationship = Relationship.find_by(follower_id: current_user_id,
                                        following_id: followed_user_id)
    return true if relationship
  end
end
