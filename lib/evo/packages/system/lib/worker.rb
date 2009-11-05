
require 'logger'
require 'daemon-spawn'

class Evo
  
  ##
  # = Worker
  #
  # This abstract worker should be subclassed
  # in order to inherit logging and job scheduling
  # functionality.
  #
  # === Examples
  #    
  #  The example below could be used to reap old
  #  session records, checking every 10 minutes.
  #    
  #   class SessionWorker < Evo::Worker
  #     def start *args
  #       every 10.minutes do
  #         Session.reap
  #       end
  #     end
  #   end
  #
  #   SessionWorker.spawn!
  #
  # The workers/session.rb script then inherits
  # the ability to work as the daemon controller:
  #
  #   $ ruby workers/session.rb start
  #   $ ruby workers/session.rb stop
  #   $ ruby workers/session.rb restart
  #   $ ruby workers/session.rb status
  #
  # === Notes
  #
  #  This is a temporary solution, a cleaner DSL
  #  and integration with the `evo` executable
  #  is coming!.
  #
  
  class Worker < DaemonSpawn::Base
    
    ##
    # Logger instance.
    
    attr_reader :log
    
    ##
    # Initialize logger.
    
    def initialize *args
      @log = Logger.new $stderr
      @log.level = Logger::DEBUG
      super
    end
    
    ##
    # Classname. For example Evo::Worker.classname returns "worker".
    
    def self.classname
      name.downcase.split('::').last
    end
    
    ##
    # Spawn daemon with _options_.
    #
    # === Options
    # 
    #   :working_dir  Defaults to the application's root
    #   :log_file     Defaults to <root>/logs/worker.<name>.log
    #   :pid_file     Defaults to <root>/pids/worker.<name>.pid
    # 
    
    def self.spawn! options = {}
      super({ 
        :working_dir => Evo.root,
        :log_file => "#{Evo.root}/logs/worker.#{classname}.log",
        :pid_file => "#{Evo.root}/pids/worker.#{classname}.pid"
      }.merge(options))
    end
    
    ##
    # Log _message_ for the duration it takes _block_ to execute.
    # Message defaults to 'completed in %s'.
    
    def log_duration message = 'completed in %s', &block
      start = Time.now and yield
      log.info message % start.in_words_since_now
    end
    
    ##
    # Call _block_ every _n_ milliseconds.
    
    def every n, &block
      loop do
        log_duration { yield }
        sleep n  
      end
    end
    
    ##
    # Log termination.
    
    def stop
      log.warn "#{classname} terminated"
    end
    
  end
end