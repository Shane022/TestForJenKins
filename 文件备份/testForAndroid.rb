#!/usr/bin/ruby
require 'FileUtils'
require 'find'

# 全局变量
# --------------------------------------------
# $*[0]	start tag
# $*[1] end tag
propertiesFileName="jenkins_properties"
fileDir = Dir::pwd

# aapt获取应用信息
# --------------------------------------------
# 进入安装包路径，使用aapt提取appInfo
appPath = "#{fileDir}/iVideoPhone5.0/app/build/outputs/apk"
Dir.chdir(appPath)
# ruby自动识别变量类型，当前返回值只有一个，故是String类型
apkName = `ls $(pwd)`
# 对()转义
apkName = apkName.gsub(/\(/, "\\(")
apkName = apkName.gsub(/\)/, "\\)")
appInfo = `aapt dump badging #{apkName}`

# 存储各仓库的branch、commitId和changelog
# --------------------------------------------
def saveBranchAndCommitId(propertiesFileName, fileDir, commitIdAndCurBranch)
	# 创建保存变量的文件夹
	Dir.chdir(fileDir)
	FileUtils.mkpath 'jenkins_properties'
	# 保存branch和commitId
	file = File.open("#{propertiesFileName}/curBranch.txt","w+")
	file.syswrite("CUR_BRANCH=#{commitIdAndCurBranch}")
	file.close
end

def saveGitChangelog(propertiesFileName, git_changelog)
	# 摘出不包含#bugId的log
	# strLog = git_changelog.gsub(/#[0-9].+/, "")
	strLog = git_changelog.gsub(/(\[#).+/, " ")
	strLog = strLog.lstrip
	arrLog = strLog.split("\n")
	# 摘出bugId
	strBugId = git_changelog.tr(strLog, "")
	arrBugId = strBugId.gsub(/\[([^\[]+)/).to_a
	
	# 处理普通commit message
	finalGitLog = ""
	for i in arrLog do
		finalGitLog += "- #{i}<br>"
	end
	# 处理bugId
	for i in arrBugId do
		if 	i.is_a? Array
			finalGitLog += "- #{i[0]}<br>"		
		else
			finalGitLog += "- #{i}<br>"		
		end
	end

	# print finalGitLog
	file = File.open("#{propertiesFileName}/gitlog.txt","w+")
	file.syswrite("CHANGELOG=#{finalGitLog}")
	file.close
end

def handleBranchAndChangeInfo(propertiesFileName, fileDir)
	fileList = Dir["/#{fileDir}/*"]
	commitIdAndCurBranch = ""
	changelog = ""

	for path in fileList do
		# 遍历文件夹，获取git相关信息
		# 判断当前路径是否是目录
		if File::directory?(path)
			Dir.chdir("#{path}")
			# 判断当前目录是否是保存properties的文件夹，是则跳过
			if !(path.include?propertiesFileName)
				# 获取branch和commitId
				branch = `git symbolic-ref --short -q HEAD`
				commitId = `git rev-parse --short HEAD`[0,6]
				branch = branch.chomp
				commitIdAndCurBranch += "#{branch}&nbsp;#{commitId}<br>".chomp
				# 获取changelog
				# TODO:test
				git_changelog = "[#123456]修改了bug,[#23]大角湾\n测试 说明;[#394]这是啥\n哇哇哇哇"
				# git_changelog = `git log --pretty=format:"%s" #{$*[1]}...#{$*[2]}`
				changelog += "#{git_changelog}"
			end
		end
	end
	# 保存branch和commitId
	saveBranchAndCommitId(propertiesFileName, fileDir, commitIdAndCurBranch)
	# 保存changelog
	saveGitChangelog(propertiesFileName, changelog)
end

# 存储commitversion
# --------------------------------------------
def saveCommitVersion(propertiesFileName, appInfo)
	versionCode = appInfo.match(/versionCode+[^" "]*/).to_s
	versionCode = versionCode.gsub("versionCode=", "")
	versionCode = versionCode.gsub("'", "")
	file = File.open("#{propertiesFileName}/commitVersion.txt","w+")
	file.syswrite("VERSIONCODE=#{versionCode}")
	file.close	
end

# 存储packageName
# --------------------------------------------
def savePackageName(propertiesFileName, appInfo)
	packageName = appInfo.match(/name+[^" "]*/).to_s
	packageName = packageName.gsub("name=", "")
	packageName = packageName.gsub("'", "")
	file = File.open("#{propertiesFileName}/packageName.txt","w+")
	file.syswrite("PACKAGENAME=#{packageName}")
	file.close	
end

# 方法调用
# --------------------------------------------
# saveBranchAndCommitId(propertiesFileName, fileDir)
# saveCommitVersion(propertiesFileName, appInfo)
# savePackageName(propertiesFileName, appInfo)
handleBranchAndChangeInfo(propertiesFileName, fileDir)

