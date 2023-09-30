# frozen_string_literal: true

module Livetyping
  class TokenUnder
    class Code
      def self.for_string(code_string)
        new(code_string: code_string)
      end

      def to_s
        if code_string =~ /\A\s+\Z/
          ""
        else
          code_string.to_s
        end
      end

      def =~(regex)
        code_string =~ regex
      end

      def size
        code_string.size
      end

      private

      attr_reader :code_string

      def initialize(code_string:)
        @code_string = code_string
      end
    end
  end
end
