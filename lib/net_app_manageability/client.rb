require_relative "ontap_method_map"

module NetAppManageability
  class Client
    attr_reader :options

    NA_STYLE_LOGIN_PASSWORD   = API::NA_STYLE_LOGIN_PASSWORD
    NA_STYLE_RPC              = API::NA_STYLE_RPC
    NA_STYLE_HOSTSEQUIV       = API::NA_STYLE_HOSTSEQUIV

    NA_SERVER_TRANSPORT_HTTP  = API::NA_SERVER_TRANSPORT_HTTP
    NA_SERVER_TRANSPORT_HTTPS = API::NA_SERVER_TRANSPORT_HTTPS

    NA_SERVER_TYPE_FILER      = API::NA_SERVER_TYPE_FILER
    NA_SERVER_TYPE_NETCACHE   = API::NA_SERVER_TYPE_NETCACHE
    NA_SERVER_TYPE_AGENT      = API::NA_SERVER_TYPE_AGENT
    NA_SERVER_TYPE_DFM        = API::NA_SERVER_TYPE_DFM
    NA_SERVER_TYPE_CLUSTER    = API::NA_SERVER_TYPE_CLUSTER

    include OntapMethodMap

    def initialize(opts={}, &block)
      @options = NAMHash.new(true) do
        auth_style      NA_STYLE_LOGIN_PASSWORD
        transport_type  NA_SERVER_TRANSPORT_HTTP
        server_type     NA_SERVER_TYPE_FILER
        port            80
      end
      @options.merge!(opts)
      unless block.nil?
        block.arity < 1 ? @options.instance_eval(&block) : block.call(@options)
      end

      raise "Client: No server specified" if @options.server.nil?
    end

    def handle
      return @handle unless @handle.nil?

      @handle = API.server_open(options.server, 1, 1)
      API.server_style(@handle, options.auth_style)

      if options.auth_style == NA_STYLE_LOGIN_PASSWORD
        API.server_adminuser(@handle, options.username, options.password)
      end

      @handle
    end

    def self.wire_dump
      API.wire_dump
    end

    def self.wire_dump=(val)
      API.wire_dump = val
    end

    def self.verbose
      API.verbose
    end

    def self.verbose=(val)
      API.verbose = val
    end

    def self.logger
      API.logger
    end

    def self.logger=(val)
      API.logger = val
    end

    def method_missing(method_name, *args, &block)
      cmd = map_method(method_name.to_sym)
      return super if cmd.nil?

      ah = nil
      if args.length > 0 || !block.nil?
        ah = NAMHash.new

        if args.length == 1 && args.first.kind_of?(Hash)
          ah.merge!(args.first)
        elsif args.length > 1
          ah.merge!(Hash[*args])
        end

        unless block.nil?
          block.arity < 1 ? ah.instance_eval(&block) : block.call(ah)
        end
      end

      return API.server_invoke(handle, cmd, ah)
    end

    def respond_to_missing?(method_name, include_private = false)
      map_method(method_name.to_sym) || super
    end
  end # class Client
end
