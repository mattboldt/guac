require 'yaml'
require 'colorize'

module Guac
  class Config
    CONFIG_FILE = File.join(ENV['HOME'], '.guacrc').freeze
    DEFAULTS_FILE = File.join(File.dirname(__FILE__), 'templates/config/guacrc.yaml').freeze

    def self.load
      @config ||= YAML.load(File.read(CONFIG_FILE)) if File.exist?(CONFIG_FILE)

      if @config.nil?
        puts "ERROR: Please run config".colorize(:red)
        raise
      end

      @config
    end

    def self.defaults
      @defaults ||= YAML.load(File.read(DEFAULTS_FILE)) if File.exist?(DEFAULTS_FILE)
    end
  end
end
