require "net_app_manageability"
svr = NetAppManageability::API.server_open(SERVER, 1, 1)
NetAppManageability::API.server_style(svr, NetAppManageability::API::NA_STYLE_LOGIN_PASSWORD)
NetAppManageability::API.server_adminuser(svr, USERNAME, PASSWORD)
rv = NetAppManageability::API.server_invoke(svr, "volume-list-info", :volume => "vol1")

puts "RV: #{rv.inspect}"
