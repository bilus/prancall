require File.join(File.dirname(__FILE__), "../lib/selector.rb")

describe Selector do
  context "given objects and their frequency" do
    before(:each) do
      @selector = Selector.new
    end
    it "should return nil if there are no objects" do
      @selector.select({}).should == nil
    end
    it "should return the only object" do
      Kernel.stub!(:rand).and_return(3)
      @selector.select({"x" => 6}).should == "x"
    end
     it "should return the only object" do
      @selector.select({"x" => 6}).should == "x"
    end
    it "should return random object based on frequency" do
      @objects = {"x" => 6, "y" => 4, "z" => 2}
      Kernel.should_receive(:rand).with(12).and_return(5)
      @selector.select(@objects).should == "x"
      Kernel.should_receive(:rand).with(12).and_return(6)
      @selector.select(@objects).should == "y"
      Kernel.should_receive(:rand).with(12).and_return(9)
      @selector.select(@objects).should == "y"
      Kernel.should_receive(:rand).with(12).and_return(10)
      @selector.select(@objects).should == "z"
    end
  end
end