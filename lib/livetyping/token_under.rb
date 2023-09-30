# frozen_string_literal: true

module Livetyping
  class TokenUnder
    def self.for(code:, column:)
      new(code: code, column: column)
    end

    def to_s
      if code =~ /\A\s+\Z/
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

  class Code
    def self.for_string(code_string)
      new(code_string: code_string)
    end

    def to_s
      code_string
    end

    def =~(regex)
      code_string =~ regex
    end

    private

    attr_reader :code_string

    def initialize(code_string:)
      @code_string = code_string
    end
  end
end
