#create a security group for AWS relational database (rds) Mariadb 

resource "aws_security_group" "rds_sg" {
  name        = var.rds_sg_name
  description = "Sg for rds"
  vpc_id      = var.vpc_id

  ingress {
    description = "allow all within Vpc"
    from_port   = 0
    to_port     = 0
    #The -1 below in protocol at ALB-SG-ingress, means all protocol 
    protocol    = "-1"
    cidr_blocks = ["192.167.0.0/16"]
  }  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}


#create a subnetgroup for database

resource "aws_db_subnet_group" "rds_subnet" {
  name       = "rds_subnet_group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "rds_subnet_group"
  }
}


#create Mariadb instance
resource "aws_db_instance" "rds" {

  #If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted
  skip_final_snapshot = false

  #The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip_final_snapshot is set to false
  final_snapshot_identifier = "db-snap"
  
  #set the database name
  db_name = var.db_name

  # set the allocated storage
  allocated_storage = var.allocated_storage

  #set the storage type
  storage_type = var.storage_type

  #set the engine to mariadb
  engine = var.db_engine
  
  #set the name for DB identifier 
  identifier = var.db_identifier

  #set the engine version for mariadb 
  engine_version = var.db_engine_version

  #set the instance class
  instance_class = var.db_instance_class

  #set the database username
  username = var.db_username

  #set the database password
  password = var.db_password

  #add the database subnet group
  db_subnet_group_name = aws_db_subnet_group.rds_subnet.name

  #set the vpc_Security group ids
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  #set the availability zone => The AZ for the RDS instance
  availability_zone = var.rds_az_name
  
}