
# Define the provider

provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
  # assume_role {
  #   role_arn = "${var.provider_env_roles[terraform.workspace]}"
  # }
}

# Define local variables

locals {
  common_tags = {
    Owner_Name       = "cloud-watch"
 #   Line_of_Business = split("-",terraform.workspace)[0]
    Application_Name = "cloud-watch"
   # Enviroment_Name  = split("-",terraform.workspace)[1]
    map-migrated     = "d-server-027onhhwpz2ber"
  }
}

resource "aws_vpc" "erp-qa-vpc" {
  cidr_block       = "10.216.224.0/19"
  instance_tenancy = "default"
  tags = local.common_tags
}

# Create VPC

# Create Subnets

resource "aws_subnet" "erp-qa-adapt-subnet-1a-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.224.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-adapt-subnet-1b-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.234.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-app-subnet-1a-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.225.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-app-subnet-1b-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.235.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-db-subnet-1a-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.226.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-db-subnet-1b-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.236.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-gen-subnet-1a-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.227.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-gen-subnet-1b-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.237.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-dmz-subnet-1a-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.228.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-dmz-subnet-1b-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.238.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-web-subnet-1a-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.229.0/24"
  tags = local.common_tags
}

resource "aws_subnet" "erp-qa-web-subnet-1b-1" {
  vpc_id     = aws_vpc.erp-qa-vpc.id
  cidr_block = "10.216.239.0/24"
  tags = local.common_tags
}

# Create Route Table

resource "aws_route_table" "erp-qa-private-1a-1b-rt" {
  vpc_id     = aws_vpc.erp-qa-vpc.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.example.id
  # }

  tags = local.common_tags
}

# Create subnet to route table association

resource "aws_route_table_association" "erp-qa-adapt-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.erp-qa-adapt-subnet-1a-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-adapt-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.erp-qa-adapt-subnet-1b-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-app-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.erp-qa-app-subnet-1a-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-app-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.erp-qa-app-subnet-1b-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-db-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.erp-qa-db-subnet-1a-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-db-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.erp-qa-db-subnet-1b-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-gen-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.erp-qa-gen-subnet-1a-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-gen-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.erp-qa-gen-subnet-1b-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-dmz-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.erp-qa-dmz-subnet-1a-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-dmz-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.erp-qa-dmz-subnet-1b-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-web-subnet-1a-1-ass" {
  subnet_id      = aws_subnet.erp-qa-web-subnet-1a-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

resource "aws_route_table_association" "erp-qa-web-subnet-1b-1-ass" {
  subnet_id      = aws_subnet.erp-qa-web-subnet-1b-1.id
  route_table_id = aws_route_table.erp-qa-private-1a-1b-rt.id
}

# Configure TGW Attachment

# resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
#   subnet_ids         = [aws_subnet.erp-qa-adapt-subnet-1a-1.id,aws_subnet.erp-qa-adapt-subnet-1b-1.id]
#   transit_gateway_id = aws_ec2_transit_gateway.example.id
#   vpc_id     = aws_vpc.erp-qa-vpc.id
# }

# Configure EC2 Servers

resource "aws_instance" "erp-qa-1a-m3-app-ec2" {
  ami           = "ami-03cd0a8eda2957211"
  instance_type = "t3a.2xlarge"
  subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
  tags          = local.common_tags
}

resource "aws_instance" "erp-qa-1a-m3-ui-ec2" {
  ami           = "ami-03cd0a8eda2957211"
  instance_type = "t3a.2xlarge"
  subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
  tags          = local.common_tags
}

resource "aws_instance" "erp-qa-1a-m3-home-ec2" {
  ami           = "ami-03cd0a8eda2957211"
  instance_type = "t3a.xlarge"
  subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
  tags          = local.common_tags
}

resource "aws_instance" "erp-qa-1a-m3-iso-ec2" {
  ami           = "ami-03cd0a8eda2957211"
  instance_type = "t3a.large"
  subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
  tags          = local.common_tags
}

resource "aws_instance" "erp-qa-1a-m3-ion-ec2" {
  ami           = "ami-03cd0a8eda2957211"
  instance_type = "t3a.large"
  subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
  tags          = local.common_tags
}

# Configure DB Servers

resource "aws_instance" "erp-qa-1a-m3-iosdb-ec2" {
  ami           = "ami-01912100188d48ee4"
  instance_type = "t3a.xlarge"
  subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
  tags          = local.common_tags
}

resource "aws_instance" "erp-qa-1a-m3-ancdb-ec2" {
  ami           = "ami-01912100188d48ee4"
  instance_type = "t3a.xlarge"
  subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
  tags          = local.common_tags
}

resource "aws_instance" "erp-qa-1a-m3-m3db-ec2" {
  ami           = "ami-01912100188d48ee4"
  instance_type = "t3a.2xlarge"
  subnet_id     = aws_subnet.erp-qa-app-subnet-1a-1.id
  tags          = local.common_tags
}

# Configure Security Groups

resource "aws_security_group" "erp-qa-sg" {
  # name        = "allow_tls"
  # description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.erp-qa-vpc.id

  ingress {
    from_port        = 22010
    to_port          = 22010
    protocol         = "tcp"
    cidr_blocks      = ["10.216.196.255/32"]
  }

  ingress {
    from_port        = 1433
    to_port          = 1433
    protocol         = "tcp"
    cidr_blocks      = ["10.216.196.255/32"]
  }

  ingress {
    from_port        = 1433
    to_port          = 1433
    protocol         = "tcp"
    cidr_blocks      = ["10.213.64.0/22"]
  }

  ingress {
    from_port        = 1433
    to_port          = 1433
    protocol         = "tcp"
    cidr_blocks      = ["10.213.68.0/22"]
  }

  ingress {
    from_port        = 1433
    to_port          = 1433
    protocol         = "tcp"
    cidr_blocks      = ["10.10.216.0/22"]
  }

  ingress {
    from_port        = 1433
    to_port          = 1433
    protocol         = "tcp"
    cidr_blocks      = ["10.213.90.0/23"]
  }

  ingress {
    from_port        = 16405
    to_port          = 16408
    protocol         = "tcp"
    cidr_blocks      = ["10.10.216.0/22"]
  }

  ingress {
    from_port        = 52220
    to_port          = 52220
    protocol         = "tcp"
    cidr_blocks      = ["10.10.216.0/22"]
  }

  ingress {
    from_port        = 22004
    to_port          = 22018
    protocol         = "tcp"
    cidr_blocks      = ["10.10.216.0/22"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["10.10.216.0/22"]
  }

  ingress {
    from_port        = 22007
    to_port          = 22018
    protocol         = "tcp"
    cidr_blocks      = ["10.213.64.0/22"]
  }

  ingress {
    from_port        = 22007
    to_port          = 22018
    protocol         = "tcp"
    cidr_blocks      = ["10.213.68.0/22"]
  }

  ingress {
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["10.0.0.0/8"]
  }

  ingress {
    from_port        = 1422
    to_port          = 1422
    protocol         = "tcp"
    cidr_blocks      = ["10.213.92.0/23"]
  }
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["10.214.70.178/32"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["10.216.165.137/32"]
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["10.216.164.129/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags          = local.common_tags
}


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

