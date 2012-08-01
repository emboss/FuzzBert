
class FuzzBert::Test

  def initialize(&runner)
    raise RuntimeError.new unless block_given?
    @runner = runner
  end

  def run(data)
    fork do
      begin
        @runner.call(data)
      rescue StandardError
        abort
      end
    end
  end

end

