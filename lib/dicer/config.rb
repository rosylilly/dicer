require 'singleton'

module Dicer
  class Config
    attr_accessor :auto_supply

    def initialize
      @auto_supply = false
    end
  end

  def self.config
    @config ||= Config.new
  end
end
