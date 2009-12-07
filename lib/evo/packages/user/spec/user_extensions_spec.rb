
describe "user" do
  describe "#setting" do
    it "should get / set user specific settings" do
      setting(:theme).should be_nil
      setting :theme, 'chrome'
      setting(:theme).should == 'chrome'
      setting :theme, 'dark'
      setting(:theme).should == 'dark'
    end
    
    it "should persist" do
      setting :name, 'TJ Holowaychuk'
      current_user.save && current_user.reload
      setting(:name).should == 'TJ Holowaychuk'
    end
  end
end