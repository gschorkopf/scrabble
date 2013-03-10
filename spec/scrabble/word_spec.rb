require 'spec_helper'

describe Scrabble::Word do
  let (:app) { described_class }

  describe "initialize" do
    it "stores the string as a word attr" do
      word = app.new("apple")
      expect( word.word ).to eq "apple"
    end

    it "downcases any strings passed through" do
      word = app.new("aPpLe")
      expect( word.word ).to eq "apple"
    end
  end

  describe "#score" do
    it "returns the score of the stored word" do
      letter = app.new("a")
      word = app.new("apple")
      expect( letter.score ).to eq 1
      expect( word.score ).to eq 9
    end
  end

  describe "#letters" do
    it "returns an array of the words letters" do
      word = app.new("apple")
      expect( word.letters ).to eq %w(a p p l e)
    end
  end

  describe ".alphabet" do
    it "returns the value of a single letter" do
      expect( app.alphabet['a'] ).to eq 1
      expect( app.alphabet['j'] ).to eq 8
    end
  end
end