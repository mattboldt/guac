# frozen_string_literal: true

require 'open3'

module GitPa
  class Git
    attr_accessor :branch

    def initialize(repo, branch = nil)
      @repo = repo
      @branch = @repo.branch_alias(branch) if branch
      @config = GitPa::Config.load
      @defaults = GitPa::Config.defaults
    end

    def status
      sys_command(@repo.dir, %w(git status))
    end

    def checkout
      sys_command(@repo.dir, %W(git checkout #{@branch}))
    end

    def pull
      pull_cmd = @config[:pull_strategy] ? @config[:pull_strategy] : @defaults[:pull_strategy]
      pull_cmd = pull_cmd.split(/ \s*/)

      sys_command(@repo.dir, pull_cmd)
    end

    private

    def sys_command(dir, commands = [])
      stdin, stdout, stderr, wait_thr = Open3.popen3(*commands, chdir: @repo.dir)
      output = stdout.gets(nil)
      error = stderr.gets(nil)
      exit_status = wait_thr.value

      stdout.close
      stderr.close

      output
    end
  end
end
