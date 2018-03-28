#!/usr/bin/ruby
require 'FileUtils'

# ******************************************
# 参数说明 
# $*[0] scheme名称
# $*[1]	start tag
# $*[2] end tag

# ******************************************
# 基础信息获取
project_name=$*[0]
info_plist_name="Info"
info_plist_path="#{project_name}/#{info_plist_name}.plist"

app_Name=`/usr/libexec/PlistBuddy -c "Print CFBundleDisplayName" #{info_plist_path}`
# bundle_identifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $info_plist_path`
app_version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" #{info_plist_path}`
commit_Id=`git rev-parse --short HEAD`
commit_version=`git rev-list head | sort | wc -l | awk '{print $1}'`
project_branch=`git symbolic-ref --short -q HEAD`
git_changelog=`git log --pretty=format:"%s" #{$*[1]}...#{$*[2]}`

# 创建Jenkins环境变量文件夹
FileUtils.mkpath 'jenkins_properties'
dirName = "jenkins_properties"

# ******************************************

# Git log ----------------------------------
# 摘出不包含#bugId的log
strLog = git_changelog.gsub(/#[0-9].+/, "")
arrLog = strLog.split("\n")
# 摘出bugId
strBugId = git_changelog.tr(strLog, "")
arrBugId = strBugId.scan(/([^#]+)/)

# 遍历数组
finalGitLog = ""
for i in arrLog do
	finalGitLog += "- #{i}<br>"
end

for i in arrBugId do
	if 	i.is_a? Array
		finalGitLog += "- #{i[0]}<br>"		
	else
		finalGitLog += "- #{i}<br>"		
	end
end

file = File.open("#{dirName}/gitlog.txt","w+")
file.syswrite("CHANGELOG=#{finalGitLog}")
file.close
# 将changelog的换行符替换为<br>标签
# changelog = `cat #{dirName}/gitlog.txt`
# file = File.open("#{dirName}/gitlog.txt","w+")
# file.syswrite("CHANGELOG=#{changelog}")
# file.close

# Commit Id ----------------------------------
commitId = "#{commit_Id}"[0,6]
file = File.open("#{dirName}/commitId.txt","w+")
file.syswrite("COMMITID=#{commitId}")
file.close

# App Name ----------------------------------
file = File.open("#{dirName}/appName.txt","w+")
file.syswrite("APP_NAME=#{app_Name}")
file.close

# App Version ----------------------------------
file = File.open("#{dirName}/appVersion.txt","w+")
file.syswrite("APPVERSION=#{app_version}")
file.close

# Commit Version ----------------------------------
file = File.open("#{dirName}/commitVersion.txt","w+")
file.syswrite("COMMITVERSION=#{commit_version}")
file.close

# Branch ----------------------------------
file = File.open("#{dirName}/curBranch.txt","w+")
file.syswrite("CUR_BRANCH=#{project_branch}")
file.close

# ******************************************







