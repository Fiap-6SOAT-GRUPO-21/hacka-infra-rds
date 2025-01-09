data "aws_ssm_parameter" "vpc_id" {
  name = "/hacka/eks/vpc_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/hacka/eks/public_subnet_ids"
}

# RDS MSC MGMT MEDIA
module "msc_mgmt_media_rds" {
  source             = "./modules/postgres"
  region             = var.region
  availability_zone  = var.availability_zones[0]
  vpc_id             = data.aws_ssm_parameter.vpc_id.value
  database_subnetids = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  database_username  = var.msc_mgmt_media_database_credentials.username
  database_password  = var.msc_mgmt_media_database_credentials.password
  database_port      = var.msc_mgmt_media_database_credentials.port
  database_name      = var.msc_mgmt_media_database_credentials.name
}

resource "aws_ssm_parameter" "rds_msc_mgmt_media_db_url" {
  name  = "/hacka/msc_mgmt_media_rds/rds/db_url"
  type  = "String"
  value = module.msc_mgmt_media_rds.rds_endpoint
}

resource "aws_ssm_parameter" "rds_msc_mgmt_media_db_username" {
  name  = "/hacka/msc_mgmt_media_rds/rds/db_username"
  type  = "String"
  value = var.msc_mgmt_media_database_credentials.username
}

resource "aws_ssm_parameter" "rds_msc_mgmt_media_db_password" {
  name  = "/hacka/msc_mgmt_media_rds/rds/db_password"
  type  = "SecureString"
  value = var.msc_mgmt_media_database_credentials.password
}

resource "aws_ssm_parameter" "rds_msc_mgmt_media_db_port" {
  name  = "/hacka/msc_mgmt_media_rds/rds/db_port"
  type  = "String"
  value = var.msc_mgmt_media_database_credentials.port
}

resource "aws_ssm_parameter" "rds_msc_mgmt_media_db_name" {
  name  = "/hacka/msc_mgmt_media_rds/rds/db_name"
  type  = "String"
  value = var.msc_mgmt_media_database_credentials.name
}