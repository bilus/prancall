# Generates words based on producer's output.
#
class WordGenerator
  def initialize(producer)
    @producer = producer
  end
  def generate(word_length)
    word = ""
    until word.length >= word_length && @producer.well_formed?(word)
      word << @producer.produce(word)
    end
    word
  end
end