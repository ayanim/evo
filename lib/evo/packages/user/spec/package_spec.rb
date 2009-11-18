
describe Evo::Package do
  before :each do
    @package = Evo::Package.new fixture('app/packages/foo')  
  end
  
  describe "#load_permissions" do
    it "should provide permissions" do
      @package.load_permissions
      @package.permissions.should include('administer foo')
      Permission.provided.should include('administer foo')
    end
  end
end