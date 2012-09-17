require 'optparse'

module FuzzBert::AutoRun

  TEST_CASES = []

  module_function

  def register(suite)
    TEST_CASES << suite
  end

  def autorun
    options, files = process_args(ARGV)
    load_files(files)
    run(options)
  end

  def run(options=nil)
    raise RuntimeError.new "No test cases were found" if TEST_CASES.empty?
    FuzzBert::Executor.new(TEST_CASES, options).run
  end

  private; module_function

  def load_files(files)
    files.each do |pattern|
      Dir.glob(pattern).each { |f| load File.expand_path(f) }
    end
  end

  def process_args(args = [])
    options = {}
    orig_args = args.dup

    OptionParser.new do |opts|
      opts.banner  = 'Usage: fuzzbert [OPTIONS] PATTERN [PATTERNS]'
      opts.separator <<-EOS

Run your random tests by pointing fuzzbert to a single or many explicit files
or by providing a pattern. The default pattern is 'fuzz/**/fuzz_*.rb, assuming
that your FuzzBert files (files beginning with 'fuzz_') live in a directory
named fuzz located under the current directory that you are in.

By default, fuzzbert will run the tests you specify forever, be sure to hit
CTRL+C when you are done or specify a limit with '--limit'.

EOS

      opts.version = FuzzBert::VERSION

      opts.on '-h', '--help', 'Run ' do
        puts opts
        exit
      end

      opts.on '--pool-size SIZE', Integer, "Sets the number of concurrently running processes to SIZE" do |n|
        options[:pool_size] = n.to_i
      end

      opts.on '--limit LIMIT', Integer, "Instead of running permanently, fuzzing will be stopped after running LIMIT of instances" do |n|
        p n
        options[:limit] = n.to_i
      end

      opts.on '--console', "Output the failing cases including data on the console instead of saving them in a file" do
        options[:handler] = FuzzBert::Handler::Console.new
      end

      opts.parse! args
    end

    raise ArgumentError.new("No file pattern was given") if args.empty?
    [options, args]
  end

end

