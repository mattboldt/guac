# frozen_string_literal: true

require_relative '../command'
require_relative '../config'
require_relative '../repo'
require 'tty'
require 'rainbow'
require 'pry'

module GitPa
  module Commands
    class Up < GitPa::Command
      def initialize(options)
        @options = options
        @config = GitPa::Config.load
      end

      def execute(input: $stdin, output: $stdout)
        branch = ARGV[1]
        repos = @config[:repos].map { |r| GitPa::Repo.new(@config, r) }
        # progressbar = TTY::ProgressBar.new('Updating', total: repos.length)

        repos.each do |repo|
          # progressbar.advance(1)
          branch_name = Rainbow(repo.branch_alias(branch)).underline
          puts "Updating #{Rainbow(repo.name).bold} on branch #{branch_name}"
          sleep 0.3
        end
      end
    end
  end
end
