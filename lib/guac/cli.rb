# frozen_string_literal: true

require 'thor'
# require 'pry'

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

    desc 'config', 'Configures local repos'
    method_option :help, aliases: '-h', type: :boolean, desc: 'Display usage information'
    def config(*)
      if options[:help]
        invoke :help, ['config']
      else
        require_relative 'commands/config'
        Guac::Commands::Config.new(options).execute
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

    desc 'up', 'Pull latest for all repos'
    method_option :help, aliases: '-h', type: :boolean, desc: 'Display usage information'
    method_option :branch, aliases: '-b', type: :string, desc: 'Checkout branch and pull updates'
    def up(*)
      if options[:help]
        invoke :help, ['up']
      else
        require_relative 'commands/up'
        Guac::Commands::Up.new(options).execute
      end
    end
  end
end
