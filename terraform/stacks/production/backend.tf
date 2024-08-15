# backend "s3" {
#   bucket         = "uptime-prod-stack-tfstate"
#   key            = "state/terraform.tfstate"
#   region         = "eu-west-1"
#   encrypt        = true
#   dynamodb_table = "mycomponents_tf_lockid"
# }
