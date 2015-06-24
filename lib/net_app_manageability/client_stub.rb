module NetAppManageability
  class Client
    def self.available?
      false
    end

    def self.error_message
      platform = RbConfig::CONFIG["target_os"]
      if platform.include?("linux")
        "compile failed."
      else
        "not available on platform #{platform}"
      end
    end

    def initialize(*)
      raise "#{self.class.name} could not be loaded because #{self.class.error_message}"
    end

    def self.method_missing(*)
      raise "#{name} could not be loaded because #{error_message}"
    end
  end
end
