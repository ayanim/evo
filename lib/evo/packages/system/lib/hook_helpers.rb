
class Evo
  module System
    module HookHelpers
      
      ##
      # Hook hash.
      
      def hooks
        @hooks ||= {}
      end
      
      ##
      # Add _block_ as a hook callback _before_or_after_ _event_
      
      def hook before_or_after, event, &block
        hooks[before_or_after] ||= Hash.new([])
        hooks[before_or_after][event] << block
      end
      
      ##
      # Before _event_ call _block_ with _args_.
      #
      # === Examples
      #
      #  before :package_loaded do
      #    puts 'yay'
      #  end
      #
      #  before(:package_loaded) # => "yay"
      #
      
      def before event = nil, *args, &block
        if event
          if block
            hook :before, event, &block
          else
            trigger :before, event, *args
          end
        else
          super(&block)
        end
      end
      
      ##
      # After _event_ call _block_ with _args_.
      #
      # === Examples
      #
      #  after :package_loaded do
      #    puts 'yay'
      #  end
      #
      #  after(:package_loaded) # => "yay"
      #
      
      def after event = nil, *args, &block
        if event
          if block
            hook :after, event, &block
          else
            trigger :after, event, *args
          end
        else
          super(&block)
        end
      end
      
      ##
      # Trigger an callbacks for hook _name_ to be called.
      # When a _block_ is passed :before callbacks will run,
      # then the block will yield, followed by :after being run.
      #
      # === Examples
      #
      #   trigger :before, :package_loaded
      #   # ... load package
      #   trigger :after, :package_loaded
      #
      #   # OR
      #
      #   trigger :package_loaded do
      #     # ... load package
      #   end
      #   
      # === See  
      #   
      #  * #before 
      #  * #after 
      #   
      
      def trigger name, *args, &block
        if block
          trigger :before, name
          yield
          trigger :after, name
        else
          hooks[name][args.shift].each do |proc|
            proc.call *args
          end
        end
      end
      
    end
  end
end

include Evo::System::HookHelpers