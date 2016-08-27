module PostsHelper
  def liked_post(post)
    if user_signed_in? && current_user.voted_for?(post)
      link_to('', unlike_post_path(post), remote: true, id: "like_#{post.id}",
        class: 'like glyphicon glyphicon-heart')
    else
      link_to('', like_post_path(post), remote: true, id: "like_#{post.id}",
        class: 'like glyphicon glyphicon-heart-empty')
    end
  end

  def display_likes(post)
    votes = post.votes_for.up.by_type('User')
    return list_likers(votes) if votes.size < 4
    count_likers(votes)
  end

  private

  def list_likers(votes)
    usernames = []
    unless votes.blank?
      votes.voters.each do |voter|
        usernames << link_to(
                       voter.username,
                       profile_path(voter.username))
      end
      usernames.to_sentence.html_safe + like_plural(votes)
    end
  end

  def count_likers(votes)
    vote_count = votes.size
    vote_count.to_s + ' likes'
  end

  def like_plural(votes)
    votes.count > 1 ? ' like this' : ' likes this'
  end
end
