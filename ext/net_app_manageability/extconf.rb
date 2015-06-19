require 'mkmf'

$configure_args['--with-netappManageabilitySdk-include'] = "/usr/include/netapp"

if Gem.win_platform?
  sdk_base = File.join(File.dirname(__FILE__), "../../../../../netapp-manageability-sdk/netapp-manageability-sdk-4.0P1")
	$configure_args['--with-netappManageabilitySdk-lib'] = File.join(sdk_base, "lib/nt")
 	libs = [ "ws2_32", "libadt", "libxml", "libeay32", "ssleay32", "odbc32", "odbccp32", "libnetapp" ]
	$LDFLAGS = "-static"
	# $DLDFLAGS = $DLDFLAGS.split(',').delete_if {|f| f == "--export-all"}.join(',')
else
	$configure_args['--with-netappManageabilitySdk-lib'] = "/usr/lib64/netapp"
	libs = [ "z", "xml", "pthread", "nsl", "m", "crypto", "ssl", "dl", "rt", "adt", "netapp" ]
end

dir_config('netappManageabilitySdk')

if !have_header("netapp_api.h")
	puts "Could not find netapp_api.h"
	exit 1
end

libs.each do |lib|
	if !have_library(lib)
		puts "Could not find library: #{lib}"
		exit 1
	end
end

create_makefile("net_app_manageability/net_app_manageability")