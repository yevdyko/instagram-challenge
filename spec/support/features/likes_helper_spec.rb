module LikesHelpers
  def have_empty_heart_icon
    have_css("img[src*='icon-heart-empty']")
  end

  def have_solid_heart_icon
    have_css("img[src*='icon-heart']")
  end

  def add_like(post)
    click_link "like_#{post.id}"
  end

  def add_unlike(post)
    click_link "like_#{post.id}"
  end
end
