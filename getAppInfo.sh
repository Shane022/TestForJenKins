#获取commitId
# 同理获取子模块的commitId
# cd TestForJenkins/
# echo $(pwd)
commitId=`git rev-parse --short HEAD`
echo "COMMITID=${commitId:0:6}" > commitId.properties 


