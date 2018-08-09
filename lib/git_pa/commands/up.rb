# frozen_string_literal: true

require_relative '../command'
require_relative '../config'
require_relative '../repo'
require_relative '../git'
require_relative '../colors'
require 'tty-progressbar'

module GitPa
  module Commands
    class Up < GitPa::Command
      def initialize(options)
        @options = options
        @config = GitPa::Config.load
        @repos = @config[:repos].map { |r| GitPa::Repo.new(@config, r) }
      end

      def execute(input: $stdin, output: $stdout)
        branch = ARGV[1] || 'master'

        @repos.each do |repo|
          git = Git.new(repo, branch)
          output.puts "Updating #{repo.name.bold} on branch #{git.branch.underline}".colorize(:blue)

          response = []
          response << git.checkout
          response << git.pull
          color, response = Colors.paint(response)

          output.puts response.join("\n")
          break if color == :red
        end
      end
    end
  end
end
