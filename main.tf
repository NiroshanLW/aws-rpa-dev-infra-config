
# DEFINE THE PROVIDER

provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
  # assume_role {
  #   role_arn = "${var.provider_env_roles[terraform.workspace]}"
  # }
   default_tags {
   tags = {
     map-migrated     = "d-server-027onhhwpz2ber"
     Owner_Name       = "analytics"
     Line_of_Business = "bi"
     Application_Name = "analytics_stratagy"
     Enviroment_Name  = "dev"
   }
  }
}

# CREATE VPC

resource "aws_vpc" "bi-dev-vpc" {
  cidr_block       = "10.216.224.0/19"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# CREATE SUBNETS

resource "aws_subnet" "bi-dev-adapt-subnet-1a-1" {
  vpc_id     = aws_vpc.bi-dev-vpc.id
  cidr_block = "10.216.224.0/24"
  availability_zone = "ap-southeast-1a"
}

resource "aws_subnet" "bi-dev-adapt-subnet-1b-1" {
  vpc_id     = aws_vpc.bi-dev-vpc.id
  cidr_block = "10.216.234.0/24"
  availability_zone = "ap-southeast-1b"
}

resource "aws_subnet" "bi-dev-app-subnet-1a-1" {
  vpc_id     = aws_vpc.bi-dev-vpc.id
  cidr_block = "10.216.225.0/24"
  availability_zone = "ap-southeast-1a"
}

resource "aws_subnet" "bi-dev-app-subnet-1b-1" {
  vpc_id     = aws_vpc.bi-dev-vpc.id
  cidr_block = "10.216.235.0/24"
  availability_zone = "ap-southeast-1b"
}

# CREATE ROUTING TABLE

resource "aws_route_table" "bi-dev-private-1a-1b-rt" {
  vpc_id     = aws_vpc.bi-dev-vpc.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.example.id
  # }
}

# CREATE SUBNET TO ROUTING TABLE ASSOCIATION

resource "aws_route_table_association" "bi-dev-adapt-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.bi-dev-adapt-subnet-1a-1.id
  route_table_id = aws_route_table.bi-dev-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-dev-adapt-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.bi-dev-adapt-subnet-1b-1.id
  route_table_id = aws_route_table.bi-dev-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-dev-app-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.bi-dev-app-subnet-1a-1.id
  route_table_id = aws_route_table.bi-dev-private-1a-1b-rt.id
}

resource "aws_route_table_association" "bi-dev-app-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.bi-dev-app-subnet-1b-1.id
  route_table_id = aws_route_table.bi-dev-private-1a-1b-rt.id
}

# CREATE DB SUBNET GROUP

resource "aws_db_subnet_group" "bi-dev-db-subnet-grp" {
  name       = "bi-dev-db-subnet-grp"
  subnet_ids = [aws_subnet.bi-dev-app-subnet-1a-1.id,aws_subnet.bi-dev-app-subnet-1b-1.id]
}

# CREATE DB SECURITY GROUP

resource "aws_security_group" "bi-dev-rds-sg" {
  name   = "bi-dev-rds-sg"
  vpc_id = aws_vpc.bi-dev-vpc.id

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
}

# CREATE DB

resource "aws_db_instance" "bi-dev-rds-db" {
  identifier             = "bi-dev-rds-db"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = "bidevrdsdb"
  password               = "bidevrdsdb"
  db_subnet_group_name   = aws_db_subnet_group.bi-dev-db-subnet-grp.name
  vpc_security_group_ids = [aws_security_group.bi-dev-rds-sg.id]
#  parameter_group_name   = aws_db_parameter_group.education.name
#  publicly_accessible    = true
  skip_final_snapshot    = true
}

# CREATE S3 BUCKETS

resource "aws_s3_bucket" "bi-dev-s3-bucket" {
  bucket = "bi-dev-s3-bucket"
}

# CREATE TGW ATTACHMENT

# resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
#   subnet_ids         = [aws_subnet.erp-qa-adapt-subnet-1a-1.id,aws_subnet.erp-qa-adapt-subnet-1b-1.id]
#   transit_gateway_id = aws_ec2_transit_gateway.example.id
#   vpc_id     = aws_vpc.erp-qa-vpc.id
# }

# # CREATE EC2 SERVERS

# resource "aws_instance" "erp-qa-1a-m3-app-ec2" {
#   ami           = "ami-03cd0a8eda2957211"
#   instance_type = "t3a.2xlarge"
#   subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
#   tags          = local.common_tags
# }


# # CREATE SECURITY GROUPS

# resource "aws_security_group" "erp-qa-sg" {
#   # name        = "allow_tls"
#   # description = "Allow TLS inbound traffic"
#   vpc_id      = aws_vpc.erp-qa-vpc.id

#   ingress {
#     from_port        = 22010
#     to_port          = 22010
#     protocol         = "tcp"
#     cidr_blocks      = ["10.216.196.255/32"]
#   }

#   ingress {
#     from_port        = 1433
#     to_port          = 1433
#     protocol         = "tcp"
#     cidr_blocks      = ["10.216.196.255/32"]
#   }


#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags          = local.common_tags
# }


# ## CloudWatch Alarms - Backup Faild & VPN Status Change ##

# resource "aws_sns_topic" "cloud_watch_alarm_topic" {
#   count        = length(var.alarm_type)
#   name         = "cloud-watch-${var.alarm_type[count.index]}-alarm-topic"
#   display_name = "CW Alarm | ${var.alarm_type[count.index]} | ${terraform.workspace}"
#   tags         = local.common_tags
# }

# resource "aws_sns_topic_subscription" "cloud_watch_alarm_email_target" {
#   count     = length(var.alarm_type)
#   topic_arn = aws_sns_topic.cloud_watch_alarm_topic[count.index].arn
#   protocol  = "email"
#   endpoint  = "AWS-CloudWatch-Notification@brandix.com" 
# } 

# resource "aws_cloudwatch_metric_alarm" "cw_alarm" {
#   count                     = length(var.alarm_type)
#   alarm_name                = "${var.alarm_type[count.index]}-alarm"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = var.evaluation_periods[count.index]
#   metric_name               = var.metric_name[count.index] 
#   namespace                 = var.name_space[count.index]
#   period                    = var.period[count.index]
#   statistic                 = var.statistic[count.index]
#   threshold                 = var.threshold[count.index]
#   alarm_description         = "This metric monitors ${var.alarm_type[count.index]}"
#   insufficient_data_actions = []
  
#   actions_enabled           = "true"
#   alarm_actions             = [aws_sns_topic.cloud_watch_alarm_topic[count.index].arn]
#   tags                      = local.common_tags

# }

# ## CloudWatch Alarms - High CPU ##

# resource "aws_sns_topic" "cloud_watch_alarm_topic_cpu" {
#   name         = "cloud-watch-high-cpu-alarm-topic"
#   display_name = "CW Alarm | High CPU | ${terraform.workspace}"
#   tags         = local.common_tags
# }

# resource "aws_sns_topic_subscription" "cloud_watch_alarm_email_target_cpu" {
#   topic_arn = aws_sns_topic.cloud_watch_alarm_topic_cpu.arn
#   protocol  = "email"
#   endpoint  = "AWS-CloudWatch-Notification@brandix.com" 
# } 

# resource "aws_cloudwatch_metric_alarm" "cw_high_cpu_alarm" {
#   count                     = length(var.instance_id)
#   alarm_name                = "${var.instance_id[count.index]}-high-cpu-alarm"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = "2"
#   metric_name               = "CPUUtilization"
#   namespace                 = "AWS/EC2"
#   period                    = "60"
#   statistic                 = "Maximum"
#   threshold                 = "80"
  
#   alarm_description         = "This metric monitors high cpu of instances"
#   insufficient_data_actions = []

#   dimensions = {
#         InstanceId = var.instance_id[count.index]
#       }
  
#   actions_enabled           = "true"
#   alarm_actions             = [aws_sns_topic.cloud_watch_alarm_topic_cpu.arn]
#   tags                      = local.common_tags
# }

# ## CloudWatch Alarms - CIS Alarms ##

# # Configure SNS Topic
# resource "aws_sns_topic" "cis_cloudwatch_alarm" {
#   name         = "cloud-watch-cis-alarm-topic"
#   display_name = "CW Alarm | CIS | ${terraform.workspace}"
# }

# # Configure SNS Topic Subscription

# resource "aws_sns_topic_subscription" "cis_cloudwatch_alarm_target" {
#   topic_arn = aws_sns_topic.cis_cloudwatch_alarm.arn
#   protocol  = "email"
#   endpoint  = "AWS-CloudWatch-Notification@brandix.com"
# }

# # Configure a log metric filter 

# resource "aws_cloudwatch_log_metric_filter" "cis_metric_filter" {
#   count          = length(var.resource_type) 
#   name           = "${terraform.workspace}-cis-metric-filter-${var.resource_type[count.index]}-changes"
#   pattern        = var.metric_filter[count.index]
#   log_group_name = "aws-controltower/CloudTrailLogs"

#   metric_transformation {
#     name      = "${terraform.workspace}-cis-metric-${var.resource_type[count.index]}-changes"
#     namespace = "cis-log-metrics"
#     value     = "1"
#   }
# }

# # Configure a metric alarm

# resource "aws_cloudwatch_metric_alarm" "cis_metric_alarm" {
#   count                     = length(var.resource_type) 
#   alarm_name                = "cis-metric-${var.resource_type[count.index]}-alarm"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = "1"
#   metric_name               =  aws_cloudwatch_log_metric_filter.cis_metric_filter[count.index].metric_transformation[0].name
#   namespace                 =  aws_cloudwatch_log_metric_filter.cis_metric_filter[count.index].metric_transformation[0].namespace   
#   period                    = "60"
#   statistic                 = "Sum"
#   threshold                 = "1"
#   alarm_description         = "This metric monitors ${var.resource_type[count.index]} changes"
#   insufficient_data_actions = []

#   actions_enabled           = "true"
#   alarm_actions             = [aws_sns_topic.cis_cloudwatch_alarm.arn]
# }

