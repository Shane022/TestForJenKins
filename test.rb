
#!/usr/bin/ruby

changelog =`git log --oneline release_1.0...release_1.1`
curFilePath =`pwd`

# write File
file = File.open("gitlog.txt","w+")
# file.puts "123\nwadwa\n12124124\ndwdw"
file.syswrite("#{changelog}")
file.close

# file = File.open("222.txt", "r")
# file.each_line do |line|
# 	puts line
# end


arr = IO.read("gitlog.txt")
# final = /^#([^#]+)/m.match(arr)
final = arr.scan /[^#]+/m   
puts final

# filterChangelog = /#(.+)/.match("#{changelog}")





