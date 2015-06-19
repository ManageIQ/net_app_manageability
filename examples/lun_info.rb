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

rv = netapp_client.lun_list_info
puts rv.inspect
puts

rv = netapp_client.lun_map_list_info(:path, '/vol/luns/lun1')
puts rv.inspect
puts

rv = netapp_client.iscsi_adapter_initiators_list_info
puts rv.inspect
puts

rv = netapp_client.iscsi_connection_list_info
puts rv.inspect
puts
