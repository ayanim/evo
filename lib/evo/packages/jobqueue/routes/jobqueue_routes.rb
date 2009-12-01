
before do
  javascripts.add '/jobqueue/javascripts/jobqueue.js'
  @menu.add Menu::Item.new('Jobs', '/jobs', :when => 'administer job queue')
end

##
# Displays job queue and worker information.
#
# === Permissions
#
#  * 'administer job queue'
# 

get '/jobs/?' do
  require_permission_to 'administer job queue'
  @jobs = Job.all.page params.merge(:order => [:priority.desc])
  @count = Job.count
  messages.info 'The job queue is currently empty' if @jobs.empty?
  render :jobs
end

##
# Update the given job :id with the given params.
#
# === Permissions
#
#  * 'administer job queue'
#
# === Provides
#
#  * :json
#

put '/job/?', :provides => :json do
  require_permission_to 'administer job queue'
  if job = Job.get(params[:id])
    json :status => job.update(params)
  end
  json :message => "Failed to update job #{params[:id]}"
end

##
# Deletes the given job :id. 
#
# === Permissions
#
#  * 'administer job queue'
# 
# === Provides
#
#  * :json
#

delete '/job/?', :provides => :json do
  require_permission_to 'administer job queue'
  if job = Job.get(params[:id])
    json :status => job.destroy
  end
  json :message => "Failed to delete job #{params[:id]}"
end
