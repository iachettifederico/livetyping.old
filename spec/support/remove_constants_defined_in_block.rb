# frozen_string_literal: true

def remove_constants_defined_in_block(&block)
  constants_at_start = Object.constants

  block.call

  (Object.constants - constants_at_start).each do |constant|
    Object.send(:remove_const, constant)
  end
end
