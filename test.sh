#!/bin/bash

workspace=$(pwd)
# 每次构建之前清楚上次的构建结果
# ---------------------------
rm -rf $workspace/ipa
# fastlane 构建
# ---------------------------
fastlane test workspace:$workspace
# fir上传
# ---------------------------
ipaPath="$workspace/ipa/"
cd $ipaPath

files=`ls $ipaPath`
ipaName=''
for file in $files; do
	if [[ $file =~ "ipa" ]]; then
		ipaName=$file
	fi
done

fir publish $ipaName --no-open --qrcode --password=123456