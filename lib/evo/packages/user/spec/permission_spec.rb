
describe Permission do
  describe ".provide" do
    it "should create a union of permissions available" do
      Permission.provide 'administer foobar'
      Permission.provide 'delete foobar'
      Permission.provided.should include('administer foobar')
      Permission.provided.should include('delete foobar')
    end
  end
  
  describe ".create_provided!" do
    it "should create provided permissions" do
      Permission.all.destroy
      Permission.create_provided!
      Permission.all.any? { |p| p.name == 'administer foobar' }.should be_true
    end
  end
end