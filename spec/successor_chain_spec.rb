require File.join(File.dirname(__FILE__), "../lib/successor_chain.rb")

describe SuccessorChain do
  before(:each) do 
    @chain = SuccessorChain.new
  end
  context "given a list of predecessor-successor entries" do
    before(:each) do
      @entries = [["m", "a"], ["a", "r"], ["r", "c"], ["c", "i"], ["i", "n"], 
        ["m", "a"], ["a", "r"], ["r", "t"], ["t", "a"]]
      @entries.each do |p, s|
        @chain.add(p, s)
      end
    end
    it "should return successors and their frequencies" do
      @chain.successors_for("m").should == {"a" => 2}
      @chain.successors_for("a").should == {"r" => 2}
      @chain.successors_for("r").should == {"c" => 1, "t" => 1}
      @chain.successors_for("c").should == {"i" => 1}
      @chain.successors_for("i").should == {"n" => 1}
      @chain.successors_for("t").should == {"a" => 1}
    end
    it "should return an empty hash for undefined predecessor" do
      @chain.successors_for("x").should == {}
    end
    it "should return word beginnings and their frequencies" do
      @chain.starts.should == {}
      @chain.add_start("m")
      @chain.add_start("m")
      @chain.add_start("e")
      @chain.starts.should == {"m" => 2, "e" => 1}
    end
    it "should determine whether a token is a valid ending" do
      @chain.add_end("n")
      @chain.ending?("n").should be_true
      @chain.ending?("c").should be_false
    end
  end
  it "should load from and save to file" do
    @chain.add_start("m")
    @chain.add_start("m")
    @chain.add_start("e")
    @chain.add_end("n")
    @chain.add("m", "a")
    @chain.add("m", "a")
    @chain.add("a", "r")
    io = StringIO.new
    @chain.save(io)
    
    new_chain = SuccessorChain.new
    io.rewind
    new_chain.load(io)
    new_chain.ending?("n").should be_true
    new_chain.ending?("c").should be_false
    new_chain.starts.should == {"m" => 2, "e" => 1}
    new_chain.successors_for("m").should == {"a" => 2}
    new_chain.successors_for("a").should == {"r" => 1}
  end  
end