sites = []
File.open("top-1m.csv") do |file|
  while line = file.gets
    sites << line[/^[0-9]+,([^\.]+)\..*$/,1]
  end
end

File.open("sites.txt", "w+") do |file|
  file.write(sites.join(" "))
end