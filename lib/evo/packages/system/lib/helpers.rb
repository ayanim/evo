
class Evo
  
  #--
  # Exceptions
  #++
  
  ViewMissingError = Class.new StandardError
  LayoutMissingError = Class.new ViewMissingError
  
  module System
    module Helpers
      
      ##
      # Body classes. For example when visiting
      # the path '/user/2/edit' this method will
      # return 'user-2-edit user-2 user'
      
      def body_classes
        returning [] do |classes|
          segments = path_segments
          begin
            classes << segments.join('-')
          end while segments.pop 
        end.join ' '
      end
      
      ##
      # Return array of request path segments.
      
      def path_segments
        request.path.split('/').from(1)
      end
      
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
      
      def content_for region, contents = nil, options = {}, &block
        case
        when contents ; regions[region] << Evo::Block.new(contents, options)
        when block    ; regions[region] << Evo::Block.new(capture(&block), contents)
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
      #  :layout   Boolean indicating whether or not to render this view
      #            as the primary contents for the current theme's layout.
      #  ...       All other options are passed to Tilt
      #
      
      def render name, options = {}
        partial = options.delete :partial
        if partial
          parts = name.to_s.split '/'
          parts[-1] = "_#{parts.last}"
          name = File.join parts
        end
        path = (options[:package] || package).path_to "views/#{name}.*"
        raise Evo::ViewMissingError, "view #{name.inspect} does not exist" unless path
        output = Tilt.new(path).render options.delete(:context), options
        if !partial && options.delete(:layout) != false
          content_for :primary, output
          return render_layout(:page, options)
        end
        output
      rescue Evo::LayoutMissingError
        output
      end
      
      ##
      # Render layout template _name_ with the given _options_.
      #
      # === Options
      #
      #  ...       All options are passed to Tilt
      #
      
      def render_layout name, options = {}
        path = Evo.theme.path_to "views/#{name}.*"
        raise Evo::LayoutMissingError, "layout #{name.inspect} does not exist" unless path
        Tilt.new(path).render nil, options do |region, string|
          region ||= :primary
          content_for(region).sort_by(&:weight).map(&:to_html).join string
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