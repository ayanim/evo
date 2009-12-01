
before do
  javascripts.add '/application/javascripts/application.js'
end

get '/hello' do
  render :hello
end