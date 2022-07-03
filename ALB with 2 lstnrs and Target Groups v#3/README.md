AWS VPC WITH ALB HAVING 2 LISTENERS, 2 TARGET-GROUP AND 2 TARGET GROUPS ATTACHMENTS:
---------------------------------------------------------------------------------
 
*In ALB-SG ingress we have allowed all protocols and opened all ports
* We have 2 private machines running, one service in running on each machine.

**ALB-SG (80 allowed at ingress) ===> listener#1 is listening on port 80 ===> forwards request to ALB-Target_Group#1 (80 port)  ===> ALB-Target_Group-Attachment#1 (80 port) ===> priv_ec2_1_instance (80 allowed at ingress and jenkins container in running at host port 80 ===> see the screenshot placed in folder)
 
**ALB-SG (50 allowed at ingress) ===> listener#2 is listening on port 50 ===> forwards request to ALB-Target_Group#2 (50 port)  ===> ALB-Target_Group-Attachment#2 (50 port) ===> priv_ec2_2_instance (50 allowed at ingress and jenkins container in running at host port 50 ===> see the screenshot placed in folder)


*Inside priv_ec2_1_instance: docker pull docker pull jenkins/jenkins:lts-jdk11;  docker run -d -p 80:8080 --name jenkins_container jenkins_image_id

**Inside priv_ec2_2_instance: docker pull docker pull jenkins/jenkins:lts-jdk11;  docker run -d -p 50:8080 --name jenkins_container jenkins_image_id


*To access jenkins service running on port host port 80 in private VM#1: ALB-DNS:80 at the browser

*To access jenkins service running on port host port 50 in private VM#2: ABL-DNS:50 at the browser



