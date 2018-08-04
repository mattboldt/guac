require 'yaml'

module GitPa
  class Config
    CONFIG_FILE = File.join(ENV['HOME'], '.git_parc')

    def self.load
      @config ||= YAML.load(File.read(CONFIG_FILE)) if File.exist?(CONFIG_FILE)
    end
  end
end
