# frozen_string_literal: true

require "awesome_print"
AwesomePrint.defaults = {
  indent: 2,
  index:  false,
}

require "livetyping/tracker"

RSpec.describe Livetyping::Tracker do
  let(:tracker) { Livetyping::Tracker.load }

  def track!(&block)
    tracker.start
    block.call
    tracker.stop
  end

  describe "starting and stopping" do
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

  describe "finding the project's root directory" do
    it "can calculate the root of the current project" do
      tracker = LiveTyping::Tracker.load

      project_root = tracker.project_root

      expect(project_root).to eq(Pathname.new(__dir__).join("../../").expand_path)
    end

    it "TODO: find using the Gemfile or other methods"
  end

  describe "tracking" do
    it "does something" do
      obj = Object.new
      track! do
        
      end

      puts Hola
    end
  end
end
