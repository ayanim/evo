
class Evo
  module System
    module Helpers
      
      ##
      # Region contents stack(s).
      
      def regions
        @__regions ||= reset_regions!
      end
      
      ##
      # Reset region contents.
      
      def reset_regions!
        @__regions = Hash.new do |hash, key|
          hash[key] = []
        end
      end
      
      ##
      # Get or set _contents_ for the given _region_.
      #
      # Contents may be provided via _contents_ object or
      # by capturing the given _block_. 
      #
      # When both _contents_ and _block_ are not present, 
      # the array of contents for the _region_ are returned;
      # which may then be styled as needed.
      #
      # === Examples
      #
      #  contents_for :footer, 'Copyright 2009'
      #  contents_for :footer, 'TJ Holowaychuk'
      #
      #  contents_for(:footer).map(&:to_html).join(' ')
      #  # => 'Copyright 2009 TJ Holowaychuk'
      #
      #  # from within a view
      #  yield :footer, ' '
      #
      #  # or join with ''
      #  yield :footer
      #
      
      def content_for region, contents = nil, &block
        case
        when contents ; regions[region] << Evo::Block.new(contents)
        when block    ; regions[region] << Evo::Block.new(capture(&block))
        else          ; regions[region]
        end
      end
      
      ##
      # Capture _block_ output.
      
      def capture &block
        yield
      end
      
      ##
      # Set current package when evaluating a route _block_.
      
      def route_eval &block
        Evo::Package.current = Evo::Package.map[block.__id__]
        super
      end
      
      ##
      # Return current package.
      
      def package
        Evo::Package.current
      end
      
      ##
      # Set @package to package _name_ or pass.
      
      def require_package name
        pass unless @package = Evo::Package.get(name) 
      end
      
      ##
      # Set @path to @package's _dir_ matching _glob_ or pass.
      
      def require_package_path dir, glob
        pass unless @path = @package.replaceable_path_to(dir, glob)
      end
      
      ##
      # Message queue.
      
      def messages
        session[:messages] ||= Evo::MessageQueue.new
      end
      
      ##
      # JavaScript queue.
      
      def javascripts
        @javascripts ||= JavaScriptQueue.new
      end
      
      ##
      # Generate urlencoded random token.
      
      def token
        rand(999999999999).to_s.base64_encode.url_encode
      end
      
      ##
      # Re-generate session token.
      
      def regenerate_session
        session[:id] = token
      end
      
      ##
      # Render template _name_ with the given _options_.
      #
      # === Options
      #
      #  :package  Render a view residing in the given :package
      #  :context  Evaluate template against the given :context object
      #
      
      def render name, options = {}
        if options.delete :partial
          parts = name.to_s.split '/'
          parts[-1] = "_#{parts.last}"
          name = File.join parts
        end
        path = (options.delete(:package) || package).path_to "views/#{name}.*"
        raise "view #{name.inspect} does not exist" unless path
        Tilt.new(path).render options.delete(:context), options do |region, string|
          content_for(region).map(&:to_html).join string
        end
      end
      
      ##
      # Render partial template _name_ with the given _options_.
      #
      # === Options
      #
      #  :package      Render a view residing in the given :package
      #  :context      Evaluate template against the given :context object
      #  :object       Render the template against a single object
      #  :collection   Render the template with each object in :collection
      #

      def render_partial name, options = {}
        object_name = name.to_s.split('/').last.to_sym
        if collection = options.delete(:collection)
          collection.map do |object|
            options[object_name] = object
            render name, options.merge!(:partial => true)
          end.join("\n")
        else
          options[object_name] = options.delete(:object) if options.include? :object
          render name, options.merge!(:partial => true)
        end
      end
      alias :partial :render_partial
      
    end
  end
end

helpers Evo::System::Helpers