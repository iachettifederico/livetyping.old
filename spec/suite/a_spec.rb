# frozen_string_literal: true

require "awesome_print"
AwesomePrint.defaults = {
  indent: 2,
  index:  false,
}

require "livetyping/tracker"

RSpec.describe LiveTyping::Tracker do
  let(:tracker) { LiveTyping::Tracker.load }

  def track!(&block)
    fork do
      tracker.start
      block.call
      tracker.stop
    end
    Process.wait
  end

  describe "starting and stopping" do
    it "can start" do
      tracker = LiveTyping::Tracker.load

      tracker.start

      expect(tracker.started?).to eq(true)

      tracker.stop
    end

    it "can stop" do
      tracker = LiveTyping::Tracker.load

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
    around do |example|
      remove_constants_defined_in_block do
        example.run
      end
    end

    it "does something" do
      tracker = LiveTyping::Tracker.load
      mark = mark_here!(offset: 2)
      tracker.start

      tracker.stop

      arguments = mark.slice(:source_file, :line).merge(column: 0)

      expect(tracker.whats_on(**arguments)).to eq(LiveTyping::NoTypeInformation.new)
    end
  end
end
