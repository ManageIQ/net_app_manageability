require 'net_app_manageability'
require 'logger'

SERVER    = raise "please define server"
USERNAME  = ""
PASSWORD  = ""

netapp_client = NetAppManageability::Client.new do
  server     SERVER
  auth_style NetAppManageability::Client::NA_STYLE_LOGIN_PASSWORD
  username   USERNAME
  password   PASSWORD
end

puts
puts "*** No options - list info for all volumes:"
rv = netapp_client.volume_list_info
puts rv.inspect

#
# Different ways of mking the same call.
#
puts
puts "*** List info for a specific volume V1:"
rv = netapp_client.volume_list_info(:volume => "vol1")
puts rv.inspect

puts
puts "*** List info for a specific volume V2:"
rv = netapp_client.volume_list_info(:volume, "vol1")
puts rv.inspect

puts
puts "*** List info for a specific volume V3:"
rv = netapp_client.volume_list_info do
  volume "vol1"
end
puts rv.inspect

puts
puts "*** List info for a specific volume V4:"
rv = netapp_client.volume_list_info do |vla|
  vla.volume = "vol1"
end
puts rv.inspect
