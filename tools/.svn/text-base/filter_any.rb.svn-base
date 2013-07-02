File.open(ARGV[0]) do |file|
  while line = file.gets
    if word = line[/^([a-zA-Z]+)$/, 1]
      puts word
    end
  end
end