module NetAppManageability
  class API
    class << self
      attr_accessor :logger, :verbose
    end

    self.verbose = false
  end
end
