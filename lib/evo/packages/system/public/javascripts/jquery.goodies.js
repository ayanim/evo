
// jQuery - Goodies - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed) 

;(function($){
  
  // --- Version
  
  $.goodies = { version : '1.1.0' }
  
  // --- Aliases
  
  $.toArray = $.makeArray
  
  /**
   * Return path segments for the windows current
   * pathname or the given _path_.
   *
   * @param  {string} path
   * @return {array}
   * @api public
   */
  
  $.args = function(path) {
    return (path || window.location.pathname).replace(/^\/|\/$/g, '').split('/')
  }
  
  /**
   * Return path segment at _i_ for the windows current 
   * pathname or the given _path_.
   *
   * @param  {int} i
   * @param  {string} path
   * @return {string}
   * @api public
   */
  
  $.arg = function(i, path) {
    return $.args(path).slice(i)[0]
  }
  
  /**
   * Iterate _array_ with persistant _memo_, using _callback_.
   *
   *   $.inject(['foo', 'bar'], 0, function(length, word, i){
   *     return length + word.length
   *   })
   *   // => 6
   *
   *  As shown below, the memo variable does not need to be explicitly
   *  returned when mutable:
   *
   *   $.inject(['foo', 'bar'], [], function(pairs, word, i){
   *     pairs.push([i, word])
   *   })
   *   // => [[0, 'foo'], [1, 'bar']]
   *
   * @param  {array} array
   * @param  {mixed} memo
   * @param  {function} callback
   * @return {mixed}
   * @api public
   */

  $.inject = function(array, memo, callback) {
    for (var i = 0, len = array.length; i < len; ++i)
      result = callback.call(array[i], memo, i, array[i]),
      memo = result == undefined ? memo : result
    return memo
  }
  
  /**
   * Iterate _array_ selecting values which evaluate to true
   * when executing _callback_.
   *
   *   $.select(['foo', 'bar', 'tj'], function(){
   *     return this.length < 3
   *   })
   *   // => ['tj']
   *
   * @param  {array} array
   * @param  {function} callback
   * @return {mixed}
   * @api public
   */
  
  $.select = function(array, callback) {
    return $.inject(array, [], function(selected, i, val) {
      if (callback.call(val, i, val))
        selected.push(val)
    })
  }
  
  /**
   * Iterate _array_ selecting values which evaluate to false
   * when executing _callback_.
   *
   *   $.reject(['foo', 'bar', 'tj'], function(){
   *     return this.length < 3
   *   })
   *   // => ['foo', 'bar']
   *
   * @param  {array} array
   * @param  {function} callback
   * @return {mixed}
   * @api public
   */
  
  $.reject = function(array, callback) {
    return $.inject(array, [], function(selected, i, val) {
      if (!callback.call(val, i, val))
        selected.push(val)
    })
  }
  
  /**
   * Return an array consisting of only unique values.
   *
   * @param  {array} array
   * @return {array}
   * @api public
   */
  
  $.uniq = function(array) {
    var unique = [], len = array.length
    for (var i = 0; i < len; ++i) {
      for (var j = i+1; j < len; ++j)
        if (array[i] == array[j])
          j = ++i;
      unique.push(array[i])
    }
    return unique
  }
  
  /**
   * Return the union of _array_ and _other_ array.
   *
   * @param  {array} array
   * @param  {array} other
   * @return {array}
   * @api public
   */
  
  $.union = function(array, other) {
    return $.uniq($.merge(array, other))
  }
  
  /**
   * Remove null values from _array_
   *
   * @param  {array} array
   * @return {array}
   * @api public
   */
  
  $.compact = function(array) {
    return $.reject(array, function(i, val) {
      return val === null
    })
  }
  
  /**
   * Zip values from _array_ with _other_. Any number
   * of arrays may be passed to zip.
   *
   *  a = [0, 1, 2]
   *  b = ['foo', 'bar', 'baz']
   *  c = [10, 9, 8]
   *  $.zip(a, b,c )
   *  // => [[0, 'foo', 10], [1, 'bar', 9], [2, 'baz', 8]]
   *
   * @param  {array} array
   * @param  {array} ...
   * @return {array}
   * @api public
   */
  
  $.zip = function(array, other) {
    var zipped = [], len = array.length
    for (var i = 0; i < len; ++i) {
      zipped[i] = [array[i]]
      for (var j = 1; j < arguments.length; ++j)
        zipped[i][j] = arguments[j][i]
    }
    return zipped
  }
  
  /**
   * Return _fn_ body string.
   *
   * @param  {function} fn
   * @return {string}
   * @api public
   */
  
  $.body = function(fn){
    return fn.toString().match(/^[^\{]*{((.*\n*)*)}/m)[1]
  }

  /**
   * Return _fn_ parameter name array.
   *
   *  fn = function(foo, bar, baz){}
   *  $.params(fn) 
   *  // => ['foo', 'bar', 'baz']
   *
   * @param  {function} fn
   * @return {array}
   * @api public
   */
   
  $.params = function(fn){
    return fn.toString().match(/\((.*?)\)/)[1].match(/[\w]+/g) || []
  }
   
})(jQuery)