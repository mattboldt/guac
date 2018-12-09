# frozen_string_literal: true

require 'colorize'

class Colors
  class << self
    def paint(ary)
      color =
        if contains?(ary, 'Updating') ||
           contains?(ary, 'Changes not staged for commit') ||
           contains?(ary, 'Your branch is behind')
          :yellow
        elsif contains?(ary, 'Failed') || contains?(ary, 'error:')
          :red
        else
          :green
        end

      [color, ary.map { |r| r.colorize(color) }]
    end

    def contains?(ary, string)
      ary.compact.any? { |r| r.include?(string) }
    end
  end
end
