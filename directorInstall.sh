sudo yum -y install wget
sudo wget http://archive.cloudera.com/director/redhat/7/x86_64/director/2.1.0/RPMS/x86_64/oracle-j2sdk1.8-1.8.0+update60-1.x86_64.rpm
sudo rpm -ivh oracle-j2sdk1.8-1.8.0+update60-1.x86_64.rpm
sudo wget "http://archive.cloudera.com/director/redhat/7/x86_64/director/cloudera-director.repo"
sudo mv cloudera-director.repo  /etc/yum.repos.d/
sudo yum -y install cloudera-director-server cloudera-director-client
sudo service cloudera-director-server start
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo sed -i 's/enforcing/disabled/' /etc/selinux/config
