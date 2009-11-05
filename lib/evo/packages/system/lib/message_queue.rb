
require File.dirname(__FILE__) + '/queue'

class Evo
  
  ##
  # = MessageQueue
  #
  # An Evo::MessageQueue is essentially the same
  # as a 'flash' message, which spans sessions until
  # the message(s) have been rendered.
  #
  # === Examples
  #
  #   messages = Evo::MessageQueue.new
  #   messages.add 'You have mail', :info
  #   messages.info 'You have mail'
  #   messages.error "Failed to authenticate *#{user}*"
  #   messages.to_html // => markup
  #
  
  class MessageQueue < Queue

    ##
    # Add _message_ of the given _type_. When _message_
    # is not specified, the messages for _type_ will be 
    # returned.
    #
    # === Examples
    #
    #   messages.add 'Login successful'
    #   messages.add 'Login unsuccessful', :error
    #   messages.add nil, :error
    #   # => ['Login unsuccessful']
    #

    def add message = nil, type = :info
      message ?
        (queue[type] ||= []) << message :
          queue[type]
    end
    alias :<< :add

    ##
    # Return unordered lists for each message type.
    #
    # === Examples
    #
    #   messages.error 'Login failed'
    #   messages.error 'Invalid username'
    #   messages.info 'Welcome to our site, enjoy!'
    #
    #   messages.to_html
    #
    #   # => "<ul class="messages error">
    #       <li>Login failed</li>
    #       <li>Invalid username</li>
    #     </ul>
    #     <ul class="messages info">
    #       <li>Welcome to our site, enjoy!</li>
    #     </ul>"
    #

    def to_html
      return '' if empty?
      returning '' do |buf|
        queue.each do |type, messages|
          next if messages.blank?
          buf << '<ul class="messages ' + type.to_s + '">'
          buf << messages.uniq.map { |m| "<li>#{ parse(m.escape_html) }</li>" }.join
          buf << '</ul>'
        end
        clear
      end
    end

    private

    ##
    # Added message of the type _meth_ passed.
    #
    # === Examples
    #
    #   messages.info 'Something worked'
    #   messages.error 'Something failed'
    #   messages.warning 'Something kinda worked'
    #

    def method_missing meth, *args, &block
      add args.shift, meth
    end

    ##
    # Parse _message_. provides a mini-markup language:
    #
    # === Grammar:
    #
    #  *text*  =>  <strong>text</strong>
    #  _text_  =>  <em>text</em>
    #

    def parse message
      message.
       gsub(/\*([^*]+)\*/, '<strong>\1</strong>').
       gsub(/_([^_]+)_/, '<em>\1</em>')
    end

  end
end