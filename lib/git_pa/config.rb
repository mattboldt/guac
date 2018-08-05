require 'yaml'

module GitPa
  class Config
    CONFIG_FILE = File.join(ENV['HOME'], '.git_parc').freeze
    DEFAULTS_FILE = File.join(File.dirname(__FILE__), 'templates/config/git_parc.yaml').freeze

    def self.load
      @config ||= YAML.load(File.read(CONFIG_FILE)) if File.exist?(CONFIG_FILE)
    end

    def self.defaults
      @defaults ||= YAML.load(File.read(DEFAULTS_FILE)) if File.exist?(DEFAULTS_FILE)
    end
  end
end
