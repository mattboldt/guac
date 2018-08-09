# frozen_string_literal: true

require 'thor'

module GitPa
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'git_pa version'
    def version
      require_relative 'version'
      puts "v#{GitPa::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'status', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def status(*)
      if options[:help]
        invoke :help, ['status']
      else
        require_relative 'commands/status'
        GitPa::Commands::Status.new(options).execute
      end
    end

    desc 'up', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def up(*)
      if options[:help]
        invoke :help, ['up']
      else
        require_relative 'commands/up'
        GitPa::Commands::Up.new(options).execute
      end
    end

    desc 'config', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def config(*)
      if options[:help]
        invoke :help, ['config']
      else
        require_relative 'commands/config'
        GitPa::Commands::Config.new(options).execute
      end
    end
  end
end
