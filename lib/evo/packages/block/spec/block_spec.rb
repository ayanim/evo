
describe Evo::Block do
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
end