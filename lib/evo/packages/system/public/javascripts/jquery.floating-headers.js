
// jQuery.floating-headers.js - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed)

;(function($){
  
  // --- Properties
  
  $.floatingHeaders = { 
    version  : '1.0.0',
    elements : []
  }
  
  // --- Float on scroll
  
  $(window).scroll(function() {
    var y = window.pageYOffset, e = $.floatingHeaders.elements
    for (i = 0, len = e.length; i < len; ++i)
      y > e[i].y ?
        y < (e[i].y + e[i].height) ?
          e[i].element.show().css({ position: 'absolute', top: y }) :
            e[i].element.hide() :
              e[i].element.hide();
  })
  
  /**
   * Float table headers with _options_.
   *
   * The table must wrap its headings in the 'thead' tags.
   * Currently no options are available.
   *
   * @param  {hash} options
   * @return {jQuery}
   * @api public
   */
  
  $.fn.floatHeaders = function(options) {
    return this.each(function() {
      var self = $(this).clone(true).prependTo($(this).parent()).hide()
      self.css('width', $(this).width()).addClass('floating').children(':not(thead)').remove()
      $.floatingHeaders.elements.push({ 
        element: self,
        height: $(this).height(),
        y: $(this).offset().top
      })
    })
  }
  
})(jQuery)