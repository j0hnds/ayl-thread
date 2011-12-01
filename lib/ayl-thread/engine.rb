module Ayl

  module Thread

    class Engine
      include Ayl::Logging

      attr_reader :worker, :thread

      def initialize()
        logger.info "#{self.class.name}.initialize"
        @queue = []
        @mutex = Mutex.new
        @worker = worker
      end

      def asynchronous?() true end

      def is_connected?() true end

      def submit(message)
        log_call(:submit) do
          @mutex.synchronize { @queue << message }
        end
      end

      def worker
        @worker ||= Ayl::Thread::Worker.new(@mutex, @queue)
        @thread = @worker.process_messages
      end
    end

  end

end
