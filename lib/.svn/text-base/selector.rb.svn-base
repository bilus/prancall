class Selector
  def select(source)
    return nil if source.empty?
    total_freq = source.to_a.inject(0) {|total, of| o, freq= of; total+ freq}
    freq_sum = 0
    pick = Kernel.rand(total_freq)
    # Reverse-sort by frequency to ensure more frequent objects are picked more often.
    reverse_sort_by_freq(source.to_a).each do |object, freq|
      freq_sum = freq_sum + freq
      return object if pick < freq_sum
    end
    raise "Internal error - random number out of range"
  end
  
  private
  
  def reverse_sort_by_freq(source)
    source.sort{|l, r| r.last <=> l.last}
  end
end