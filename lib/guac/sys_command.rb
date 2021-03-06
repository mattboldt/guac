# frozen_string_literal: true

require 'open3'

module Guac
  class SysCommand
    class << self
      def run(dir, commands = [])
        stdin, stdout, stderr, wait_thr = Open3.popen3(*commands, chdir: dir)
        output = stdout.gets(nil)
        error = stderr.gets(nil)
        exit_status = wait_thr.value

        stdout.close
        stderr.close

        if output.nil? && error
          raise SysCommandError, error
        end

        output
      end
    end
  end

  class SysCommandError < StandardError
  end
end
