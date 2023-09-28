# frozen_string_literal: true

module Livetyping
  class Tracker
    def self.load
      new
    end

    def start
      @started = true
    end

    def started?
      @started
    end

    def stop
      @started = false
    end

    private

    def initialize
      @started = false
    end
  end
end
