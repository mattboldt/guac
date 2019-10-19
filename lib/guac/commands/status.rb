require_relative '../repo'
require_relative '../colors'

module Guac
  module Commands
    class Status
      def initialize(options)
        @options = options
        @repos = Guac::Repo.build_from_config
      end

      def execute(_input: $stdin, output: $stdout)
        threads = @repos.map do |repo|
          Thread.new do
            response = [repo.status]
            response = Colors.paint(response)
            response.unshift(repo.name.bold.colorize(:blue))

            response.join("\n")
          end
        end

        output.puts threads.map(&:value)
      end
    end
  end
end
