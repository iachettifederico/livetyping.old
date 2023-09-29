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

    def whats_on(source_file:, line:, column:)
      NoTypeInformation.new
    end

    def project_root
      Pathname(__dir__).join("../../").expand_path
    end

    private

    def initialize
      @started = false
    end
  end

  class NoTypeInformation
    def ==(other)
      other.is_a?(self.class)
    end
  end
end
