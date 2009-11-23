
// Evo - Job Queue - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed)

;$(function(){
  evo.panel('table.jobs', {
		destroy: function() {
			this.table.find('tr').each(function(){
				var self = $(this)
				if (self.find(':checkbox').is(':checked'))
				  evo.destroy.job(self.id(), function(response){
					  if (response.status)
					    self.removeWith('fadeOut')
				  })
			})
		},
		
		inactive: function() {
			this.table.find('tr').each(function(){
				var self = $(this)
				if (self.find(':checkbox').is(':checked'))
				  evo.update.job.status(self.id(), 'inactive', function(response){
					  if (response.status)
					    self.find('.status')
					    .attr('class', 'status')
					    .addClass('inactive')
					    .text('Inactive')
				  })
			})
		}
	})
})