require File.join(File.dirname(__FILE__), "../lib/word_generator.rb")

describe WordGenerator do
  before(:each) do
    @producer = mock("producer", :null_object => true)
    @generator = WordGenerator.new(@producer)
  end
  it "should generate new word using producer" do
    @producer.should_receive(:produce).with("").and_return("ma")
    @producer.should_receive(:produce).with("ma").and_return("r")
    @producer.should_receive(:produce).with("mar").and_return("c")
    @producer.should_receive(:produce).with("marc").and_return("i")
    @producer.should_receive(:produce).with("marci").and_return("n")
    @generator.generate(6).should == "marcin"
  end
  it "should not end generating until word is well formed" do
    @producer.stub!(:produce).and_return("X")
    @producer.should_receive(:well_formed?).exactly(4).times.and_return(false, false, false, true)
    @generator.generate(3).length.should == 6
  end
end