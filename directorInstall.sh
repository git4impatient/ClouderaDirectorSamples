#install wget so we can pull down files
sudo yum -y install wget
# now go get the oracle jdk, the openjdk is not support
sudo wget http://archive.cloudera.com/director/redhat/7/x86_64/director/2.1.0/RPMS/x86_64/oracle-j2sdk1.8-1.8.0+update60-1.x86_64.rpm
# install oracle jdk
sudo rpm -ivh oracle-j2sdk1.8-1.8.0+update60-1.x86_64.rpm
# get the repo file so we can install cloudera director
sudo wget "http://archive.cloudera.com/director/redhat/7/x86_64/director/cloudera-director.repo"
# move the repo file to the directory so it will work
sudo mv cloudera-director.repo  /etc/yum.repos.d/
# install cloudera director
sudo yum -y install cloudera-director-server cloudera-director-client
# start it up if it is not started
sudo service cloudera-director-server start
# disable firewall
sudo systemctl disable firewalld
sudo systemctl stop firewalld
# turn off selinux
sudo sed -i 's/enforcing/disabled/' /etc/selinux/config
sudo setenforce 0
sudo getenforce
# firewall issues
# make sure the director node/creds can create ec2 instances, storage
# and can get to ec2.us-east-1.amazonaws.com and rds.us-east-1.amazonaws.com
# if not using rds then it won't create rds
#


