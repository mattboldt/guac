# frozen_string_literal: true

require_relative '../command'
require_relative '../config'
require 'yaml'
require 'rainbow'

module GitPa
  module Commands
    class Config < GitPa::Command

      def initialize(options)
        @options = options
        @config = GitPa::Config.load
      end

      def execute(input: $stdin, output: $stdout)
        body = @config ? @config : {}

        result = prompt.ask('Repo names (separated by spaces)', required: true)
        body[:repos] = result.split(/ \s*/)

        file = File.new(GitPa::Config::CONFIG_FILE, 'w')
        file.puts(body.to_yaml)
        file.close

        output.puts 'Config saved in ~/.git_parc'.green
      end
    end
  end
end
