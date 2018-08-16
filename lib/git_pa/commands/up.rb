# frozen_string_literal: true

require_relative '../command'
require_relative '../config'
require_relative '../repo'
require_relative '../colors'
# require 'pry'

module GitPa
  module Commands
    class Up < GitPa::Command
      def initialize(options)
        @options = options
        @config = GitPa::Config.load
        @repos = @config[:repos].map do |repo|
          GitPa::Repo.new(@config, repo, @options[:branch])
        end
      end

      def execute(input: $stdin, output: $stdout)
        @repos.each do |repo|
          output.puts "Updating #{repo.name.bold} on branch #{repo.branch.underline}".colorize(:blue)

          response = []
          response << repo.checkout
          response << repo.pull
          response.compact!

          color, response = Colors.paint(response)

          output.puts response.join("\n")
          break if color == :red
        end
      end
    end
  end
end
