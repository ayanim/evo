
// Evo - Job Queue - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed)

;$(function(){
  
  // --- REST
  
  $.extend(evo.update, {
	  job: {
	    
	    /**
	     * Update _status_ of the given job _id_.
	     *
	     * @param  {int} id
	     * @param  {string} status
	     * @param  {function} callback
	     * @return {evo}
	     * @api public
	     */
	    
			status: function(id, status, callback) {
				return evo.request('update', '/job', { id: id, status: status, message: '' }, callback)
			}
		}
	})
	
	$.extend(evo.destroy, {
	  
	  /**
	   * Destroy the given job _id_.
	   *
	   * @param  {int} id
	   * @param  {function} callback
	   * @return {evo}
	   * @api public
	   */
	  
	  job: function(id, callback) {
		  return evo.request('del', '/job', { id: id }, callback)
	  }
	})
  
  // --- Panel
  
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