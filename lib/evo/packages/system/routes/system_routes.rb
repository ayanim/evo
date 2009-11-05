
##
# Transfer :package specific public file.

get '/:package/public/*' do |name, path|
  # file = Evo.paths_to(:packages / name / :public / path).first
  # p file
  # send_file package.path_to(:public / path) 
end