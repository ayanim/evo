
class Evo
  class Package
    attr_reader :name
    attr_reader :path
    attr_reader :file
    
    def initialize path
      @path = path
      @name = File.basename(path).to_sym
      @file = path / name + '.rb'
    end
    
    def load!
      load file
      self
    end
  end
end