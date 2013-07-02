#~ corpus = ""
#~ File.open(ARGV[0]) { |f|  corpus = words(f.read) } 
corpus = %w{ ewelina marcin }

mc = {}

def words(text)
  text.split(/[^a-zA-Z]/)
end

PREV_LEN = 2
START = "@" * PREV_LEN

puts START

corpus.each do |word|
  if word.size > 3
    #~ puts "'#{word}'"
    prev_letter = START
    word.upcase.each_char do |letter|
      if prev_letter.size == PREV_LEN
        if info = mc[prev_letter]
          freq = info[letter]
          unless freq.nil?
            info[letter] = freq + 1
          else
            info[letter] = 1
          end
        else
          mc[prev_letter] = { letter => 1 }
        end
        prev_letter = letter
      else
        prev_letter << letter
      end
    end
  end
end




mc.each do |letter, info|
  puts "#{letter.nil? ? 'START' : letter}:"
  info.each do |next_letter, freq|
    puts "\t#{next_letter} (#{freq})"
  end
end

10.times do

  def next_letter(mc, prev_letter)
    info = mc[prev_letter]
    total_prob = info.inject(0) {|sum, i| l,f = i; sum + f}
    freq_threshold = rand(total_prob + 1)
    freq_sum = 0
    info.each do |letter, freq|
      freq_sum = freq_sum + freq
      if freq_sum >= freq_threshold
        return letter
      end
    end
    raise "Error #{freq_threshold} #{total_prob}"
  end

  word_length = 5 + rand(7)
  prev_letter = START
  word = ""

  while word.size < word_length
    puts prev_letter.inspect
    letter = next_letter(mc, prev_letter)
    word << letter
    prev_letter = letter
  end

  puts word
end