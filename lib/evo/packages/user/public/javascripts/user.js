
// Evo - User - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed)

;$(function(){
  
  // --- Templates
  
  $.extend(evo.template, {
    
    /**
     * Select input with all user role options.
     */
    
    roleSelect: function() {
      return _(evo.roles).inject('<select class="roles"><option value="">- Select -</option>', function(select){
        if (this.assignable)
          return select + '<option value="' + this.id + '">' + this.name + '</option>'
      }) + '</select>'
    },
    
    /**
     * Role list item with delete link.
     *
     *  - id: role id
     *  - name: role name
     */
    
    roleItem: function(options) {
      return '<li id="role-' + options.id + '">' 
           + '<a href="/user/role/' + options.id + '/permissions">' + options.name + '</a> ' 
           + '<a href="#" class="delete">Delete</a></li>'
    },
    
    /**
     * Permission list item with delete link.
     */
    
    permissionItem: function(name) {
      return '<li>' + name + ' <a href="#" class="delete">Delete</a></li></li>'
    }
  })
  
  // --- Helpers
  
  $.extend(evo.add, {
    
    /**
     * Add role select to the given _options.to_ selector.
     * When changed _callback_ will be invoked and this element
     * will be removed automatically.
     *
     * @param  {hash} options
     * @return {evo}
     * @api public
     */
    
    roleSelect: function(options, callback) {
      var select = $(evo.template.roleSelect())
      $(options.to)
        .append($('<li></li>').append(select))
      select
        .fadeIn('slow')
        .change(function(e) {
          callback.call(select, e), $(this).closest('li').removeWith('slideUp') 
        })
      return evo
    }
  })
  
  // --- REST
  
  $.extend(evo.create, {
    
    /**
     * Create a role with the given _name_.
     *
     * @param  {string} name
     * @param  {function} callback
     * @return {evo}
     * @api public
     */
    
    role: function(name, callback) {
      return evo.request('create', '/user/role', { name: name }, callback)
    },
    
    user: {
      
      /**
       * Create user role with _options_.
       *
       *  - id: user id
       *  - role_id: role id
       *
       * @param  {hash} options
       * @param  {function} callback
       * @return {evo}
       * @api public
       */
      
      role: function(options, callback) {
        return evo.request('create', '/user/' + options.id + '/role', options, callback)
      }
    }
  })

  $.extend(evo.destroy, {
    user: function(id, callback) {
      return evo.request('del', '/user', { id: id }, callback)
    },
    
    /**
     * Delete role _id_.
     *
     * @param  {int} id
     * @param  {function} callback
     * @api public
     */
    
    role: function(id, callback) {
      return evo.request('del', '/user/role', { role_id: id }, callback)
    }
  })
  
  /**
   * Delete user role with _options_.
   *
   *  - id: user id
   *  - role_id: role id
   *
   * @param  {Type} Var
   * @return {Type}
   * @api public
   */
  
  evo.destroy.user.role = function(options, callback) {
    return evo.request('del', '/user/' + options.id + '/role', { role_id: options.role_id }, callback)
  }
  
  // --- Users
  
  /**
   * User panel.
   */
  
	evo.panel('table.users', {
		destroy: function(){
			$('table.users tr').each(function(i) {
				var self = $(this)
        if (self.find(':checkbox').is(':checked'))
          setTimeout(function() {
            if (id = self.id())
              evo.destroy.user(id, function(response){
                console.log(response);
                if (response.status)
                  self.removeWith('fadeOut')
            })
          }, i * 300)
      })
		}
	})
  
  /**
   * Add a role.
   */
  
  $('body.users #add-role').click(function() {
    evo.add.textInput({ to: 'ul.roles' }, function() {
      var name = $.trim(this.val())
      evo.create.role(name, function(response) {
        if (response.status)
          $('ul.roles')
            .append(evo.template.roleItem({ id: response.id, name: name }))
            .children(':last-child')
            .hide()
            .fadeIn('slow')
        else
          evo.message(response.message, { type: 'error' })
      })
    })
    return false
  })
  
  /**
   * Delete a role.
   */
  
  $('body.users ul.roles li a.delete').live('click', function() {
    evo.destroy.role($(this).closest('li').id())
    $(this).closest('li').removeWith('slideUp')
    return false
  })
  
  // --- User
  
  /**
   * Deletes a user with confirmation.
   */
  
  $('body.user .form-buttons a.delete').click(function() {
    if (confirm('Delete the user?'))
      evo.destroy.user($.arg(1), function(){
        window.location = '/users'
      })
  })
  
  /**
   * Add a user role.
   */

  $('body.user #add-role').click(function() {
    evo.add.roleSelect({ to: 'ul.roles' }, function() {
      var id = this.val()
      var name = this.find(':selected').text()
      evo.create.user.role({ id: $.arg(1), role_id: id })
      $('ul.roles')
        .append(evo.template.roleItem({ id: id, name: name }))
        .children(':last-child')
        .hide()
        .fadeIn('slow')
    })
    return false
  })
  
  /**
   * Delete a user role.
   */
    
  $('body.user ul.roles li a.delete').live('click', function() {
    evo.destroy.user.role({ id: $.arg(1), role_id: $(this).closest('li').id() })
    $(this).closest('li').removeWith('slideUp')
    return false
  })
  
})