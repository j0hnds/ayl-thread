module Ayl

  module Thread

    class Worker

      def initialize(mutex, queue)
        @mutex = mutex
        @queue = queue
        @running = false
      end

      def process_messages
        puts "Processing messages..."
        raise "Already processing messages from the queue" if @running
        @running = true

        ::Thread.new do
          puts "Inside the thread"
          loop do
            message = nil
            @mutex.synchronize do
              message = @queue.shift
            end
            process_message(message) if message
          end
        end
      end

      def process_message(message)
        message.evaluate(nil)
      end
    end
  end
end
