module NetAppManageability
  class API
    class << self
      attr_accessor :logger, :verbose, :wire_dump
    end

    self.verbose   = false
    self.wire_dump = false
  end
end
