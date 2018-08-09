# frozen_string_literal: true

require 'colorize'

class Colors
  class << self
    def paint(ary)
      color =
        if contains?(ary, 'Updating')
          :yellow
        elsif contains?(ary, 'Failed') || contains?(ary, 'error:')
          :red
        else
          :green
        end

      [color, ary.map { |r| r.colorize(color) }]
    end

    def contains?(ary, string)
      ary.any? { |r| r.include?(string) }
    end
  end
end
