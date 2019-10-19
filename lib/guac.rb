require "guac/version"

module Guac
  def self.debug?
    !ENV['DEBUG'].nil?
  end
end
