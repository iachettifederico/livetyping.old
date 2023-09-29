# frozen_string_literal: true

require "pathname"

module LiveTyping
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

    def project_root
      Pathname(__dir__).join("../../").expand_path
    end

    private

    def initialize
      @started = false
    end
  end
end
