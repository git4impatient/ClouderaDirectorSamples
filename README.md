# ClouderaDirectorSamples
(c) copyright 2016 martin lurie, sample code not supported

To make an instant cluster
- create a c4.large node in amazon
- your firewall rules must include a line like:  All traffic / All / All /sg-yadayadYourSG123
- sudo yum install git
- git clone https://github.com/git4impatient/ClouderaDirectorSamples
- run:  directorInstall.sh
- edit creds.sh.SAMPLE and put in your keys vpc etc.  Name it creds.sh so you don't lose it on a "git pull"
- upload your pem file and put the path to your pem file in the creds.sh
- to set up your shell variables, from the command prompt run:  ./creds.sh  
- run:   bash go.director.bootstrap  
- enjoy
- find your gateway node, ssh to the gw node
The simplist way to find the gw node is to browse to Cloudera Manager, click on the HUE service, click on the link to the HUE webUI and you will find the gw node address in the browser address line
