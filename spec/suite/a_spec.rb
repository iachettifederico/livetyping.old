# frozen_string_literal: true

require "livetyping/tracker"

RSpec.describe "Something" do
  it "can start" do
    tracker = Livetyping::Tracker.load

    tracker.start

    expect(tracker.started?).to eq(true)

    tracker.stop
  end

  it "can stop" do
    tracker = Livetyping::Tracker.load

    tracker.start
    tracker.stop

    expect(tracker.started?).to eq(false)
  end
end
