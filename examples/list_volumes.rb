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

rv = netapp_client.volume_list_info

aia = rv.volumes.volume_info.to_ary
aia.each do |ai|
  puts "Volume: #{ai.name}\tavailable space: #{ai.size_available}"
end
