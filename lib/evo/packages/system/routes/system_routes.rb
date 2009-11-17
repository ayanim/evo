
before do
  reset_regions!
end

##
# Compile and transfer :package's sass files from the views directory.

get '/:package/*.css' do |name, path|
  require_package name
  require_package_path :views, "#{path}.sass"
  content_type :css
  render :print, :layout => false, :package => @package
end

##
# Transfer :package specific public file.

get '/:package/*' do |name, path|
  require_package name
  require_package_path :public, path
  send_file @path
end

##
# Transfer a public file from the current theme.

get '/theme/*' do |path|
  require_theme_path :public, path
  send_file @path
end