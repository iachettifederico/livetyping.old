# frozen_string_literal: true

RSpec.describe Livetyping::TokenUnder do
  def token_under(code, column)
    Livetyping::TokenUnder.for(code: code, column: column).to_s
  end

  context "when the code string is empty or just spaces" do
    it { expect(token_under("", -1)).to eq("") }
    it { expect(token_under("", 0)).to eq("") }
    it { expect(token_under(" ", 0)).to eq("") }
    it { expect(token_under("\t  \n", 0)).to eq("") }
  end

  context "when the code string has only one character" do
    it { expect(token_under("a", -1)).to eq("") }
    it { expect(token_under("a", 0)).to eq("a") }

    context "when the column is out of bounds after the code string" do
      it { expect(token_under("a", 1)).to eq("") }

      it { expect(token_under("a", 2)).to eq("") }
    end
  end

  context "when the code string has more than one character" do
    it { expect(token_under("ab", -1)).to eq("") }
    it { expect(token_under("ab", 0)).to eq("ab") }
    it { expect(token_under("ab", 1)).to eq("ab") }
    it { expect(token_under("ab", 2)).to eq("") }
  end

  context "when the code string has empty characters before the code" do
    it { expect(token_under(" a", 0)).to eq("") }
    it { expect(token_under(" a", 1)).to eq("a") }
    it { expect(token_under("  ab", 1)).to eq("") }
    it { expect(token_under("  ab", 3)).to eq("ab") }
    it { expect(token_under("  ab", 4)).to eq("") }
  end

  context "when the string is a method call" do
    it { expect(token_under("a.b", 0)).to eq("a") }
    it { expect(token_under("a.b", 1)).to eq(".") }
    it { expect(token_under("a.b", 2)).to eq("b") }
    it { expect(token_under("ab.cd", 0)).to eq("ab") }
    it { expect(token_under("ab.cd", 1)).to eq("ab") }
    it { expect(token_under("ab.cd", 2)).to eq(".") }
    it { expect(token_under("ab.cd", 3)).to eq("cd") }
    it { expect(token_under("ab.cd", 4)).to eq("cd") }

    it { expect(token_under("  ab.cd", 0)).to eq("") }
    it { expect(token_under("  ab.cd", 1)).to eq("") }
    it { expect(token_under("  ab.cd", 2)).to eq("ab") }
    it { expect(token_under("  ab.cd", 3)).to eq("ab") }
    it { expect(token_under("  ab.cd", 4)).to eq(".") }
    it { expect(token_under("  ab.cd", 5)).to eq("cd") }
    it { expect(token_under("  ab.cd", 6)).to eq("cd") }
  end

  # it "TODO: out of bounds after the string"
  # it "TODO: spaces at the beginning"
  # it "TODO: spaces at the end"
  # it "TODO: out of bounds before the string"
  # it "TODO: one character"
  # it "TODO: two characters"
  # it "TODO: multiple characters"
  # it "TODO: spaces in between"
  # it "TODO: method call"
  # it "TODO: find more examples"
end
