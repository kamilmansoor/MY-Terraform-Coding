ALB attached with ASG:
---------------------

*In this version of code, we have a ALB deployed along with one ASG..
*We have not created a private ec2 seperately unlike previous version where we attached ALB-Target_group directly with the private ec2 using TG-Attachement.  
*Here our ALB is directly attached to ASG as ALB-Target_group routes traffic to ASG.

The Flow of Communication is as follows:

ALB-listener (listening on port 80) ==> ALB-Target-Group(Receiving request at port 8081 ) ==> ASG  ==> Ec2 Instance Running Inside ASG(jenkins service runing inside this Ec2 at port 8081)

docker pull jenkins/jenkins:lts-jdk11
docker run -d -p 8081:8080 --name jenkins_container image_id
