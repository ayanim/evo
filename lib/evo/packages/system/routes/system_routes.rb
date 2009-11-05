
##
# Compile and transfer :package's sass files.

get '/:package/*.css' do |name, path|
  require_package name
  require_package_path :public, "#{path}.sass"
  content_type :css
  sass File.read(@path)
end

##
# Transfer :package specific public file.

get '/:package/*' do |name, path|
  require_package name
  require_package_path :public, path
  send_file @path
end