
class Evo
  class Block
    
    ##
    # Weight.
    
    attr_accessor :weight
    
    ##
    # Block contents.
    
    attr_accessor :contents
    alias :to_html :contents
    alias :to_s :contents
    
    ##
    # Initialize block with _contents_ and _options_.
    
    def initialize contents = nil, options = {}
      @contents, @weight = contents, 0
      options.each { |k,v| send :"#{k}=", v } if options
    end
  end
end