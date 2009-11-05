
##
# Transfer :package specific public file.

get '/public/:package/*' do |package_name, path|
  #send_file path
end