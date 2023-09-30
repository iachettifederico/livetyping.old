# frozen_string_literal: true

module Livetyping
  class TokenUnder
    def self.for(code:, column:)
      new(code: code, column: column)
    end

    def to_s
      if column >= code.size
        ""
      else
        code.to_s
      end
    end

    private

    attr_reader :code
    attr_reader :column

    def initialize(code:, column:)
      @code   = Code.for_string(code)
      @column = column
    end
  end
end
