require 'net_app_manageability'
require 'logger'

SERVER    = raise "please define server"
USERNAME  = ""
PASSWORD  = ""

GB        = 1024 * 1024 *1024
CONTAINING_AGGR = "aggr1"
NEW_VOLUME    = "api_test_vol1"
VOL_SIZE_GB   = 10
NFS_PATH    = "/vol/#{NEW_VOLUME}"
ROOT_HOSTS    = [ HOST1, HOST2 ]

NetAppManageability.logger    = Logger.new(STDOUT)
NetAppManageability.wire_dump = false

netapp_client = NetAppManageability::Client.new do
  server     SERVER
  auth_style NetAppManageability::Client::NA_STYLE_LOGIN_PASSWORD
  username   USERNAME
  password   PASSWORD
end

#
# Ensure the volume doesn't already exist.
#
err = false
begin
  netapp_client.volume_list_info(:volume, NEW_VOLUME)
  err = true
rescue
  # Ignore expected failure
end
raise "Volume #{NEW_VOLUME} already exists" if err

#
# Make sure there's enough free space in the aggregate for the new volume.
#
rv = netapp_client.aggr_list_info(:aggregate, CONTAINING_AGGR)
aggr_free_space = rv.aggregates.aggr_info.size_available.to_i
raise "Insufficient free space in #{CONTAINING_AGGR}: #{aggr_free_space}" if aggr_free_space < VOL_SIZE_GB * GB

#
# The creation of the volume will result in the creation a qtree entry for its root.
# If we want to base a VMware datastore on the volume's NFS share, the security style of
# its corresponding qtree must not be 'ntfs'.
#
# Unfortunately, the API doesn't provide a way to specify this value or change it after the fact.
# The security style is always set to the value of the 'wafl.default_security_style' option.
# So we must ensure that this value is set to either 'unix' or 'mixed' before the volume is created.
#
rv = netapp_client.options_get(:name, 'wafl.default_security_style')
if rv.value == "ntfs"
  puts "Default security style is ntfs, resetting it to mixed"
  rv = netapp_client.options_set do
    name  'wafl.default_security_style'
    value 'mixed'
  end
end

#
# Create the volume within the given aggregate.
#
rv = netapp_client.volume_create do
  containing_aggr_name  CONTAINING_AGGR
  volume                NEW_VOLUME
  space_reserve         "none"
  size                  "#{VOL_SIZE_GB}g"
end

#
# Get the export rules for the new volume's NFS share.
#
rv = netapp_client.nfs_exportfs_list_rules(:pathname, NFS_PATH)

#
# Add a list of root access hosts to the rules.
# These are the ESX hosts that will be able to access the datastore.
#
rules = rv.rules
rules.exports_rule_info.root = NetAppManageability::NAMHash.new do
  exports_hostname_info NetAppManageability::NAMArray.new do
    ROOT_HOSTS.each do |rh|
      push NetAppManageability::NAMHash.new { name rh }
    end
  end
end

#
# Update the export rules with the root access host list.
#
rv = netapp_client.nfs_exportfs_modify_rule do
  persistent  true
  rule        rules
end
