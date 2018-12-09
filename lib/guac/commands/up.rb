# frozen_string_literal: true

require_relative '../config'
require_relative '../repo'
require_relative '../colors'
require_relative '../sys_command'
# require 'pry'

module Guac
  module Commands
    class Up
      def initialize(options)
        @options = options
        @config = Guac::Config.load
        @repos = @config[:repos].map do |repo|
          Guac::Repo.new(@config, repo, ARGV[1])
        end
      end

      def execute
        threads = @repos.map do |repo|
          puts "Updating #{repo.name.bold} on branch #{repo.branch.underline}".colorize(:blue)

          Thread.new do
            response = []

            begin
              repo.checkout
              response << repo.pull
            rescue Guac::SysCommandError => e
              response << e.message.colorize(:red)
              break
            end

            response.compact!
            response = Colors.paint(response)
            response.unshift(repo.name.bold.colorize(:blue))
            response.join("\n")
          end
        end

        puts '========'
        puts threads.map(&:value)
      end
    end
  end
end
