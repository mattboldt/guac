# frozen_string_literal: true

require_relative '../command'
require_relative '../config'
require_relative '../repo'
require_relative '../colors'
require_relative '../sys_command'
require 'pry'

module Guac
  module Commands
    class Up < Guac::Command
      def initialize(options)
        @options = options
        @config = Guac::Config.load
        @repos = @config[:repos].map do |repo|
          Guac::Repo.new(@config, repo, @options[:branch])
        end
      end

      def execute(input: $stdin, output: $stdout)
        @repos.each do |repo|
          output.puts "Updating #{repo.name.bold} on branch #{repo.branch.underline}".colorize(:blue)
          response = []

          begin
            repo.checkout
            response << repo.pull
          rescue Guac::SysCommandError => e
            output.puts e.message.colorize(:red)
            break
          end

          response.compact!
          color, response = Colors.paint(response)
          output.puts response.join("\n")
          break if color == :red
        end
      end
    end
  end
end
