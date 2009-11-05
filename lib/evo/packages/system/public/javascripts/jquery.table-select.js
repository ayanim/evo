
// jQuery - Table Select - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed)

;(function(){
  
  // --- Version
  
  $.tableSelect = { version : '0.0.1' }
  
  /**
   * Allow table row selection with _options_:
   *
   *  - selectAllSelector: optional selector used to (de)select all
   *      the checkboxes. Defaults to 'thead :checkbox:first'
   *
   *  - checkboxSelector: selector bound as the row 'checkboxes'.
   *      Defaults to 'tbody tr :checkbox:nth-child(1)', allowing
   *      the left-hand side checkboxes to control the row selection.
   *
   *  - rowClass: optional class to add to the table row when selected.
   *      Defaults to 'selected'.
   *
   * @param  {hash} options
   * @return {jQuery}
   * @api public
   */
  
  $.fn.tableSelect = function(options) {
    options = $.extend({
      selectAllSelector: 'thead :checkbox:first:visible',
      checkboxSelector: 'tbody tr :checkbox:nth-child(1):visible',
      rowClass: 'selected'
    }, options)
    return $(this).each(function() {
      var self = this
      if (options.selectAllSelector)
        $(options.selectAllSelector, this).click(function() {
          $(options.checkboxSelector, self).click()
        })
      $(options.checkboxSelector, this).click(function(e) {
        if (options.rowClass)
          $(this).closest('tr').toggleClass(options.rowClass)
      })
    })
  }
  
})()