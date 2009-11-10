
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
    # Initialize block with _contents_.
    
    def initialize contents = nil
      @contents, @weight = contents, 0
    end
  end
end