#!/bin/bash

#计时
SECONDS=0

#假设脚本放置在与项目相同的路径下
project_path="$(pwd)"
#取当前时间字符串添加到文件结尾
#now=$(date +"%Y%m%d%H_%M%S")
now=$(data)
#当前用户名
userName="$(whoami)"

#指定项目的scheme名称
scheme="TestForJenkins"
#指定要打包的配置名
configuration="Release"
#指定项目地址
workspace_path="$project_path/$scheme.xcodeproj"
#指定输出路径
output_path="/Users/$userName/Desktop/ipa"
echo "++++++++$output_path"
#指定输出归档文件地址
archive_path="$output_path/$scheme.xcarchive"
#指定输出ipa地址
ipa_name="$scheme.ipa"
#ipa路径
ipa_path="$output_path/$ipa_name"
#指定打包所使用的输出方式，目前支持app-store, package, ad-hoc, enterprise, development, 和developer-id，即xcodebuild的method参数
export_method='enterprise'
#获取执行命令时的commit message
commit_msg="$1"


#输出设定的变量值
echo "===workspace path: ${workspace_path}==="
echo "===archive path: ${archive_path}==="
echo "===ipa path: ${ipa_path}==="
echo "===profile: ${provisioning_profile}==="
echo "===commit msg: $1==="

#先清空前一次build
gym --project ${workspace_path} --scheme ${scheme} --clean --configuration ${configuration} --archive_path ${archive_path} --export_method ${export_method} --output_directory ${output_path} --output_name ${ipa_name}

#判断ipa是否生成 如果没有生成 shell报错=>告知Job构建失败
if [ -f $ipa_path ]
then
    echo "Generate $ipa_path successfully!"
else
    echo "Generate $ipa_path fail!"
    exit 1
fi

#上传到fir
#fir publish ${ipa_path} -T fir_token -c "${commit_msg}"

#输出总用时
echo "===Finished. Total time: ${SECONDS}s==="
