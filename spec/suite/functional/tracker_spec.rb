# frozen_string_literal: true

RSpec.describe Livetyping::Tracker do
  let(:tracker) { Livetyping::Tracker.load }

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
      tracker = Livetyping::Tracker.load

      project_root = tracker.project_root

      expect(project_root).to eq(Pathname.new(__dir__).join("../../../").expand_path)
    end

    it "TODO: find using the Gemfile or other methods"
  end

  describe "tracking" do
    context "with an empty line" do
      it "shows to type information on an empty line" do
        tracker = Livetyping::Tracker.load
        mark = mark_here!(offset: 2)
        tracker.start

        tracker.stop

        code_location = mark.slice(:source_file, :line).merge(column: 0)

        expect(tracker.whats_on(**code_location)).to eq({ types: [] })
      end
    end

    context "with a line with a variable in it" do
      let(:tracker) { Livetyping::Tracker.load }

      it "can track a local variable if the column is at the beginning of the variable name" do
        mark = mark_here!(offset: 3)
        tracker.start
        a_local_variable = "a local variable"
        a_local_variable.chomp
        tracker.stop
        code_location = mark.slice(:source_file, :line).merge(column: 8)

        expect(tracker.whats_on(**code_location)).to eq({ types: ["String"] })
      end

      it "doesn't track if the column is before the variable" do
        mark = mark_here!(offset: 3)
        tracker.start
        a_local_variable = "a local variable"
        a_local_variable.chomp
        tracker.stop
        code_location = mark.slice(:source_file, :line).merge(column: 7)

        expect(tracker.whats_on(**code_location)).to eq({ types: [] })
      end

      it "doesn't track if the column is after the variable" do
        mark = mark_here!(offset: 3)
        tracker.start
        a_local_variable = "a local variable"
        a_local_variable.chomp
        tracker.stop
        code_location = mark.slice(:source_file, :line).merge(column: 30)

        expect(tracker.whats_on(**code_location)).to eq({ types: [] })
      end

      it "can track a local variable if the column is inside the variable name" do
        mark = mark_here!(offset: 3)
        tracker.start
        a_local_variable = "a local variable"
        a_local_variable.chomp
        tracker.stop
        code_location = mark.slice(:source_file, :line).merge(column: 10)

        expect(tracker.whats_on(**code_location)).to eq({ types: ["String"] })
      end

      it "can track a local variable if the column is inside another variable name" do
        mark = mark_here!(offset: 3)
        tracker.start
        another_local_variable = "another local variable"
        another_local_variable.chomp
        tracker.stop
        code_location = mark.slice(:source_file, :line).merge(column: 12)

        expect(tracker.whats_on(**code_location)).to eq({ types: ["String"] })
      end

      it "can track a local variable if the column is inside another variable name and it's of another type" do
        mark = mark_here!(offset: 3)
        tracker.start
        another_local_variable = :im_a_symbol
        another_local_variable.to_s
        tracker.stop
        code_location = mark.slice(:source_file, :line).merge(column: 12)

        expect(tracker.whats_on(**code_location)).to eq({ types: ["Symbol"] })
      end
    end

    context "can track a local variable with multiple types" do
      it "can track a local variable if the column is inside another variable name and it's of another type" do
        mark = mark_here!(offset: 4)
        tracker.start
        some_local_variable = :im_a_symbol
        some_local_variable = 3
        some_local_variable.to_s
        tracker.stop
        code_location = mark.slice(:source_file, :line).merge(column: 12)

        expect(tracker.whats_on(**code_location)).to eq({ types: ["Symbol", "Integer"] })
      end
    end
  end
end
