module ProfilesHelpers
  def have_bio(user)
    have_css('.profile-bio', text: user.bio)
  end

  def have_errors_messages
    have_css('.alert.alert-danger')
  end

  def have_post_count(count)
    have_css('.stat-count', text: "#{count} post".pluralize(count))
  end

  def have_follower_count(count)
    have_css('.stat-count', text: "#{count} follower".pluralize(count))
  end

  def have_following_count(count)
    have_css('.stat-count', text: "#{count} following".pluralize(count))
  end
end
