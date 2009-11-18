
// jQuery - Goodies - Copyright TJ Holowaychuk <tj@vision-media.ca> (MIT Licensed) 

;(function($){
  
  // --- Version
  
  $.goodies = { version : '1.2.0' }
  
  // --- Aliases
  
  $.toArray = $.makeArray
  
  // --- Path Segments
  
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
  
  // --- Enum
  
  /**
   * Create an Enum with the give array-like object.
   *
   * @param {arr} arr
   * @api private
   */
  
  $.Enum = function Enum(arr) {
    arr = $.toArray(arr)
    arr.unshift(0, arr.length)
    Array.prototype.splice.apply(this, arr)
  }
  
  /**
   * Create an Enum with the given array-like object.
   *
   *  - Enums are returned
   *  - All other array-like objects create new Enums
   *
   * @param  {arr} arr
   * @return {Enum}
   * @api public
   */
  
  _ = function(arr) {
    return arr instanceof $.Enum ? arr :
      (new $.Enum(arr))
  }
  
  $.Enum.fn = $.Enum.prototype = {
    
    /**
     * Return the first value, or first _n_ values.
     *
     * @param  {int} n
     * @return {mixed}
     * @api public
     */
    
    first: function(n) {
      n = n || 1
      if (n <= 1) return this[0]
      return _(this.slice(0, n))
    },
    
    /**
     * Return the last value, or last _n_ values.
     *
     * @param  {int} n
     * @return {mixed}
     * @api public
     */
    
    last: function(n) {
      n = n || 1
      if (n <= 1) return this[this.length - 1]
      return _(this.slice(this.length - n, this.length))
    },
        
    /**
     * Iterate with persistant _memo_, using _callback_.
     *
     *   _('foo', 'bar').inject(0, function(length, word, i){
     *     return length + word.length
     *   })
     *   // => 6
     *
     *  As shown below, the memo variable does not need to be explicitly
     *  returned when mutable:
     *
     *   _(['foo', 'bar']).inject([], function(pairs, word, i){
     *     pairs.push([i, word])
     *   })
     *   // => [[0, 'foo'], [1, 'bar']]
     *
     * @param  {mixed} memo
     * @param  {function} callback
     * @return {mixed}
     * @api public
     */

    inject: function(memo, callback) {
      for (var i = 0, len = this.length; i < len; ++i)
        result = callback.call(this[i], memo, i, this[i]),
        memo = result == undefined ? memo : result
      return memo
    },
    
    /**
     * Iterate selecting values which evaluate to true
     * when executing _callback_.
     *
     *   _('foo', 'bar', 'tj']).select(function(){
     *     return this.length < 3
     *   })
     *   // => ['tj']
     *
     * @param  {function} callback
     * @return {Enum}
     * @api public
     */

    select: function(callback) {
      return _(this.inject([], function(selected, i, val) {
        if (callback.call(val, i, val))
          selected.push(val)
      }))
    },
    
    /**
     * Iterate selecting values which evaluate to false
     * when executing _callback_.
     *
     *   _(['foo', 'bar', 'tj']).reject(function(){
     *     return this.length < 3
     *   })
     *   // => ['foo', 'bar']
     *
     * @param  {function} callback
     * @return {Enum}
     * @api public
     */

    reject: function(callback) {
      return _(this.inject([], function(selected, i, val) {
        if (!callback.call(val, i, val))
          selected.push(val)
      }))
    },
    
    /**
     * Return an enum consisting of only unique values.
     *
     * @return {Enum}
     * @api public
     */

    uniq: function() {
      var unique = [], len = this.length
      for (var i = 0; i < len; ++i) {
        for (var j = i + 1; j < len; ++j)
          if (this[i] == this[j])
            j = ++i;
        unique.push(this[i])
      }
      return _(unique)
    },
    
    /**
     * Remove null values.
     *
     * @return {Enum}
     * @api public
     */

    compact: function() {
      return this.reject(function(i, val) {
        return val === null
      })
    },
    
    /**
     * Return the union of self and _other_ arr.
     *
     * @param  {arr} other
     * @return {Enum}
     * @api public
     */

    union: function(other) {
      return this.uniq(this.merge(other))
    },
    
    /**
     * Merge self with _other_ array.
     *
     * @param  {arr} other
     * @return {Enum}
     * @api public
     */
    
    merge: function(other) {
      for (var i = 0, len = other.length; i < len; ++i)
        this.push(other[i])
      return this
    },
    
    slice: Array.prototype.slice,
    push: Array.prototype.push,
    pop: Array.prototype.pop,
    shift: Array.prototype.shift,
    unshift: Array.prototype.unshift
  }
  
  // --- Functions
  
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