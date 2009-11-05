
require File.dirname(__FILE__) + '/queue'

class Evo
  
  ##
  # = JavaScriptQueue
  #
  # An Evo::JavaScriptQueue handles the inclusion of
  # <script> tags, both with inline javascript and
  # files referenced by the 'src' attribute.
  #
  # === Examples
  #
  #   javascript = Evo::JavaScriptQueue.new
  #   javascript.add 'http://foo.com/jquery.js'
  #   javascript.add '/jquery.js', :weight => -5
  #   javascript.add 'foo = "bar"'
  #   javascript << 'foo = "bar"'
  #   javascript.to_html // => markup
  #
  
  class JavaScriptQueue < Queue

    ##
    # Add _js_, where _js_ may be a uri, or literal JavaScript.
    #
    # === Options
    # 
    #   :weight   int representing the output weight. Defaults to 0
    # 
    # === Examples
    #
    #   javascript.add 'http://foo.com/jquery.js'
    #   javascript.add '/jquery.js', :weight => -5
    #   javascript.add 'foo = "bar"'
    #   javascript << 'foo = "bar"'
    #

    def add js, options = {}
      options = { :js => js, :weight => 0 }.merge(options)
      js.starts_with?('http') || js.starts_with?('/') ?
        (queue[:uri] ||= []) << options :
          (queue[:inline] ||= []) << options
    end
    alias :<< :add

    ##
    # Return html script tags.
    #
    # === Options
    #
    #   :only   only :uri, or :inline
    #

    def to_html options = {}
      only = options.fetch :only, [:uri, :inline]
      only = [only] unless Array === only
      markup = queue.map do |type, queue|
        next unless type.in? only
        send :"render_#{type}", queue.sort_by { |q| q[:weight] }
      end.join "\n"
      clear
      markup
    end

    private

    ##
    # Render uri _queue_.

    def render_uri queue
      queue.map do |q|
        %(<script src="#{q[:js]}" type="text/javascript"></script>)
      end.join "\n"
    end

    ##
    # Render inline _queue_.

    def render_inline queue
      %(<script type="text/javascript">\n) + 
        queue.map { |q| q[:js] }.join(";\n") + 
      ";\n</script>"
    end

  end
end