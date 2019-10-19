require 'yaml'
require 'colorize'

module Guac
  class Config
    CONFIG_FILE     = File.join(ENV['HOME'], '.guacrc').freeze
    DEFAULTS_FILE   = File.join(File.dirname(__FILE__), 'templates/config/guacrc.json').freeze
    REQUIRED_FIELDS = %i(repos pull_strategy default_branch).freeze

    class << self
      def load(raise_error: true)
        return config unless raise_error

        fields = REQUIRED_FIELDS.select { |f| config[f].nil? || config[f].empty? }

        if config.nil? || fields.any?
          error = ''
          error += "Missing config for #{fields.join(', ')} \n".yellow if fields.any?
          error += 'Please run ' + '`guac config`'.green
          raise Guac::Commands::Error, error
        end

        config
      end

      def defaults
        @defaults ||= parse(DEFAULTS_FILE)
      end

      def config
        @config ||= parse(CONFIG_FILE)
      end

      private

      def parse(file)
        return unless File.exist?(file)

        JSON.parse(File.read(file), symbolize_names: true)
      end
    end
  end
end
