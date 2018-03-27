
#!/usr/bin/ruby

changelog =`git log --oneline release_1.0...release_1.1`
curFilePath =`pwd`

# write File
Dir.mkdir("jenkins_env_properties")
file = File.open("/#{curFilePath}/gitlog.txt","w+")
file.syswrite("#{changelog}")
file.close

# file = File.open("222.txt", "r")
# file.each_line do |line|
# 	puts line
# end

# puts $*[0]

arr = IO.read("gitlog.txt")
# final = /^#([^#]+)/m.match(arr)
final = arr.scan /[^#]+/m   
puts final

# filterChangelog = /#(.+)/.match("#{changelog}")





