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

rv = netapp_client.nfs_exportfs_list_rules(:pathname, "/vol/#{VOLUME_NAME}")
raise "No export rules found for path /vol/#{VOLUME_NAME}" unless rv.kind_of?(NetAppManageability::NAMHash)

rules = rv.rules
rules.exports_rule_info.root = NetAppManageability::NAMHash.new if rules.exports_rule_info.root.nil?
if rules.exports_rule_info.root.exports_hostname_info.nil?
  rules.exports_rule_info.root.exports_hostname_info = NetAppManageability::NAMArray.new
else
  rules.exports_rule_info.root.exports_hostname_info = rules.exports_rule_info.root.exports_hostname_info.to_ary
end

rha = rules.exports_rule_info.root.exports_hostname_info

changed = false
ROOT_HOSTS.each do |nrhn|
  skip = false
  rha.each do |crhh|
    if crhh.name == nrhn
      skip = true
      break
    end
  end
  next if skip
  
  rha << NetAppManageability::NAMHash.new { name nrhn }
  changed = true
end

if changed
  puts "Updating rules"
  netapp_client.nfs_exportfs_modify_rule do
    persistent  true
    rule        rules
  end
else
  puts "No change to rules, not updating"
end
