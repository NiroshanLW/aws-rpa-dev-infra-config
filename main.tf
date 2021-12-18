
############################
# DEFINE THE PROVIDER
############################

provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
  # assume_role {
  #   role_arn = "${var.provider_env_roles[terraform.workspace]}"
  # }
   default_tags {
   tags = {
     map-migrated     = "d-server-027onhhwpz2ber"
     Owner_Name       = "gogulaa@fortude.co"
     Line_of_Business = "bi"
     Application_Name = "analytics_stratagy"
     Enviroment_Name  = "dev"
   }
  }
}

############################
# CREATE VPC
############################

resource "aws_vpc" "bi-sandbox-dl-sec-vpc" {
  cidr_block       = "10.214.192.0/21"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "bi-sandbox-dl-sec-vpc"
  }
}

################################################################################

resource "aws_vpc" "bi-sandbox-dm-sec-vpc" {
  cidr_block       = "10.214.200.0/21"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "bi-sandbox-dm-sec-vpc"
  }
}

############################
# CREATE SUBNETS
############################

resource "aws_subnet" "bi-sandbox-dl-sec-adapt-subnet-1a-1" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id
  cidr_block = "10.214.192.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "bi-sandbox-dl-sec-adapt-subnet-1a-1"
  }
}

resource "aws_subnet" "bi-sandbox-dl-sec-adapt-subnet-1b-1" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id
  cidr_block = "10.214.193.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "bi-sandbox-dl-sec-adapt-subnet-1b-1"
  }
}

resource "aws_subnet" "bi-sandbox-dl-sec-service-subnet-1a-1" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id
  cidr_block = "10.214.194.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "bi-sandbox-dl-sec-service-subnet-1a-1"
  }
}

resource "aws_subnet" "bi-sandbox-dl-sec-service-subnet-1b-1" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id
  cidr_block = "10.214.195.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "bi-sandbox-dl-sec-service-subnet-1b-1"
  }
}

resource "aws_subnet" "bi-sandbox-dl-sec-datalake-subnet-1a-1" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id
  cidr_block = "10.214.196.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "bi-sandbox-dl-sec-datalake-subnet-1a-1"
  }
}

resource "aws_subnet" "bi-sandbox-dl-sec-datalake-subnet-1b-1" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id
  cidr_block = "10.214.197.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "bi-sandbox-dl-sec-datalake-subnet-1b-1"
  }
}

resource "aws_subnet" "bi-sandbox-dl-sec-entdataproduct-subnet-1a-1" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id
  cidr_block = "10.214.198.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "bi-sandbox-dl-sec-entdataproduct-subnet-1a-1"
  }
}

resource "aws_subnet" "bi-sandbox-dl-sec-entdataproduct-subnet-1b-1" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id
  cidr_block = "10.214.199.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "bi-sandbox-dl-sec-entdataproduct-subnet-1b-1"
  }
}

################################################################################

resource "aws_subnet" "bi-sandbox-dm-sec-adapt-subnet-1a-1" {
  vpc_id     = aws_vpc.bi-sandbox-dm-sec-vpc.id
  cidr_block = "10.214.200.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "bi-sandbox-dm-sec-adapt-subnet-1a-1"
  }
}

resource "aws_subnet" "bi-sandbox-dm-sec-adapt-subnet-1b-1" {
  vpc_id     = aws_vpc.bi-sandbox-dm-sec-vpc.id
  cidr_block = "10.214.201.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "bi-sandbox-dm-sec-adapt-subnet-1b-1"
  }
}

resource "aws_subnet" "bi-sandbox-dm-sec-service-subnet-1a-1" {
  vpc_id     = aws_vpc.bi-sandbox-dm-sec-vpc.id
  cidr_block = "10.214.202.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "bi-sandbox-dm-sec-service-subnet-1a-1"
  }
}

resource "aws_subnet" "bi-sandbox-dm-sec-service-subnet-1b-1" {
  vpc_id     = aws_vpc.bi-sandbox-dm-sec-vpc.id
  cidr_block = "10.214.203.0/24"
  availability_zone = "ap-southeast-1b"
  tags = {
    Name = "bi-sandbox-dm-sec-service-subnet-1b-1"
  }
}


############################
# CREATE TGW ATTACHMENT
############################

resource "aws_ec2_transit_gateway_vpc_attachment" "bi-sandbox-dl-sec-vpc-tgw-attach" {
  subnet_ids         = [aws_subnet.bi-sandbox-dl-sec-adapt-subnet-1a-1.id,aws_subnet.bi-sandbox-dl-sec-adapt-subnet-1b-1.id]
  transit_gateway_id = "tgw-0d7caf9dc995910f5"
  vpc_id             = aws_vpc.bi-sandbox-dl-sec-vpc.id
  tags = {
    Name = "bi-sandbox-dl-sec-vpc-tgw-attach"
  }
}

################################################################################

resource "aws_ec2_transit_gateway_vpc_attachment" "bi-sandbox-dm-sec-vpc-tgw-attach" {
  subnet_ids         = [aws_subnet.bi-sandbox-dm-sec-adapt-subnet-1a-1.id,aws_subnet.bi-sandbox-dm-sec-adapt-subnet-1b-1.id]
  transit_gateway_id = "tgw-0d7caf9dc995910f5"
  vpc_id             = aws_vpc.bi-sandbox-dm-sec-vpc.id
  tags = {
    Name = "bi-sandbox-dm-sec-vpc-tgw-attach"
  }
}

############################
# CREATE ROUTING TABLE
############################

resource "aws_route_table" "bi-sandbox-dl-sec-private-1a-1b-rt" {
  vpc_id     = aws_vpc.bi-sandbox-dl-sec-vpc.id

  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = "tgw-0d7caf9dc995910f5"
  }
  tags = {
    Name = "bi-sandbox-dl-sec-private-1a-1b-rt"
  }
}

################################################################################

resource "aws_route_table" "bi-sandbox-dm-sec-private-1a-1b-rt" {
  vpc_id     = aws_vpc.bi-sandbox-dm-sec-vpc.id

  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = "tgw-0d7caf9dc995910f5"
  }
  tags = {
    Name = "bi-sandbox-dm-sec-private-1a-1b-rt"
  }
}

##############################################
# CREATE SUBNET TO ROUTING TABLE ASSOCIATION
##############################################

resource "aws_route_table_association" "bi-sandbox-dl-sec-adapt-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dl-sec-adapt-subnet-1a-1.id
  route_table_id = aws_route_table.bi-sandbox-dl-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dl-sec-adapt-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dl-sec-adapt-subnet-1b-1.id
  route_table_id = aws_route_table.bi-sandbox-dl-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dl-sec-service-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dl-sec-service-subnet-1a-1.id
  route_table_id = aws_route_table.bi-sandbox-dl-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dl-sec-service-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dl-sec-service-subnet-1b-1.id
  route_table_id = aws_route_table.bi-sandbox-dl-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dl-sec-datalake-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dl-sec-datalake-subnet-1a-1.id
  route_table_id = aws_route_table.bi-sandbox-dl-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dl-sec-datalake-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dl-sec-datalake-subnet-1b-1.id
  route_table_id = aws_route_table.bi-sandbox-dl-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dl-sec-entdataproduct-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dl-sec-entdataproduct-subnet-1a-1.id
  route_table_id = aws_route_table.bi-sandbox-dl-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dl-sec-entdataproduct-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dl-sec-entdataproduct-subnet-1b-1.id
  route_table_id = aws_route_table.bi-sandbox-dl-sec-private-1a-1b-rt.id
}

################################################################################

resource "aws_route_table_association" "bi-sandbox-dm-sec-adapt-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dm-sec-adapt-subnet-1a-1.id
  route_table_id = aws_route_table.bi-sandbox-dm-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dm-sec-adapt-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dm-sec-adapt-subnet-1b-1.id
  route_table_id = aws_route_table.bi-sandbox-dm-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dm-sec-service-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dm-sec-service-subnet-1a-1.id
  route_table_id = aws_route_table.bi-sandbox-dm-sec-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-sandbox-dm-sec-service-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.bi-sandbox-dm-sec-service-subnet-1b-1.id
  route_table_id = aws_route_table.bi-sandbox-dm-sec-private-1a-1b-rt.id
}

############################
# CREATE DB SUBNET GROUP
############################

resource "aws_db_subnet_group" "bi-sandbox-dl-sec-db-subnet-grp" {
  name       = "bi-sandbox-dl-sec-db-subnet-grp"
  subnet_ids = [aws_subnet.bi-sandbox-dl-sec-service-subnet-1a-1.id,aws_subnet.bi-sandbox-dl-sec-service-subnet-1b-1.id]
}

################################################################################

resource "aws_db_subnet_group" "bi-sandbox-dm-sec-db-subnet-grp" {
  name       = "bi-sandbox-dm-sec-db-subnet-grp"
  subnet_ids = [aws_subnet.bi-sandbox-dm-sec-service-subnet-1a-1.id,aws_subnet.bi-sandbox-dm-sec-service-subnet-1b-1.id]
}

############################
# CREATE DB SECURITY GROUP
############################

resource "aws_security_group" "bi-sandbox-dl-sec-rds-sg" {
  name   = "bi-sandbox-dl-sec-rds-sg"
  vpc_id = aws_vpc.bi-sandbox-dl-sec-vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bi-sandbox-dl-sec-rds-sg"
  }
}

################################################################################

resource "aws_security_group" "bi-sandbox-dm-sec-rds-sg" {
  name   = "bi-sandbox-dm-sec-rds-sg"
  vpc_id = aws_vpc.bi-sandbox-dm-sec-vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "bi-sandbox-dm-sec-rds-sg"
  }
}

############################
# CREATE DB
############################

resource "aws_db_instance" "bi-sandbox-dl-sec-rds-db" {
  allocated_storage      = 20
  availability_zone      = "ap-southeast-1a"
  backup_retention_period= 0
  deletion_protection    = false   
  enabled_cloudwatch_logs_exports = ["error"]
  identifier             = "bi-sandbox-dl-sec-meta-rds-db"
  instance_class         = "db.t3.small"
  license_model          = "license-included"
  multi_az               = false
  engine                 = "sqlserver-ex"
  engine_version         = "15.00.4073.23.v1"
  username               = "bisandboxrdsdb"
  password               = "bisandboxrdsdb"
  db_subnet_group_name   = aws_db_subnet_group.bi-sandbox-dl-sec-db-subnet-grp.name
  vpc_security_group_ids = [aws_security_group.bi-sandbox-dl-sec-rds-sg.id]
#  parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible    = false
  skip_final_snapshot    = true
}

# ################################################################################

resource "aws_db_instance" "bi-sandbox-dm-sec-rds-db" {
  allocated_storage      = 20
  availability_zone      = "ap-southeast-1a"
  backup_retention_period= 0
  deletion_protection    = false   
  enabled_cloudwatch_logs_exports = ["error"]
  identifier             = "bi-sandbox-dm-sec-meta-rds-db"
  instance_class         = "db.t3.small"
  license_model          = "license-included"
  multi_az               = false
  engine                 = "sqlserver-ex"
  engine_version         = "15.00.4073.23.v1"
  username               = "bisandboxrdsdb"
  password               = "bisandboxrdsdb"
  db_subnet_group_name   = aws_db_subnet_group.bi-sandbox-dm-sec-db-subnet-grp.name
  vpc_security_group_ids = [aws_security_group.bi-sandbox-dm-sec-rds-sg.id]
#  parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible    = false
  skip_final_snapshot    = true
}

############################
# CREATE S3 BUCKETS
############################

resource "aws_s3_bucket" "bi-sandbox-dl-raw-s3-bucket" {
  bucket = "bi-sandbox-dl-raw-s3-bucket"
}

resource "aws_s3_bucket" "bi-sandbox-dl-pcr-s3-bucket" {
  bucket = "bi-sandbox-dl-raw-s3-bucket"
}

resource "aws_s3_bucket" "bi-sandbox-dl-cur-s3-bucket" {
  bucket = "bi-sandbox-dl-raw-s3-bucket"
}

# ################################################################################

resource "aws_s3_bucket" "bi-sandbox-dm-cur-s3-bucket" {
  bucket = "bi-sandbox-dm-log-s3-bucket"
}

#################################
# CREATE ACCOUNT PASSWORD POLICY
#################################

resource "aws_iam_account_password_policy" "bi-sandbox-account-password-policy" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = false
  password_reuse_prevention      = 24
  max_password_age               = 90
}

########################
# CREATE SNS TOIPC
########################

resource "aws_sns_topic" "bi-sandbox-cis-cloudwatch-alarm-topic" {
  name         = "bi-sandbox-cis-cloudwatch-alarm-topic"
  # display_name = "CW Alarm | CIS | ${terraform.workspace}"
  display_name = "CW Alarm | CIS | bi-sandbox"
}

#####################################
# CREATE SNS TOPIC SUBSCRIPTION
#####################################

resource "aws_sns_topic_subscription" "bi-sandbox-cis-cloudwatch-alarm-target" {
  topic_arn = aws_sns_topic.bi-sandbox-cis-cloudwatch-alarm-topic.arn
  protocol  = "email"
  endpoint  = "AWS-CloudWatch-Notification@brandix.com"
}

###############################
# CREATE LOG METRIC FILTER 
###############################

resource "aws_cloudwatch_log_metric_filter" "bi-sandbox-cis-metric-filter" {
  count          = length(var.resource_type) 
  name           = "bi-sandbox-cis-metric-filter-${var.resource_type[count.index]}-changes"
  pattern        = var.metric_filter[count.index]
  log_group_name = "aws-controltower/CloudTrailLogs"

  metric_transformation {
    name      = "bi-sandbox-cis-metric-${var.resource_type[count.index]}-changes"
    namespace = "cis-log-metrics"
    value     = "1"
  }
}

###########################
# CREATE METRIC ALARM
###########################

resource "aws_cloudwatch_metric_alarm" "cis_metric_alarm" {
  count                     = length(var.resource_type) 
  alarm_name                = "bi-sandbox-cis-metric-${var.resource_type[count.index]}-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               =  aws_cloudwatch_log_metric_filter.bi-sandbox-cis-metric-filter[count.index].metric_transformation[0].name
  namespace                 =  aws_cloudwatch_log_metric_filter.bi-sandbox-cis-metric-filter[count.index].metric_transformation[0].namespace   
  period                    = "60"
  statistic                 = "Sum"
  threshold                 = "1"
  alarm_description         = "This metric monitors ${var.resource_type[count.index]} changes"
  insufficient_data_actions = []

  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.bi-sandbox-cis-cloudwatch-alarm-topic.arn]
}