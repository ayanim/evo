
class Evo
  
  class Menu

    ##
    # Menu id.

    attr_reader :id

    ##
    # Menu name.

    attr_reader :name

    ##
    # Items array.

    attr_accessor :items

    ##
    # Initialize with _name_ and _options_.

    def initialize name = nil, options = {}
      @name = name
      @id = name.to_s.downcase.tr(' ', '-') if name
      @items = options.fetch :items, []
    end

    ##
    # Add _item_.

    def add item
      items << item
    end
    alias :<< :add

    ##
    # Output unordered list(s) with the current _uri_.

    def to_html uri = nil
      %(<ul id="#{id}">#{ items.map { |item| item.to_html(uri) }.join }</ul>)
    end

    #--
    # Item
    #++

    class Item

      ##
      # Item name.

      attr_reader :name

      ##
      # Item path.

      attr_reader :path

      ##
      # Item children.

      attr_accessor :children

      ##
      # Weither or not to display the item.

      attr_accessor :display

      ##
      # Initialize with an item _name_, and relative
      # or absolute _path_.

      def initialize name, path, options = {}
        @name, @path = name, path
        @display = options.fetch :display, true
        @display = options.fetch :when, @display
        @children = options.fetch :children, []
      end

      ##
      # Check if this item has children.

      def children?
        not children.empty?
      end

      ##
      # Check if we can display this item.

      def display?
        case display
        when Proc   ; display.call
        when String ; User.current.may? display
        when Array  ; User.current.may? *display
        else        ; display
        end
      end

      ##
      # Add a child _item_.

      def add item
        children << item
      end
      alias :<< :add

      ##
      # Output list item with the current _uri_.

      def to_html uri = nil
        return '' unless display?
        contents = Menu.new(nil, :items => children).to_html uri if children?
        %(<li #{classes_for(uri)}><a href="#{path}">#{name}</a>#{contents}</li>)
      end

      ##
      # Check if active against the given _uri_.

      def active? uri = nil
        uri == path
      end

      ##
      # Check if a child is active against the given _uri_.

      def active_child? uri = nil
        children.any? do |child|
          child.active? uri
        end
      end

      ##
      # CSS classes for _uri_.

      def classes_for uri = nil
        classes = []
        classes << 'active' if active? uri
        classes << 'active-child' if active_child? uri
        %(class="#{classes.join(' ')}") unless classes.blank?
      end

    end  
  end
end

Menu = Evo::Menu