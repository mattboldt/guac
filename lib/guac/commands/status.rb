# frozen_string_literal: true

require_relative '../config'
require_relative '../repo'
require_relative '../colors'

module Guac
  module Commands
    class Status
      def initialize(options)
        @options = options
        @config = Guac::Config.load
        @repos = @config[:repos].map { |r| Guac::Repo.new(@config, r) }
      end

      def execute(input: $stdin, output: $stdout)
        threads = @repos.map do |repo|
          Thread.new do
            response = [repo.status]
            response = Colors.paint(response)
            response.unshift(repo.name.bold.colorize(:blue))

            response.join("\n")
          end
        end

        puts threads.map(&:value)
      end
    end
  end
end
