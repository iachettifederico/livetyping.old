# frozen_string_literal: true

require "rake"

RSpec.configure do |config|
  config.order = :random
end

FileList["./spec/support/**/*.rb"].each do |file|
  require File.expand_path(file)
end
