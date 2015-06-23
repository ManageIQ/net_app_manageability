$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'net_app_manageability'

def pending_if_not_available
  return if NetAppManageability::Client.available?
  pending(NetAppManageability::Client.error_message)
end
