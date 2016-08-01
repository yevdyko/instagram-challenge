module PostsHelper
  def likers_of(post)
    votes = post.votes_for.up.by_type(User)
    usernames = []
    unless votes.blank?
      votes.voters.each do |voter|
        usernames.push(link_to voter.username,
                               'http://www.example.com',
                               class: 'username')
      end
      usernames.to_sentence.html_safe + like_plural(votes)
    end
  end
  
  def liked_post(post)
    if user_signed_in? && current_user.voted_for?(post)
      link_to '', unlike_post_path(post), remote: true, id: "like_#{post.id}",
        class: 'glyphicon glyphicon-heart-empty'
    else
      link_to '', like_post_path(post), remote: true, id: "like_#{post.id}",
        class: 'glyphicon glyphicon-heart-empty'
    end
  end

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
