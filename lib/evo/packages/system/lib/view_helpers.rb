
class Evo
  
  #--
  # Exceptions
  #++
  
  ViewMissingError = Class.new StandardError
  LayoutMissingError = Class.new ViewMissingError
  
  module System
    module ViewHelpers
      
      ##
      # Body classes. For example when visiting
      # the path '/user/2/edit' this method will
      # return 'user-2-edit user-2 user'
      
      def body_classes
        returning [] do |classes|
          return '' unless segments = path_segments
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
        if respond_to?(:block_is_haml?) && block_is_haml?(block)
          capture_haml &block
        else
          yield
        end
      end
      
      ##
      # Render block partial with _title_, _description_, and any
      # additional _options_ passed to the partial. _block_ contents 
      # is captured as the block :body.
      
      def render_block title, description, options = {}, &block
        partial(:block, {
          :package => Evo::Package.get(:system),
          :title => title,
          :description => description,
          :classes => '',
          :body => capture(&block)
        }.merge(options))
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
        path = theme.path_to_view((options[:package] || package).name / name)
        path ||= (options[:package] || package).path_to_view name
        raise Evo::ViewMissingError, "view #{name.inspect} does not exist" unless path
        output = Tilt.new(path).render options.fetch(:context, self), options
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
        before :rendering_layout, path
        Tilt.new(path).render self, options do |region, string|
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
            options[:context] = object if options[:context]
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

helpers Evo::System::ViewHelpers