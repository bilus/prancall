class SuccessorChainBuilder
  def initialize(tokenizer, chain, options = {})
    @tokenizer = tokenizer
    @chain = chain
    @on_start = options[:on_start] || lambda {|word| }
    @on_word = options[:on_word] || lambda {|word| }
  end
  def build(corpus)
    @on_start.call(corpus.words.size)
    corpus.each_word do |word|
      @on_word.call(word)
      @tokenizer.tokenize(word) do |predecessor, successor, position|
        @chain.add_start(predecessor) if position == :start
        @chain.add(predecessor, successor)
      end
      @chain.add_end(@tokenizer.last(word))
    end
  end
end
