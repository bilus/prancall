require File.join(File.dirname(__FILE__), "../lib/successor_producer.rb")

describe SuccessorProducer do
  before(:each) do
    @successor_chain = mock("successor_chain")
    @selector = mock("selector")
    @tokenizer = mock("tokenizer")
    @producer = SuccessorProducer.new(@successor_chain, @selector, @tokenizer)
  end
  it "should produce the word beginning" do
    @successor_chain.should_receive(:starts).and_return("starts") 
    @selector.should_receive(:select).with("starts").and_return("m")
    @producer.produce("").should == "m"
  end
  it "should produce a successor based on current word's last token" do
    @tokenizer.should_receive(:last).with("marci").and_return("i")
    @successor_chain.should_receive(:successors_for).with("i").and_return("successors")
    @selector.should_receive(:select).with("successors").and_return("n")
    @producer.produce("marci").should == "n"
  end
  it "should determine if word is well-formed based on whether it has proper ending" do
    @tokenizer.should_receive(:last).with("marcin").and_return("n")
    @successor_chain.should_receive(:ending?).with("n").and_return(true)
    @producer.well_formed?("marcin").should be_true
  end
end
    