require 'yaml'
require 'colorize'

module Guac
  class Config
    CONFIG_FILE     = File.join(ENV['HOME'], '.guacrc').freeze
    DEFAULTS_FILE   = File.join(__dir__, 'templates/config/guacrc.yml').freeze
    REQUIRED_FIELDS = %i(repos pull_strategy default_branch).freeze
    OH_NO_YOU_DONTS = %w(push merge rebase commit clone init mv rm reset).freeze

    class << self
      def load
        if configs.nil?
          error = "#{CONFIG_FILE} not found\n".yellow
          error += 'Please run ' + '`guac setup`'.green
          raise Guac::Commands::Error, error
        end

        missing_fields = REQUIRED_FIELDS.select { |f| configs[f].nil? || configs[f].empty? }
        if missing_fields.any?
          error = "Missing config for #{missing_fields.join(', ')} \n".yellow
          error += 'Please run ' + '`guac setup`'.green
          raise Guac::Commands::Error, error
        end

        strategy = configs[:pull_strategy]
        cmds = OH_NO_YOU_DONTS.select { |cmd| strategy.include?("git #{cmd}") }
        if cmds.any?
          error = "Your pull strategy is dangerous! `#{strategy.bold}`\n".red
          error += "You really shouldn't use #{cmds.join(', ').bold}\n".yellow
          error += 'Please run ' + '`guac setup`'.green
          raise Guac::Commands::Error, error
        end

        configs
      end

      def defaults
        parse(DEFAULTS_FILE)
      end

      def configs(reload: false)
        if reload
          parse(CONFIG_FILE)
        else
          @configs ||= parse(CONFIG_FILE)
        end
      end

      def save_configs(body)
        file = File.new(CONFIG_FILE, 'w')
        file.puts(body.to_yaml)
        file.close
      end

      private

      def parse(file)
        return nil unless File.exist?(file)

        res = YAML.load(File.read(file))
        # Empty yaml returns `false`
        res || nil
      end
    end
  end
end
