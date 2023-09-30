# frozen_string_literal: true

require "livetyping"

RSpec.describe "Livetyping::TokenUnder" do
  it "does something" do
    token_under = Livetyping::TokenUnder.for(code: "", column: 0)

    expect(token_under.to_s).to eq("")
  end

  it "does something" do
    token_under = Livetyping::TokenUnder.for(code: "a", column: 0)

    expect(token_under.to_s).to eq("a")
  end

  it "does something" do
    token_under = Livetyping::TokenUnder.for(code: " ", column: 0)

    expect(token_under.to_s).to eq("")
  end

  it "does something" do
    token_under = Livetyping::TokenUnder.for(code: "\t  \n", column: 0)

    expect(token_under.to_s).to eq("")
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
