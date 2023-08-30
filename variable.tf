
# Define assume role variables

variable "provider_env_roles"{
  type = map(string)
  default = {
    "sand-box"           = ""
    "log-archive"        = "arn:aws:iam::0981156XXXXX:role/BAL-terraform-assume-role"
    "bi-dev"             = "arn:aws:iam::1506504XXXXX:role/BAL-terraform-assume-role"
    "bi-prod"            = "arn:aws:iam::5748233XXXXX:role/BAL-terraform-assume-role"
    "bi-uat"             = "arn:aws:iam::4051738XXXXX:role/BAL-terraform-assume-role"
    "bpo-prod"           = "arn:aws:iam::9289046XXXXX:role/BAL-terraform-assume-role"
    "erp-dev"            = "arn:aws:iam::9427851XXXXX:role/BAL-terraform-assume-role"
    "erp-teamshare"      = "arn:aws:iam::3050592XXXXX:role/BAL-terraform-assume-role"
    "erp-uat"            = "arn:aws:iam::1190XXXXX333:role/BAL-terraform-assume-role"
    "log-prod"           = "arn:aws:iam::1344XXXXX995:role/BAL-terraform-assume-role"
    "network-prod"       = "arn:aws:iam::502XXXXX6305:role/BAL-terraform-assume-role"
    "reporting-dev"      = "arn:aws:iam::2608XXXXX364:role/BAL-terraform-assume-role"
    "reporting-prod"     = "arn:aws:iam::2517XXXXX295:role/BAL-terraform-assume-role"
    "reporting-uat"      = "arn:aws:iam::682XXXXX1111:role/BAL-terraform-assume-role"
    "security-prod"      = "arn:aws:iam::92497XXXXX35:role/BAL-terraform-assume-role"
    "shared-services"    = "arn:aws:iam::328XXXXX4982:role/BAL-terraform-assume-role"
    "sharedservice-dev"  = "arn:aws:iam::3XXXXX757423:role/BAL-terraform-assume-role"
    "sharedservice-prod" = "arn:aws:iam::45XXXXX34444:role/BAL-terraform-assume-role"
    "sharedservice-uat"  = "arn:aws:iam::018XXXXX9911:role/BAL-terraform-assume-role"
    "audit-prod"         = "arn:aws:iam::7822XXXXX582:role/BAL-terraform-assume-role"
  }
}

# Define variables required for alarms

variable alarm_type {
  type        = list(string) 
  description = "Different Alarm Types"
}

variable evaluation_periods{
  type        = list(string) 
  description = "Evaluation Periods"
}

variable metric_name {
  type        = list(string) 
  description = "Metric Name"
}   

variable name_space {
  type        = list(string) 
  description = "Name Space"
}

variable period {
  type        = list(string) 
  description = "Period"
}

variable statistic {
  type        = list(string) 
  description = "Statistic"
}

variable threshold {
  type        = list(string) 
  description = "Threshold"
}

# Define instance ids

variable instance_id {
  type        = list(string) 
  description = "ID of each instance"
}

################################

variable account_name {
  type        = string 
  description = "Name of the account"
}

variable resource_type {
  type        = list(string) 
  description = "Name of the resource type relevent to the alarm"
}

variable metric_filter {
  type        = list(string) 
  description = "Syntax of metric filter"
}
