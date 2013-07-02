corpus = ""
File.open(ARGV[0]) { |f|  corpus = f.read } 

mc = {}

def words(text)
  text.split(/[^a-zA-Z]/)
end

words(corpus).each do |word|
  if word.size > 3
    #~ puts "'#{word}'"
    prev_letter = nil
    word.upcase.each_char do |letter|
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
    end
  end
end




mc.each do |letter, info|
  puts "#{letter.nil? ? 'START' : letter}:"
  info.each do |next_letter, freq|
    puts "\t#{next_letter} (#{freq})"
  end
end

30.times do
  word_length = 4 + rand(4)

  prev_letter = nil
  word = ""

  def next_letter(mc, prev_letter)
    #~ puts "** #{prev_letter} **"
    info = mc[prev_letter]
    if info
      total_prob = info.inject(0) {|sum, i| l,f = i; sum + f}
      freq_threshold = rand(total_prob + 1)
      #~ puts "#{freq_threshold} #{total_prob}"
      freq_sum = 0
      info.to_a.sort {|lhs, rhs| rhs.last <=> lhs.last }.each do |letter, freq|
        freq_sum = freq_sum + freq
        #~ puts "#{letter} - #{freq} (#{freq_sum})"
        if freq_sum >= freq_threshold
          return letter
        end
      end
    else
      raise "Error #{freq_threshold} #{total_prob}"
    end
  end

  while word.size < word_length || word[/.*[AUEOYI]$/].nil?
    letter = next_letter(mc, prev_letter)
    word << letter
    prev_letter = letter
  end rescue word

  puts word
end