module Ruboty
  class CommandBuilder
    include Mem

    attr_reader :arguments

    def initialize(arguments = ARGV)
      @arguments = arguments
    end

    def build
      command_class.new(options)
    end

    private

    def command_class
      case
      when options[:generate]
        Commands::Generate
      when options[:help]
        Commands::Help
      else
        Commands::Run
      end
    end

    def options
      Slop.parse(arguments) do |options|
        options.on("--dotenv", "Load .env before running.")
        options.on("-g", "--generate", "Generate a new chatterbot with ./ruboty/ directory if specified.")
        options.on("-h", "--help", "Display this help message.")
        options.string("-l", "--load", "Load a ruby file before running.")
      end
    end
    memoize :options
  end
end
