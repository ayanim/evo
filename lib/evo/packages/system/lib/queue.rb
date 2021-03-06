
class Evo
  
  ##
  # = Queue
  #
  # An Evo::Queue is a readable alternative
  # to managing keyed hashes. For examples see
  # Evo::MessageQueue and Evo::JavaScriptQueue.
  
  class Queue

    ##
    # Queued values.

    attr_reader :queue

    ##
    # Initialize a clear queue.

    def initialize
      clear
    end

    ##
    # Number of values in queue.

    def length
      queue.inject 0 do |length, (key, values)|
        length + values.length
      end
    end

    ##
    # Check if the queue is empty

    def empty?
      length == 0
    end

    ##
    # Clear the queue.

    def clear
      @queue = {}
    end

  end
end