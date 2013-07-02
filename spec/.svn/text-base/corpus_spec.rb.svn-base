require File.join(File.dirname(__FILE__), "../lib/corpus.rb")

describe Corpus do
  before(:each) do
    @io = mock("io", :null_object => true)
    @corpus = Corpus.new(@io)
  end
  it "should read text from an IO object and split it into words (capitalized)" do
    @io.should_receive(:gets).and_return("To be, or not to be: that is the question:", nil)
    @corpus.words.should == ["TO", "BE", "OR", "NOT", "TO", "BE", "THAT", "IS", "THE", "QUESTION"]
  end
  it "should let iterate over the words" do
    @io.should_receive(:gets).and_return("To be, or not to be: that is the question:", nil)
    words = []
    @corpus.each_word {|word| words << word}
    words.should == @corpus.words
  end
end