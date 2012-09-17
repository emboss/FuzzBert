
module FuzzBert::Handler
  class FileOutput
    def initialize(dir=nil)
      @dir = dir
      if @dir && !@dir.end_with?("/")
        @dir << "/"
      end
    end

    def handle(id, data, pid, status)
      prefix = status.termsig ? "crash" : "bug"
      filename = "#{dir_prefix}#{prefix}#{pid}"
      File.open(filename, "wb") { |f| f.print(data) }
      puts "#{id} failed. Data was saved as #{filename}."
    end

    private

      def dir_prefix
        return "./" unless @dir
        @dir
      end
  end

  class Console
    def handle(id, data, pid, status)
      puts "#{id} failed. Data: #{data.inspect}"
    end
  end
end


