# frozen_string_literal: true

require "rake"
require "livetyping"

require "awesome_print"
AwesomePrint.defaults = {
  indent: 2,
  index:  false,
}

RSpec.configure do |config|
  config.order = :random
end

FileList["./spec/support/**/*.rb"].each do |file|
  require File.expand_path(file)
end
