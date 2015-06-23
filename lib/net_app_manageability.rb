require "net_app_manageability/version"
require "net_app_manageability/types"

require "net_app_manageability/net_app_manageability"

if NetAppManageability::API.respond_to?(:server_open)
  require "net_app_manageability/client"
else
  require "net_app_manageability/client_stub"
end
