require 'mkmf'

if Gem.win_platform?
  $LDFLAGS = "-static"
  # $DLDFLAGS = $DLDFLAGS.split(',').delete_if {|f| f == "--export-all"}.join(',')

  libs = %w(ws2_32 libadt libxml libeay32 ssleay32 odbc32 odbccp32 libnetapp)

  sdk_base = "C:/netapp-manageability-sdk/netapp-manageability-sdk-4.0P1"
  dir_config("netapp-manageability-sdk", nil, File.join(sdk_base, "lib/nt"))
else
  libs = %w(z xml pthread nsl m crypto ssl dl rt adt netapp)

  dir_config("netapp-manageability-sdk")
end

unless have_header("netapp_api.h")
  STDERR.puts "Could not find netapp_api.h"
  exit 1
end

missing_libs = libs.reject { |lib| have_library(lib) }
if missing_libs.any?
  STDERR.puts "Could not find libraries: #{missing_libs.join(", ")}"
  exit 1
end

create_makefile("net_app_manageability/net_app_manageability")
