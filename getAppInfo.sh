#!/bin/bash

#$1 项目名称
#$2 起始tag值
#$3 终止tag值

project_name=$1
info_plist_name=Info
info_plist_path="${project_name}/${info_plist_name}.plist"
propertiesFileName="properties"

if [ ! -d "${propertiesFileName}/" ];then
mkdir $propertiesFileName
else
echo "file exists"
fi

# 获取commitId
# 同理获取子模块的commitId
# cd TestForJenkins/
# echo $(pwd)

app_Name=`/usr/libexec/PlistBuddy -c "Print CFBundleDisplayName" ${info_plist_path}`
# bundle_identifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $info_plist_path`
app_version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" ${info_plist_path}`
commit_Id=`git rev-parse --short HEAD`
commit_version=`git rev-list head | sort | wc -l | awk '{print $1}'`
project_branch=`git symbolic-ref --short -q HEAD`
git_changelog=`git log --pretty=format:"%s" $2...$3`

echo "COMMITID=${commit_Id:0:6}" > $propertiesFileName/commitId.txt 
echo "APP_NAME=${app_Name}" > $propertiesFileName/appName.txt
echo "APP_VERSION=${app_version}(${commit_version})" > $propertiesFileName/appVersion.txt
echo "CUR_BRANCH=${project_branch}" > $propertiesFileName/curBranch.txt
echo "CHANGELOG=${git_changelog}" > $propertiesFileName/gitlog.txt
