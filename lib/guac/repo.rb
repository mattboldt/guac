# frozen_string_literal: true

require_relative 'sys_command'

module Guac
  class Repo
    attr_reader :name, :dir

    def initialize(config, repo, branch = nil)
      @config = config
      @repo   = repo
      @name   = repo[:name]
      @dir    = repo[:dir]
      @branch = branch || config[:default_branch]
    end

    def branch
      aliases = @repo[:branch_aliases]
      if aliases
        aliases[@branch] || @branch
      else
        @branch
      end
    end

    def status
      SysCommand.run(@dir, %w(git status))
    end

    def checkout
      SysCommand.run(@dir, %W(git checkout #{branch}))
    end

    def pull
      pull_cmd =
        @config[:pull_strategy] ? @config[:pull_strategy] : @defaults[:pull_strategy]
      pull_cmd = pull_cmd.split(/ \s*/)

      SysCommand.run(@dir, pull_cmd)
    end
  end
end
