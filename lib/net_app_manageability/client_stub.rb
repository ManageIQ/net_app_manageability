module NetAppManageability
  class Client
    class << self
      attr_accessor :error_message
    end

    def initialize(*)
      raise "#{self.class.name} could not be loaded due to the following error: #{self.class.error_message}"
    end

    def self.method_missing(*)
      raise "#{name} could not be loaded due to the following error: #{error_message}"
    end
  end
end
