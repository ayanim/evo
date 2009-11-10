
require File.dirname(__FILE__) + '/../spec_helper'

describe Evo::Theme do
  before :each do
    @package = Evo::Theme.new File.dirname(__FILE__) + '/../fixtures/app/themes/wahoo'
    @other = Evo::Theme.new File.dirname(__FILE__) + '/../fixtures/app/themes/invalid'
    @path = 'wahoo'
  end
  it_should_behave_like 'All packages'
end