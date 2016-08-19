require 'rails_helper'

module ProfilesHelpers
  def have_bio(user)
    have_css('.profile-bio', text: user.bio)
  end

  def have_errors_messages
    have_css('.alert.alert-danger')
  end
end
