
# Spec configuration

Spec::Runner.configure do |c|
  c.include Module.new {
    
    # Set current user to _id_ for duration of _block_.
    
    def with_user id, &block
      # TODO: finish
      yield
    end
    
    # Anonymous user.
    
    def be_anonymous 
      simple_matcher "to be anonymous" do |actual|
        actual.id == 2
      end
    end
  }
end
