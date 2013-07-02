class SuccessorProducer
  def initialize(successor_chain, selector, tokenizer)
    @successor_chain = successor_chain
    @selector = selector
    @tokenizer = tokenizer
  end
  def produce(word)
      @selector.select(word.empty? || word.nil? ? @successor_chain.starts : @successor_chain.successors_for(@tokenizer.last(word)))
  end
  def well_formed?(word)
    @successor_chain.ending?(@tokenizer.last(word))
  end
end

