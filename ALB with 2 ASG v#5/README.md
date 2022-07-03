ALB HAVING 2 LISTENERS, 2 TARGET-GROUP AND 2 ASG:
---------------------------------------------------------------------------------
 
*In ALB-SG ingress we have allowed all protocols and opened all ports
* We have 2 AutoScaling Groups, having one ec2 machine in each Asg.
*We have a common Security Group for both ASG where we opened port 80 and 50 at ingress 

**ALB-SG (80 allowed at ingress) ===> listener#1 is listening on port 80 ===> forwards request to ALB-Target_Group#1 (80 port)  ===> ASG (80 allowed at ingress of ASG-SG) ===> ec2_instance Running Inside this ASG (jenkins container in running at host port 80 ===> see the screenshot placed in folder)
 
**ALB-SG (50 allowed at ingress) ===> listener#2 is listening on port 50 ===> forwards request to ALB-Target_Group#2 (50 port)  ===> ASG (50 allowed at ingress of ASG-SG) ===> ec2_instance Running Inside this ASG (jenkins container in running at host port 50 ===> see the screenshot placed in folder)

*Inside priv_instance of ASG#1: docker pull docker pull jenkins/jenkins:lts-jdk11;  docker run -d -p 80:8080 --name jenkins_container jenkins_image_id

**Inside priv_instance of ASG#2: docker pull docker pull jenkins/jenkins:lts-jdk11;  docker run -d -p 50:8080 --name jenkins_container jenkins_image_id

*To access jenkins service running on port host port 80 in private VM of ASG#1: ALB-DNS:80 at the browser

*To access jenkins service running on port host port 50 in private VM of ASG#2: ABL-DNS:50 at the browser



