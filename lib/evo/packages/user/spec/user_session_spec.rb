
describe Session do
  before(:each) { Evo.setup! }
  
  describe ".reap" do
    before :each do
      @new_1 = Session.create :id => '1111111', :hostname => '0.0.0.0', :last_request_at => DateTime.now, :user_id => 1
      @new_2 = Session.create :id => '1111112', :hostname => '0.0.0.1', :last_request_at => DateTime.now, :user_id => 2
      @old_1 = Session.create :id => '1111113', :hostname => '0.0.0.2', :last_request_at => DateTime.parse('may 25th 1987'), :user_id => 3
      @old_2 = Session.create :id => '1111114', :hostname => '0.0.0.3', :last_request_at => DateTime.parse('may 25th 1987'), :user_id => 4
    end
    
    it "should destroy old sessions" do
      Session.reap
      Session.all.should include(@new_1, @new_2)
      Session.all.should_not include(@old_1, @old_2)
    end
  end
end