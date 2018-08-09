# frozen_string_literal: true

require_relative '../command'
require_relative '../config'
require_relative '../repo'
require_relative '../git'
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
        response = []
        @repos.each do |repo|
          local_res = []
          git = Git.new(repo)
          response << repo.name.bold.colorize(:blue)
          local_res << git.status

          color, local_res = Colors.paint(local_res)
          response << local_res
          break if color == :red
        end

        output.puts "\n"
        output.puts response.flatten.join("\n")
      end
    end
  end
end
