
// Evo - Core - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed)

;(function(){

  evo = { create: {}, update: {}, destroy: {}, add: {}}

 // --- Panel
 
  /**
   * Panel constructor.
   *
   * @see evo.panel()
   * @api private
   */

	evo.Panel = function(table, options) {
		var self = this
		this.table = $(table)
		this.panel = $(table).next('.panel')
		this.select = $(this.panel).find('select').change(function(){
			var method = $(this).val() || 'reset'
			self.panel.slideUp('slow')
			self.select.find('option:first').attr('selected', 'selected')
			if (method in options)
			  options[method].call(self)
		})
	}
	
  /**
   * Panel interaction utility. Attaches logic to the
   * panel nearest to _tabel_, with the given _options_.
   *
   *   evo.panel('table.jobs', {
   *   	destroy: function(){
   *   	  this.table.find('tr').each(function(){
 	*         if ($(this).find(':checkbox').is(':checked'))
   *   	}
   *   })
   *
   * @param  {mixed} table
   * @param  {hash} options
   * @see evo.Panel()
   * @api public
   */
   
	evo.panel = function(table, options) {
		return new evo.Panel(table, options)
	}
	
	// --- Request
	
	/**
	 * Issue a request to _uri_ using _method_.
	 * This method displays any messages sent with
	 * the response. If a _callback_ is given it is
	 * invoked.
	 *
	 * @param  {string} method
	 * @param  {string} uri
	 * @param  {hash} data
	 * @param  {function} callback
	 * @return {evo}
	 * @api public
	 */
	
	evo.request = function(method, uri, data, callback) {
	  $[method](uri, data, function(response){
	    if (response.message)
	      evo.message(response.message, response.status ? 'info' : 'error')
	    if (callback) callback(response)
	  })
	  return evo
	}

  // --- Messages
  
  /**
   * Display a _message_ with the given _options_
   *
   *   evo.message('Email sent')
   *   evo.message('Email failed to send', { type: 'error' })
   *   evo.message('Email failed to send', { type: 'error', duration: 8000 })
   *
   * @param  {string} message
   * @param  {hash} options
   * @return {evo}
   * @api public
   */
  
  evo.message = function(message, options) {
	  options = options || {}
    var element = $(evo.template.message(message, options.type || 'info'))
      .hide()
      .prependTo('.block-body:first')
      .fadeIn('slow')
    setTimeout(function() {
      element.removeWith('fadeOut', 'slow')
    }, options.duration || 4000)
    return evo
  }
  
  // --- Templates
  
  evo.template = {
    
    /**
     * Message list with _message_ _type_.
     */
     
     message : function(message, type) {
       return '<ul class="messages ' + type + '"><li>' + message + '</li></ul>'
     }
  }
  
  // --- Helpers
  
  $.extend(evo.add, {
    
    /**
     * Adds a text input with an "Add" button 
     * within a list item. When submitted or when
     * "Add" is clicked the user will be notified
     * if the value is only whitespace, otherwise
     * _callback_ will be invoked and the list item
     * will be removed.
     *
     * @param  {hash} options
     * @param  {function} callback
     * @return {evo}
     * @api public
     */
    
    textInput: function(options, callback) {
      function fn(e) {
        $.trim(input.val()) ?
          (callback.call(input, e), li.removeWith('slideUp')) :
            li.shake()
        return false
      }
      var li = $('<li></li>')
      var add = $('<a href="#" class="add">Add</a>').click(fn)
      var input = $('<input type="text" />').keypress(function(e){ if (e.charCode == 13) fn(e) })
      $(options.to).append(li.prepend(add).prepend(input))
      return evo
    }
  })
  
  // --- jQuery Extensions
  
  /**
   * Remove element(s) with _method_ where _method_
   * may be slideUp, slideDown, fadeIn, fadeOut, etc.
   *
   * @param  {string} method
   * @param  {int} speed
   * @param  {function} callback
   * @return {jQuery}
   * @api public
   */
  
  $.fn.removeWith = function(method, speed, callback) {
    return $(this)[method](speed || 'fast', function() {
      $(this).remove()
      if (callback) callback()
    })
  }
  
  /**
   * Shake element(s) with _options_ and _speed_.
   *
   * @param  {hash} options
   * @param  {int} speed
   * @param  {function} callback
   * @return {jQuery}
   * @api public
   */
  
  $.fn.shake = function(options, speed, callback) {
    return $(this).effect('shake', 
      options || {}, 
      speed || 200,
      callback)
  }
  
  /**
   * Return the first element's id as an integer.
   *
   *  $('<div id="user-2" />').id()
   *  // => 2
   * 
   * @return {int}
   * @api public
   */
  
  $.fn.id = function() {
    var id = this.attr('id')
    if (id && (val = parseInt(id.substr(id.indexOf('-') + 1))))
      return val
  }
  
})()
