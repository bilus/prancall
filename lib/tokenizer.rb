class Tokenizer
  
  def initialize(options = {})
    @pred_len = options[:pred_len] || 1
    @succ_len = 1
    raise "This simple algorithm doesn't support these params." if @pred_len > 2
  end
  
  def tokenize(word, &block)
    if tokens = do_tokenize(word)
      tokens.each {|p, s, f| yield(p, s, f)} if block_given?
    end
    tokens
  end
  
  def last(word)
    collect_tokens(word).last
  end
  
  private
  
  def collect_tokens(text)
    text.each_char.each_cons(@pred_len).inject([]) do |tokens, token| 
      tokens + [token.join]
    end
  end
  
  def do_tokenize(text)
    if (tokens = collect_tokens(text)).size > 1
      [[make_predecessor(tokens[0]), make_successor(tokens[1]), :start]] + tokens.slice(1..tokens.size).each_cons(2).inject([]) do |a, ps|
        p, s = ps
        a + [[make_predecessor(p), make_successor(s), :tail]]
      end
    end
  end
  
  def make_predecessor(p)
    p[0, @pred_len]
  end
  def make_successor(s)
    s[-1, @succ_len]
    #~ s
  end
end