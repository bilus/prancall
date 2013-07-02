class SuccessorChain
  
  WORD_START = "@@WORD_START@@"
  WORD_END = "@@WORD_END@@"
  
  def initialize
    @freqs = {}
  end
  def load(io)
    @freqs = Marshal.load(io)
    size = @freqs.size
    sum = @freqs.inject(0) {|sum, f| sum + f[1].size}
    max = @freqs.inject(0) {|max, f| f[1].size > max[1] ? [f[0], f[1].size] : max}
    avg = sum / size
    puts "size = #{size} sum = #{sum} max = #{max.inspect} avg = #{avg}"
  end
  def save(io)
    Marshal.dump(@freqs, io)
  end
  def successors_for(predecessor)
    @freqs[predecessor] || {}
  end
  def add(predecessor, successor)
    entry = @freqs[predecessor]
    if entry
      entry[successor] = entry[successor] ? entry[successor] + 1 : 1
    else
      @freqs[predecessor] = {successor => 1}
    end
  end
  def add_start(word_start)
    add(WORD_START, word_start)
  end
  def add_end(word_end)
    add(WORD_END, word_end)
  end
  def starts
    successors_for(WORD_START)
  end
  def ending?(token)
    successors_for(WORD_END).include?(token)
  end
end