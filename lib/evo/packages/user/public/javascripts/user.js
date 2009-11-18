
// Evo - User - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed)

;$(function(){
  
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
   * Add a user role.
   */

  $('body:not(.users) #add-role').click(function() {
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
    
  $('body:not(.users) ul.roles li a.delete').live('click', function() {
    evo.destroy.user.role({ id: $.arg(1), role_id: $(this).closest('li').id() })
    $(this).closest('li').removeWith('slideUp')
    return false
  })
  
})