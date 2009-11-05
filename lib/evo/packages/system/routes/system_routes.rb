
##
# Transfer :package specific public file.

get '/:package/*' do |name, path|
  require_package name
  require_package_path :public / path
  send_file @path
end