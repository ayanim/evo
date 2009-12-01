
before do
  javascripts.add '/application/javascripts/application.js'
  @menu.add Menu::Item.new('Hello', '/hello', :when => 'view example')
end

get '/hello' do
  require_permission_to 'view example'
  render :hello
end