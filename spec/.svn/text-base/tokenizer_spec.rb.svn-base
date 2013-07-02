require File.join(File.dirname(__FILE__), "../lib/tokenizer.rb")

describe Tokenizer do
  context("1 token predecessor and 1 token successor") do
    before(:each) do
      @tokenizer = Tokenizer.new
    end
    it "should return predecessors and successors with marked word beginnings for every letter if no block given" do
      expected_results = [["m", "a", :start], ["a", "r", :tail], ["r", "c", :tail], ["c", "i", :tail], ["i", "n", :tail]]
      @tokenizer.tokenize("marcin").should == expected_results
    end
    it "should yield predecessors and successors and word beginnings if block given" do
      results = []
      @tokenizer.tokenize("marcin") {|a, b, c| results << [a, b, c]}
      results.should == @tokenizer.tokenize("marcin")
    end
    it "should return last token" do
      @tokenizer.last("marcin").should == "n"
    end
  end
  context("2 token predecessor and 1 token successor") do
    before(:each) do
      @tokenizer = Tokenizer.new(:pred_len => 2)
    end
    it "should return predecessors and successors for every letter if no block given" do
      expected_results = [["ma", "r", :start], ["ar", "c", :tail], ["rc", "i", :tail], ["ci", "n", :tail]]
      @tokenizer.tokenize("marcin").should == expected_results
    end
    it "should return last token" do
      @tokenizer.last("marcin").should == "in"
    end
  end
end