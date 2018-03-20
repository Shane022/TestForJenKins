#!/bin/bash
project_name=$1
info_plist_name=Info
info_plist_path="$project_name/$info_plist_name.plist"

# 获取commitId
# 同理获取子模块的commitId
# cd TestForJenkins/
# echo $(pwd)

app_Name=`/usr/libexec/PlistBuddy -c "Print CFBundleDisplayName" $info_plist_path`
bundle_identifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $info_plist_path`
app_version=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $info_plist_path`
commit_Id=`git rev-parse --short HEAD`
commit_version=`git rev-list head | sort | wc -l | awk '{print $1}'`
project_branch=`git symbolic-ref --short -q HEAD`

echo "COMMITID=${commitId:0:6}" > commitId.txt 
echo "APP_NAME=${app_Name}" > appName.txt
echo "APP_VERSION=${app_version}(${commit_version})" > appVersion.txt
echo "CUR_BRANCH=${project_branch}" > curBranch.txt

