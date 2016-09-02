include FontAwesome::Rails::IconHelper

module ApplicationHelper
  FLASH_MSG = {
    success: 'alert-success',
    error:   'alert-danger',
    alert:   'alert-warning',
    notice:  'alert-info'
  }.freeze

  def alert_for(flash_type)
    FLASH_MSG.fetch(flash_type.to_sym, flash_type.to_s)
  end
end
