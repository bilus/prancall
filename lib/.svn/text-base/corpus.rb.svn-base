class Corpus
  def initialize(io)
    @io = io
  end
  def words
    @cached_words ||= read_words
  end
  def each_word
    words.each_with_index do |w, i|
      yield(w) if block_given?
    end
  end
  
  private
  
  def read_words
    result = []
    @io.rewind
    while line = @io.gets
      result = result + line.split(/[^a-zA-Z]/).reject {|w| w.empty?}.map {|w| w.upcase}
    end
    result
  end
  
end

