require "net_app_manageability/version"
require "net_app_manageability/types"

begin
  # Load the C extension if it has been compiled
  require "net_app_manageability/net_app_manageability"
rescue LoadError => err
  require "net_app_manageability/client_stub"

  platform = RbConfig::CONFIG["target_os"]
  error_message =
    if platform.include?("linux")
      "#{err.class}: #{err}"
    else
      "Not available on platform #{platform}"
    end

  NetAppManageability::Client.error_message = error_message
else
  require "net_app_manageability/client"
end
