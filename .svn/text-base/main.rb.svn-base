require File.join(File.dirname(__FILE__), "lib/tokenizer.rb")
require File.join(File.dirname(__FILE__), "lib/successor_chain_builder.rb")
require File.join(File.dirname(__FILE__), "lib/successor_chain.rb")
require File.join(File.dirname(__FILE__), "lib/corpus.rb")
require File.join(File.dirname(__FILE__), "lib/word_generator.rb")
require File.join(File.dirname(__FILE__), "lib/successor_producer.rb")
require File.join(File.dirname(__FILE__), "lib/selector.rb")

def add_extra_seed(strength, in_fname, tokenizer, chain)
  puts "Adding seed based on data in #{in_fname}"
  word_number = 0
  num_words = nil
  corpus = Corpus.new(File.open(in_fname, "r"))
  scb = SuccessorChainBuilder.new(tokenizer, chain,
    :on_start => lambda do |num| 
      unless num_words
        num_words = num * strength
        puts "Seed words: #{num_words}"
      end
    end,
    :on_word => lambda do |word| 
      print ". #{word_number}" if 0 == word_number || 0 == word_number.modulo(num_words / 100 + 1)
      word_number = word_number + 1
    end)

  strength.to_i.times do
    scb.build(corpus)
  end
end

in_fname = ARGV[0]
tokenizer = Tokenizer.new(:pred_len => 2)
chain = SuccessorChain.new

if File.extname(in_fname) == ".sch"
  num_words = (ARGV[1] || 10).to_i
  word_len = (ARGV[2] || 5 + rand(6)).to_i
  puts "Generating up to #{num_words} words (approx length: #{word_len}) based on data in #{in_fname}"
  chain.load(File.open(in_fname, "r"))
  add_extra_seed((ARGV[4] || 2000).to_i, ARGV[3], tokenizer, chain) if ARGV[3]
  producer = SuccessorProducer.new(chain, Selector.new, tokenizer)
  gen = WordGenerator.new(producer)
  num_words.times do 
    puts gen.generate(word_len).downcase.capitalize rescue "FAILURE!"
  end
else
  puts "Building data based on corpus in #{in_fname}"
  word_number = 0
  num_words = 0
  corpus = Corpus.new(File.open(in_fname, "r"))
  scb = SuccessorChainBuilder.new(tokenizer, chain,
    :on_start => lambda {|num| num_words = num; puts "Corpus words: #{num_words}"},
    :on_word => lambda {|word| word_number = word_number + 1; print ". #{word_number}" if 0 == word_number || 0 == word_number.modulo(num_words / 100 + 1)})
  scb.build(corpus)
  out_fname = in_fname.chomp(File.extname(in_fname)) + ".sch"
  chain.save(File.open(out_fname, "w+"))
  puts "Data generated and saved to #{out_fname}"
end



# TODO
# 
# IDEA1 Fitness - how difficult it is to pronounce a word (certain sequences are difficult to pronounce).
# IDEA2 Seed corpus with (repeated) user words.