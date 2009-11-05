
##
# Transfer :package specific public file.

get '/:package/public/*' do |name, path|
  if package = Evo::Package.get(name)
    if path = package.path_to(:public / path)
      send_file path
    end
  end
  pass
end