
class Evo
  alias :render_template :render
  module System
    module Helpers
      
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
      #  ...    All options are passed to Sinatra's #render method.
      #
      
      def render name, options = {}
        path = package.path_to "views/#{name}.*"
        render_template Evo.template_engine_for(path), path, options
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
      #  :object       Render the template against a single object
      #  :collection   Render the template with each object in :collection
      #  ...           All other options are passed to Sinatra's #render method
      #

      def render_partial name, options = {}
        options.merge! :layout => false
        parts = name.to_s.split '/'
        object_name = parts.last.to_sym
        parts[-1] = "views/_#{parts.last}.*"
        path = package.path_to File.join(parts)
        engine = Evo.template_engine_for path
        options[:locals] ||= {}
        if collection = options.delete(:collection)
          collection.map do |object|
            options[:locals].merge! object_name => object
            render_template engine, path, options
          end.join("\n")
        else
          if object = options.delete(:object)
            options[:locals].merge! object_name => object
          end
          render_template engine, path, options
        end
      end
      alias :partial :render_partial
      
      private
      
      ##
      # Sinatra hack to allow views to be loaded from arbitrary paths.
      
      def lookup_template engine, template, views_dir, filename = nil, line = nil
        return super unless File.exists? template
        if cached = self.class.templates[template]
          lookup_template(engine, cached[:template], views_dir, cached[:filename], cached[:line])
        else
          [ ::File.read(template), template, 1 ]
        end
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