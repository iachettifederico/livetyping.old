# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
# loader.inflector.inflect("livetyping" => "LiveTyping")
loader.setup

module Livetyping
end
