module NetAppManageability
  class NAMHash < Hash
    undef_method :id    if self.method_defined? :id
    undef_method :type  if self.method_defined? :type
    undef_method :size  if self.method_defined? :size

    STRIP_PREFIX = "nam_"

    attr_accessor :sym_keys

    def initialize(sym_keys = false, &block)
      @sym_keys = sym_keys
      super()
      unless block.nil?
        block.arity < 1 ? self.instance_eval(&block) : block.call(self)
        self.default = nil
      end
    end

    def to_ary
      return [ self ]
    end

    def method_missing(method_name, *args)
      key = method_name.to_s.sub(/^#{STRIP_PREFIX}/, "").tr('_', '-')
      if key[-1, 1] == '='
        return (self[key[0...-1]] = args[0]) unless @sym_keys
        return (self[key[0...-1].to_sym] = args[0])
      elsif args.length == 1
        return (self[key] = args[0]) unless @sym_keys
        return (self[key.to_sym] = args[0])
      else
        return self[key] unless @sym_keys
        return self[key.to_sym]
      end
    end

    def respond_to_missing?(*_args)
      true
    end
  end
end
