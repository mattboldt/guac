require 'thor'

module Guac
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'guac version'
    def version
      require_relative 'version'
      puts "v#{Guac::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'setup', 'Configures local paths & git settings'
    method_option :help, aliases: '-h', type: :boolean
    def setup(*)
      if options[:help]
        invoke :help, ['setup']
      else
        require_relative 'commands/setup'
        Guac::Commands::Setup.new(options, self).execute
      end
    end

    desc 'status', 'Show the status of all git repos'
    method_option :help, aliases: '-h', type: :boolean
    def status(*)
      if options[:help]
        invoke :help, ['status']
      else
        require_relative 'commands/status'
        Guac::Commands::Status.new(options).execute
      end
    end

    map 'st' => 'status'

    desc 'up', 'Pull latest for all repos'
    method_option :help, aliases: '-h', type: :boolean
    def up(*)
      if options[:help]
        invoke :help, ['up']
      else
        require_relative 'commands/up'
        Guac::Commands::Up.new(options, ARGV).execute
      end
    end
  end

  module Commands
    Error = Class.new(StandardError)
  end
end
