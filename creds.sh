#accessKeyId: ${?AWS_ACCESS_KEY_ID}
#secretAccessKey: ${?AWS_SECRET_ACCESS_KEY}

export AWS_ACCESS_KEY_ID="xxxxxxxxxxxxxxxxx2MA"
export AWS_SECRET_ACCESS_KEY='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxIr'
export subnetId='subnet-740e482eREPLACEWITHYOURS'
export securityGroupsIds='sg-2b2dab5bREPLACEWITHYOURS'
# you need to upload your private key .pem file and then specificy the path on the director
# node as to where it lives
export path2privateKey='/home/ec2-user/REPLACEWITHYOURSdirectorV2.pem'
export region='us-east-1'
# This centos7 image has worked well for several examples
export image='ami-6d1c2007'
bash
