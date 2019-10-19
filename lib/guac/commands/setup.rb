require_relative '../config'
require_relative '../repo'
require 'yaml'
require 'colorize'

module Guac
  module Commands
    class Setup

      PROMPT_QUEUE = %i(
        prompt_repos
        prompt_branch_aliases
        prompt_pull_strategy
        prompt_default_branch
      ).freeze

      def initialize(options, thor)
        @options = options
        @config = Guac::Config.load(raise_error: false)
        @defaults = Guac::Config.defaults
        @thor = thor
      end

      def execute(_input: $stdin, output: $stdout)
        @output = output
        @body = @defaults.dup
        @body.merge!(@config) unless @config.nil?

        @output.puts "🥑 Welcome to the tableside Guac builder 🥑\n".green

        PROMPT_QUEUE.each do |prompt|
          send(prompt)
          @output.puts "\n"
        end

        save_config
        @output.puts "🥑 Config saved in ~/.guacrc 🥑\n".bold.green
      end

      private

      def prompt_repos
        @output.puts 'Git Repos (separated by spaces)'.bold.blue
        @output.puts 'Input absolute paths or drag & drop folders here (e.g. ~/Repos/one ~/Repos/two)'
        result = @thor.ask('Repos:'.bold, required: true)
        dirs = result.split(/ \s*/)
        validate_repos(dirs)

        @body[:repos] = dirs.map do |r|
          {
            dir: r,
            name: r.split('/').last,
          }
        end
      end

      def prompt_branch_aliases
        @output.puts 'Git branch aliases'.bold.blue
        @output.puts 'Input format: `branch_name:branch_name_alias`'
        result = @thor.yes?('Would you like to configure aliases? (y/n)'.bold)
        return unless result

        @body[:repos].each do |repo|
          result = @thor.ask("Alias for `#{repo[:name].colorize(:blue)}`:")
          next unless valid_result?(result)

          repo[:branch_aliases] = parse_branch_aliases(result)
        end
      end

      def prompt_pull_strategy
        @output.puts 'Pull strategy:'.bold.blue
        @output.puts "Default: `#{@defaults[:pull_strategy].bold}`"
        result = @thor.ask('Enter strategy or press return for default'.bold)

        @body[:pull_strategy] = result if valid_result?(result)
      end

      def prompt_default_branch
        default = "(default: `#{@defaults[:default_branch]}`)".colorize(:blue)
        result = @thor.ask("Default branch #{default}:")

        @body[:default_branch] = result if valid_result?(result)
      end

      def valid_result?(result)
        result && !result.strip.empty?
      end

      def save_config
        file = File.new(Guac::Config::CONFIG_FILE, 'w')
        file.puts(@body.to_json)
        file.close
      end

      def parse_branch_aliases(result)
        branch_pairs = result.split(/ \s*/)
        {}.tap do |obj|
          branch_pairs.each do |pair|
            branches = pair.split(':')
            obj[branches[0]] = branches[1]
          end
        end
      end

      def validate_repos(dirs)
        return if Guac::Repo.valid?(dirs)

        error = "1 or more directories could not be found, or are not git repos!".yellow.bold
        raise Guac::Commands::Error, error
      end
    end
  end
end
