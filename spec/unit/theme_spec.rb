
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/shared/all_packages'

describe Evo::Theme do
  before :each do
    @package = Evo::Theme.new File.dirname(__FILE__) + '/../fixtures/app/themes/wahoo'
    @other = Evo::Theme.new File.dirname(__FILE__) + '/../fixtures/app/themes/invalid'
    @path = 'wahoo'
  end
  
  it_should_behave_like 'All packages'
  
  describe ".find" do
    it "should find packages by name" do
      Evo::Theme.find(:wahoo).first.should be_a(Evo::Theme)
      Evo::Theme.find(:wahoo).length.should == 1
      Evo::Theme.find('wahoo').length.should == 1
      Evo::Theme.find(:chrome).length.should == 2
    end
  end
  
  describe ".get" do
    it "should find the first package by name" do
      Evo::Theme.get(:wahoo).should be_a(Evo::Theme)
      Evo::Theme.get('wahoo').should be_a(Evo::Theme)
      Evo::Theme.get(:chrome).should be_a(Evo::Theme)
    end
  end
end