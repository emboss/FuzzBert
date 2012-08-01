
class FuzzBert::Executor

  def initialize(test, poolsize=4, limit=-1)
    @test = test
    @poolsize = poolsize
    @data_cache = {}
    @n = 0
    @limit = limit
  end

  def run(objects)
    objects = [objects] unless objects.respond_to?(:each)
    producer = ObjectProducer.new(objects)

    trap(:CHLD) { on_child_exit(producer.next) }
    trap(:INT) { graceful_exit }
    
    @poolsize.times { run_test(producer.next) }
    sleep
  end

  private

  def run_test(obj)
    data = obj.to_data
    pid = @test.run(data)
    @data_cache[pid] = data
  end

  def on_child_exit(obj)
    begin
      while exitval = Process.wait2(-1, Process::WNOHANG)
        pid = exitval[0]
        status = exitval[1]
        data = @data_cache.delete(pid)
        unless status.success?
          save(data, pid, status) if status.termsig && status.termsig != 2 # :INT
        end
        @n += 1
        run_test(obj) if @limit == -1 || @n < @limit
      end
    rescue Errno::ECHILD
    end
  end

  def graceful_exit
    puts "\nExiting..."
    begin
      while Process.wait; end
    rescue Errno::ECHILD
    end
    exit 0
  end

  def save(data, pid, status)
    prefix = status.termsig ? "crash" : "bug"
    File.open("#{prefix}#{pid}", "wb") { |f| f.print(data) }
  end

  class ObjectProducer
    def initialize(objects)
      @i = 0
      @objects = objects
    end

    def next
      obj = @objects[@i]
      @i = (@i + 1) % @objects.size
      obj
    end
  end

end

