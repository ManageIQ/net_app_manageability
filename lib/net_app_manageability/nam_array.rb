module NetAppManageability
  class NAMArray < Array
    
    def initialize(&block)
      super()
      unless block.nil?
        block.arity < 1 ? self.instance_eval(&block) : block.call(self)
      end
    end
  end
end
