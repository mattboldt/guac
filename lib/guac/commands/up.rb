require_relative '../repo'
require_relative '../colors'
require_relative '../sys_command'

module Guac
  module Commands
    class Up
      def initialize(options, args = [])
        @options = options
        @repos = Guac::Repo.build_from_config(args[1])
      end

      def execute(_input: $stdin, output: $stdout)
        threads = @repos.map do |repo|
          output.puts "Updating #{repo.name.bold} on branch #{repo.branch.underline}".blue

          Thread.new do
            response = []

            begin
              repo.checkout
              response << repo.pull
            rescue Guac::SysCommandError => e
              response << repo.dir.bold.red
              response << e.message.red
            end

            response.compact!
            response = Colors.paint(response)
            response.unshift(repo.name.bold.blue)
            response.join("\n")
          end
        end

        output.puts "\n"
        output.puts threads.map(&:value)
      end
    end
  end
end
