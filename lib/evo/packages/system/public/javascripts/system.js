
// Evo - System - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed)

;$(function(){
  
  // --- Table select
  
  /**
   * Table select.
   */
   
  $('table.select').tableSelect()
   
   /**
    * Display "with selected" panel.
    */
   
  $('table.select tr :checkbox:nth-child(1)').click(function() {
    $('table.select :checked').length ? 
      $(this).closest('table').nextAll('.panel').slideDown('slow') :
        $(this).closest('table').nextAll('.panel').slideUp('slow')
  })
  
})