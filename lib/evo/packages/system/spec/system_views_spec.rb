
describe "system views" do
  describe "_block" do
    it "should description" do
      mock_app :package => :system do
        get '/' do
          partial :block,
            :classes => 'foo',
            :title => 'System',
            :description => 'description',
            :body => 'body'
        end
      end
      get '/'
      last_response.body.should have_selector('div.block.foo')
      last_response.body.should have_selector('div .heading h2:contains(System)')
      last_response.body.should have_selector('div .heading p.description:contains(description)')
      last_response.body.should have_selector('div .block-body:contains(body)')
    end
  end
end