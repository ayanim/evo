
class Evo
  module System
    module Helpers
      
      def regions
        @__regions ||= Hash.new([])
      end
      
      def reset_regions!
        @__regions = Hash.new []
      end
      
      def content_for region, contents = nil, &block
        case
        when contents ; regions[region] << contents
        when block    ; regions[region] << capture(&block)
        else          ; regions[region].join "\n"
        end
      end
      
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
        Tilt.new(path).render options.delete(:context), options do |region|
          content_for region
        end
      end
      
      ##
      # Render partial template _name_ with the given _options_.
      #
      #   Local variables are injected for use within the view. 
      #   For example partial(:item, :collection => Item.all) will
      #   iterate and assign each value in :collection as a local
      #   variable named 'item'.
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
          if object = options.delete(:object)
            options[object_name] = object
          end
          render name, options.merge!(:partial => true)
        end
      end
      alias :partial :render_partial
      
      private
      
      ##
      # HACK: Sinatra to allow views to be loaded from arbitrary paths.
      
      def lookup_template engine, template, views_dir, filename = nil, line = nil
        return super unless template.is_a? String
        [ ::File.read(template), template, 1 ]
      end
      
      def lookup_layout engine, template, views_dir
        p engine
        p template
        # TODO: implement
      end
      
    end
  end
end

helpers Evo::System::Helpers