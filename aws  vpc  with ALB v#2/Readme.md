#Instructions to Remember while execution of aws vpc with ALB v#2

#Application load  balancer requires 2 public subnets each in different availabity zones

POINT#1:
#the port for the ALB-SG ingress needs to be same as of ALB-LISTNER, like here we used port "50" for both ALB-SG ingress and ALB-LISTNER


POINT#2:
##The port for ALB-target-group needs to be same as for ALB-target-group-attachment as well as for the ingress port of the instance(private_ec2) that is attach to ALB-target_group-attachment, like here we have used port "8081" for these three


#POINT#3:
Our Private Ec2 is attached with ALB through ALB-target-group-attachment
We run a jenkins container inside our private Ec2 machine on host port 8081  =>
docker run -d -p 8081:8080 --name container_name jenkins_image

######################################################################################3

On browser when we write ALB_DNS:50
http://my-application-lb-1682971174.us-east-1.elb.amazonaws.com:50
It will take you to the jenkins service runing on port 8081 in private EC2 machine

So the flow of communication is like:
ALB-SG(allowed ingress 50) ===> ALB-Listener(listening on port 50) ===> forwards request to ALB target group (listening on 8081) ===> ALB target group attachment on which we open 8081 (attached with private Ec2) ===> Private Ec2 (allowed ingress 8081 within VPC CIDR) ===> on private ec2 jenkins service is runing on host port 8081