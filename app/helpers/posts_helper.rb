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

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
