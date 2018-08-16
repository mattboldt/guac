# frozen_string_literal: true

require_relative '../command'
require_relative '../config'
require_relative '../repo'
require_relative '../colors'

module GitPa
  module Commands
    class Status < GitPa::Command
      def initialize(options)
        @options = options
        @config = GitPa::Config.load
        @repos = @config[:repos].map { |r| GitPa::Repo.new(@config, r) }
      end

      def execute(input: $stdin, output: $stdout)
        @repos.each do |repo|
          output.puts repo.name.bold.colorize(:blue)

          response = [repo.status]

          color, response = Colors.paint(response)
          output.puts response.join("\n")
          break if color == :red
        end
      end
    end
  end
end
