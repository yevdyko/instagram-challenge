module LikesHelpers
  def have_empty_heart_icon
    have_css('a.glyphicon-heart-empty')
  end

  def have_solid_heart_icon
    have_css('a.glyphicon-heart')
  end

  def add_like(post)
    click_link "like_#{post.id}"
  end

  def add_unlike(post)
    click_link "like_#{post.id}"
  end
end
