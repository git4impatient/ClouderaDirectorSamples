# ClouderaDirectorSamples
(c) copyright 2016 martin lurie, sample code not supported

To make an instant cluster
- create a c4.large node in amazon
- sudo yum install git
- git clone https://github.com/git4impatient/ClouderaDirectorSamples
- run:  directorInstall.sh
- edit creds.sh and put in your keys vpc etc
- upload your pem file and put the path to your pem file in the creds.sh
- to set up your shell variables, from the command prompt run:  ./creds.sh  
- run:   bash go.director.bootstrap  
- enjoy
