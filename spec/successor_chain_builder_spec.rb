require File.join(File.dirname(__FILE__), "../lib/successor_chain_builder.rb")

describe SuccessorChainBuilder do
  before(:each) do
    @tokenizer= mock("tokenizer", :null_object => true) 
    @chain = mock("chain", :null_object => true)
    @words = mock("words", :null_object => true)
  end
  it "should build the chain based on input from tokenizer" do
    @words.should_receive(:each_word).and_yield("word1").and_yield("word2")
    @words.stub!(:size).and_return(2)
    @tokenizer.should_receive(:tokenize).with("word1").and_yield("pred1", "succ1", :start).and_yield("pred2", "succ2", :tail)
    @tokenizer.should_receive(:tokenize).with("word2").and_yield("pred3", "succ3", :start).and_yield("pred4", "succ4", :tail)
    @chain.should_receive(:add_start).with("pred1")
    @chain.should_receive(:add).with("pred1", "succ1")
    @chain.should_receive(:add).with("pred2", "succ2")
    @tokenizer.should_receive(:last).with("word1").and_return("succ2")
    @chain.should_receive(:add_end).with("succ2")
    @chain.should_receive(:add_start).with("pred3")
    @chain.should_receive(:add).with("pred3", "succ3")
    @chain.should_receive(:add).with("pred4", "succ4")
    @tokenizer.should_receive(:last).with("word2").and_return("succ4")
    @chain.should_receive(:add_end).with("succ4")
    builder = SuccessorChainBuilder.new(@tokenizer, @chain)
    builder.build(@words)
  end
  it "should allow for progress tracking" do
    @words.stub!(:size).and_return(2)
    @words.stub!(:each_word).and_yield("word1").and_yield("word2")
    
    handler = mock("handler")
    handler.should_receive(:on_start).with(2)
    handler.should_receive(:on_word).once.with("word1")
    handler.should_receive(:on_word).once.with("word2")
    builder = SuccessorChainBuilder.new(@tokenizer, @chain, 
      :on_start => lambda {|count| handler.on_start(count)},
      :on_word => lambda {|word| handler.on_word(word)})
    builder.build(@words)
    
  end
end