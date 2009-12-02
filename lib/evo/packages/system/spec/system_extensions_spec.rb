
describe "system" do
  describe "#store" do
    it "should provide access to evolution's datastore" do
      store[:foo] = 'bar'
      store[:foo].should == 'bar'
    end
  end
end