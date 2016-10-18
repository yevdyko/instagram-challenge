module PostsHelper
  def liked_post(post)
    if user_signed_in? && current_user.voted_for?(post)
      filename = 'icon-heart.png'
      path = unlike_post_path(post)
    else
      filename = 'icon-heart-empty.png'
      path = like_post_path(post)
    end
    heart_icon(filename, path, post)
  end

  def display_likes(post)
    votes = post.votes_for.up.by_type('User')
    return list_likers(votes) if votes.size < 4
    count_likers(votes)
  end

  private

  def heart_icon(filename, path, post)
    link_to(image_tag(filename, id: 'icon-heart'), path,
      remote: true, id: "like_#{post.id}", class: 'post-like')
  end

  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' likes'
  end

  def list_likers(votes)
    usernames = []
    unless votes.blank?
      add_username(votes, usernames)
      usernames.to_sentence.html_safe + like_plural(votes)
    end
  end

  def add_username(votes, usernames)
    votes.voters.each do |voter|
      usernames << link_to(
                     voter.username,
                     profile_path(voter.username),
                     class: 'username')
    end
  end

  def like_plural(votes)
    votes.count > 1 ? ' like this' : ' likes this'
  end
end
