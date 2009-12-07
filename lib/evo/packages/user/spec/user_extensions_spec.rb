
describe "user" do
  describe "#setting" do
    it "should get / set user specific settings" do
      setting(:theme).should be_nil
      setting :theme, 'chrome'
      setting(:theme).should == 'chrome'
      setting :theme, 'dark'
      setting(:theme).should == 'dark'
    end
  end
end