
before do
  # Reset region content before our next request.
  reset_regions!
  
  # Add system javascripts
  javascripts.add '/system/javascripts/jquery.js'
  javascripts.add '/system/javascripts/jquery.ui.js'
  javascripts.add '/system/javascripts/jquery.rest.js'
  javascripts.add '/system/javascripts/jquery.goodies.js'
  javascripts.add '/system/javascripts/jquery.table-select.js'
  javascripts.add '/system/javascripts/jquery.inline-search.js'
  javascripts.add '/system/javascripts/jquery.floating-headers.js'
  javascripts.add '/system/javascripts/evo.js'
  javascripts.add '/system/javascripts/system.js'
  
  # Provide javascript and messages to layout
  before :rendering_layout do
    content_for :javascripts, javascripts.to_html
    content_for :messages, messages.to_html
  end
end

##
# Compile and transfer :package's sass files from the views directory.

get '/:package/*.css' do |name, path|
  require_package name
  require_package_path :views, "#{path}.sass"
  content_type :css
  render path, :layout => false, :package => @package
end

##
# Transfer :package specific public file.

get '/:package/*' do |name, path|
  require_package name
  require_package_path :public, path
  send_file @path
end

##
# Compile and transfer the current theme's sass files from the views directory.

get '/theme/*.css' do |path|
  require_theme_path :views, "#{path}.sass"
  content_type :css
  render path, :layout => false, :package => theme
end

##
# Transfer a public file from the current theme.

get '/theme/*' do |path|
  require_theme_path :public, path
  send_file @path
end