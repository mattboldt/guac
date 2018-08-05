# frozen_string_literal: true

require_relative '../command'
require_relative '../config'
require_relative '../repo'
require 'tty'
require 'colorize'
require 'pry'

module GitPa
  module Commands
    class Up < GitPa::Command
      def initialize(options)
        @options = options
        @config = GitPa::Config.load
      end

      def execute(input: $stdin, output: $stdout)
        branch = ARGV[1] || 'master'
        repos = @config[:repos].map { |r| GitPa::Repo.new(@config, r) }
        # progressbar = TTY::ProgressBar.new('Updating', total: repos.length)

        repos.each do |repo|
          # progressbar.advance(1)
          branch_name = repo.branch_alias(branch)
          output.puts "Updating #{repo.name.bold} on branch #{branch_name.underline}".colorize(:blue)

          co = `cd #{repo.dir} && git checkout #{branch_name}`
          update = `cd #{repo.dir} && git pull origin #{branch_name} --rebase`
          res = [co, update]
          color = set_color(res)

          output.puts update.colorize(color)
          break if color == :red
        end
      end

      def set_color(result)
        if contains?(result, 'Updating')
          :yellow
        elsif contains?(result, 'Failed') || contains?(result, 'error:')
          :red
        else
          :green
        end
      end

      def contains?(ary, string)
        ary.any? { |r| r.include?(string) }
      end
    end
  end
end
