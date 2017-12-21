# install aws cli  - I didn't use root for this
pip install awscli --upgrade --user
# configure the cli
# from 
# http://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html#awscli-install-linux-path
#$ aws configure
#AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
#AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
#Default region name [None]: us-west-2
#Default output format [None]: json
aws configure
# now create vpc
aws ec2 create-vpc --cidr-block 10.1.2.0/16
echo please enter the name of the vpc you just created 
read VpcId
echo you just entered $VpcId
echo hit enter to continue
read foo
echo now creating subnet
aws ec2 create-subnet --vpc-id $VpcId --cidr-block 10.1.2.0/16
echo please enter the subnet id
read SubnetId
aws ec2 create-internet-gateway
echo enter gatewayid
read InternetGatewayId
aws ec2 attach-internet-gateway --vpc-id $VpcId --internet-gateway-id $InternetGatewayId
aws ec2 create-route-table --vpc-id $VpcId 
echo enter route table id
read RouteTableId
aws ec2 create-route --route-table-id $RouteTableId --destination-cidr-block 0.0.0.0/0 --gateway-id $InternetGatewayId
aws ec2 describe-route-tables --route-table-id $RouteTableId
aws ec2 describe-subnets --filters "Name=vpc-id,Values=$VpcId" --query 'Subnets[*].{ID:SubnetId,CIDR:CidrBlock}'
echo enter subnet-id
read SubnetId
aws ec2 associate-route-table  --subnet-id $SubnetId --route-table-id $RouteTableId 
aws ec2 modify-subnet-attribute --subnet-id $SubnetId  --map-public-ip-on-launch
aws ec2 create-key-pair --key-name clouderadirector --query 'KeyMaterial' --output text > clouderadirector.pem
 chmod 400 clouderadirector.pem 
 aws ec2 create-security-group --group-name SSHAccess --description "Security group for SSH access" --vpc-id $VpcId
echo enter the Security Group Id
read GroupId
aws ec2 authorize-security-group-ingress --group-id $GroupId --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 run-instances --image-id ami-a4827dc9 --count 1 --instance-type t2.micro --key-name clouderadirector --security-group-ids $GroupId --subnet-id $SubnetId
