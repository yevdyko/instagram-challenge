require 'rails_helper'

module ProfilesHelpers
  def have_errors_messages
    have_css('.alert.alert-danger')
  end
end