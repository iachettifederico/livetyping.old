# frozen_string_literal: true

require "ripper"

module Livetyping
  class TokenUnder
    class Code
      attr_reader :indentation

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

      def token_at_column(original_column)
        column_without_indentation = original_column - indentation

        return "" if out_of_bounds(column_without_indentation)

        tokenized_code = Ripper.tokenize(code_string)

        index = 0
        tokenized_code.each do |token|
          token.chars.each do |_character|
            return token if index == column_without_indentation

            index += 1
          end
        end
      end

      private

      attr_reader :code_string

      def initialize(code_string:)
        @indentation = code_string[/(\A\s+)/, 1].to_s.size
        @code_string = code_string.lstrip
      end

      def out_of_bounds(column)
        column.negative? || column >= code_string.size
      end
    end
  end
end
