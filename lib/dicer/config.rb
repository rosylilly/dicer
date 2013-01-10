require 'singleton'

module Dicer
  class Config
    attr_accessor :auto_supply

    def initialize
      @auto_supply = true
    end
  end

  def self.config
    @config ||= Config.new
  end
end
