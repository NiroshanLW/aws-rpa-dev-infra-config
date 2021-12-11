#bi-dev
#instance_id = ["i-03b63e5421d48cf40","i-04e0632789188eb6d"]

#bi-prod
#instance_id = ["i-0d0a7db112186616f","i-0dcf4b08855dc31a6"]

#bi-uat
#instance_id = ["i-062dc80e9a18c52db","i-07a124af8e9b35488"]

#bpo-prod
#instance_id = ["i-0cc99688a6e72b036","i-08c505743fc67b9da","i-0db17f2a0bba5c03a","i-01fceefdaa2b63d0e","i-02c6289bdb8836412","i-0e9cbc8e6f4f3390c","i-0e6b834e65fcdc5f8","i-039e064cbb6d65a82","i-0bcb9ffe6f69fb08a","i-06cd06c92d0e99c34","i-098d47967e4b638d2"]

#erp-dev
#instance_id = ["i-076b1d07fce4954fc","i-0b50d4960f299f766","i-07a05215aa144e68e","i-028166c7f96ad693f","i-0d05c76e2aeb9deb5","i-0be1fd72499051467","i-079ae70c192d45570","i-0383edde0d9606f01","i-0ec394412b09d1d5e","i-01f9eb7e9bf259e7c"]

#erp-teamshare
#instance_id = ["i-0d4eabc2a9321e2e0","i-0a83f739b2daf011f"]

#erp-uat
#instance_id = ["i-006df75a6a750fddd","i-043f2daaddccd30af","i-054ed859ede27ccd8","i-09bc14210fd984654","i-00e91ecb35cb54ec3","i-0cb35c16b8b6f3016","i-0c057837875cf895c","i-0471678e82c43214a"]

#network-prod
#instance_id = ["i-0e8c0489845dc9420","i-07d4d45e297a07432","i-000a7f1e647d7c4d0","i-06c8753a4d4005db5","i-085dc3deac286a4f3","i-010ebe7f1d526cd18","i-0b314c7f4583989cb","i-06c5aae2dbfe88ee5"]

#reporting-dev
#instance_id = ["",""]

#reporting-prod
#instance_id = ["i-05b16e6a46ac3741b","i-02975926156c5d1a2"]

#reporting-uat
#instance_id = ["",""]

#shared-services
#instance_id = ["i-05bc9183fab73d4da","i-00d80b184994291d9","i-0c78c3d388fb797b4","i-0b526c55ea5c3b573",]

#sharedservice-dev
#instance_id = ["i-005d77db5d62ee9ab","i-03105ce9523e4ac34","i-0a5b82a9fa0fceca4","i-0a180b890e73ddebd","i-0d62f5adfc1e10648"]

#sharedservice-uat
instance_id = ["i-0dd1002f9c705181e","i-0b537900bdb11dbc3","i-09b89c43c2ab754f8"]

######################################################

alarm_type         = ["backup-failed","vpn-status"]

evaluation_periods = ["1","1"]
metric_name        = ["NumberOfBackupJobsFailed","TunnelState"] 
name_space         = ["Backup","AWS/VPN"]
period             = ["300","60"]
statistic          = ["Sum","Sum"]
threshold          = ["1","1"]


##########################

account_name  = "sandbox" 

resource_type = ["securitygroup","networkacl","igw","routetable","vpc","cloudtrail","iampolicy","cmk","s3policy","awsconfig"] 

metric_filter = ["{($.eventName=AuthorizeSecurityGroupIngress) || ($.eventName=AuthorizeSecurityGroupEgress) || ($.eventName=RevokeSecurityGroupIngress) || ($.eventName=RevokeSecurityGroupEgress) || ($.eventName=CreateSecurityGroup) || ($.eventName=DeleteSecurityGroup)}","{($.eventName=CreateNetworkAcl) || ($.eventName=CreateNetworkAclEntry) || ($.eventName=DeleteNetworkAcl) || ($.eventName=DeleteNetworkAclEntry) || ($.eventName=ReplaceNetworkAclEntry) || ($.eventName=ReplaceNetworkAclAssociation)}","{($.eventName=CreateCustomerGateway) || ($.eventName=DeleteCustomerGateway) || ($.eventName=AttachInternetGateway) || ($.eventName=CreateInternetGateway) || ($.eventName=DeleteInternetGateway) || ($.eventName=DetachInternetGateway)}","{($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable)}","{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}","{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}","{($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy)}","{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}","{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}","{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"]
