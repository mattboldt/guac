# frozen_string_literal: true

require_relative '../config'
require 'yaml'
require 'colorize'
# require 'pry'

module Guac
  module Commands
    class Config

      def initialize(options, thor)
        @options = options
        @config = Guac::Config.load(raise_error: false)
        @defaults = Guac::Config.defaults
        @thor = thor
      end

      def execute(_input: $stdin, output: $stdout)
        body = @defaults
        body.merge!(@config) unless @config.nil?

        output.puts "============= \n\n\n"
        prompt_repos(body, output)
        output.puts "\n"
        prompt_branch_aliases(body, output)
        prompt_pull_strategy(body)
        prompt_default_branch(body)
        output.puts "\n"

        save_config(body)
        output.puts 'Config saved in ~/.guacrc'.colorize(:green)
      end

      private

      def prompt_repos(body, output)
        result = @thor.ask('Git Repos (separated by spaces):'.bold.colorize(:blue), required: true)

        dirs = result.split(/ \s*/)
        body[:repos] = dirs.map do |r|
          {
            dir: r,
            name: r.split('/').last,
          }
        end
      end

      def prompt_branch_aliases(body, output)
        output.puts 'Git branch aliases:'.bold.colorize(:blue)
        output.puts 'Input format: `branch_name:branch_name_alias`'

        result = @thor.yes?('Would you like to configure aliases? (y/n)')
        return unless result

        body[:repos].each do |repo|
          result = @thor.ask("Alias for `#{repo[:name].colorize(:blue)}`:")
          next unless valid_result?(result)

          branch_pairs = result.split(/ \s*/)
          repo[:branch_aliases] = {}.tap do |obj|
            branch_pairs.each do |pair|
              branches = pair.split(':')
              obj[branches[0]] = branches[1]
            end
          end
        end
      end

      def prompt_pull_strategy(body)
        default = "(default: `#{@defaults[:pull_strategy]}`)".colorize(:blue)
        result = @thor.ask("Pull strategy #{default}:")

        body[:pull_strategy] = result if valid_result?(result)
      end

      def prompt_default_branch(body)
        default = "(default: `#{@defaults[:default_branch]}`)".colorize(:blue)
        result = @thor.ask("Default branch #{default}:")

        body[:default_branch] = result if valid_result?(result)
      end

      def valid_result?(result)
        result && !result.strip.empty?
      end

      def save_config(body)
        file = File.new(Guac::Config::CONFIG_FILE, 'w')
        file.puts(body.to_yaml)
        file.close
      end
    end
  end
end
