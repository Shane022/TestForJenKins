
#!/usr/bin/ruby

changelog =`git log --oneline`
curFilePath =`pwd`

# write File
file = File.open("222.txt","w+")
# file.puts "123\nwadwa\n12124124\ndwdw"
file.syswrite("#{changelog}")
file.close

# file = File.open("222.txt", "r")
# file.each_line do |line|
# 	puts line
# end


arr = IO.read("222.txt")
final = /^#([^#]+)/m.match(arr)
puts final

# filterChangelog = /#(.+)/.match("#{changelog}")





