
describe Evo::Block do
  describe "#initialize" do
    it "should accept contents" do
      Evo::Block.new('test').contents.should == 'test'
    end
  end
  
  describe "#weight" do
    it "should default to 0" do
      Evo::Block.new.weight.should == 0
    end
    
    it "should be assignable" do
      block = Evo::Block.new
      block.weight = 4
      block.weight.should == 4
    end
  end
  
  describe "#contents" do
    it "should be assignable" do
      block = Evo::Block.new
      block.contents = 'test'
      block.contents.should == 'test'
    end
    
    it "should be aliased as #to_html" do
      Evo::Block.new('test').to_html.should == 'test'
    end
    
    it "should be aliased as #to_s" do
      Evo::Block.new('test').to_s.should == 'test'
    end
  end
end