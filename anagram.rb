#/usr/bin/env ruby

if File.exists?('/usr/share/dict/words')
  dictsrc = '/usr/share/dict/words'
elsif File.exists?('/usr/dict/words')
  dictsrc = '/usr/dist/words'
else
  puts "No dictionary file found. Try supplying one with $ruby anagram.rb DICTSRC"
  exit
end

if ARGV.size != 0
  dictsrc = ARGV[0]
end

dict = IO.read(dictsrc).split(/\n/)
dict2 = []
index = []
barSize = 40

continue = false

until continue
  print "Enter a word: "
  word = gets.chomp
  if word.size > 10
    puts "That word's too long; it will freeze your shit. Try a new word"
  elsif word.size > 8
    puts "That's a big word, it might take a while. Are you sure? y to continue, anything else for new word"
    if gets.chomp == "y"
      continue = true
    end
  else
    continue = true
  end
end

#only use words from the dictionary that are letters (for indexing) or of the same length as the input word
dict.each {|w| if w.size == word.size || w.size == 1 then dict2.push(w) end}

beginT = Time.now()
#index the dictionary for quicker lookups
('a'..'z').to_a.each do |l| 
  index.push(dict2.find_index(l))
end
index.push(dict2.size)

#generate permutations
letters = word.split(//)
words = []
i = 0.0
beginpT = Time.now()
letters.permutation.to_a.each do |p| 
  p = p.join
  words.push(p)
  #i+=1.0
  #per = ((i/s)*barSize).floor
  #print "\r["+"="*per+" "*(barSize-per)+"]"
end
words.uniq!
puts "\n#{words.size} unique permutations generated in #{Time.now() - beginpT}s"
puts "comparing permutations to dictionary..."

#check them against the indexed dictionary
i = 0.0
final = []
words.each do |w|
  fl = w.downcase[0] - 97
  if dict2[index[fl]..index[fl + 1]].include?(w) && !final.include?(w)
    final.push(w)
  end
  i += 1.0
  per = ((i / words.size) * barSize).floor
  print "\r[" + "=" * per + " " * (barSize-per) + "]"
end
print "\n\nResults:\n"
final.each {|w| print w,"\n"}
puts "Total elapsed time: #{Time.now() - beginT}s"
