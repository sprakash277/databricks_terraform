Step1. Get the AWS credentails
    
    For Databricks AWS, use gimme-aws-creds commannd
          i. brew install gimme-aws-creds
         ii. curl "https://gimmecreds.sec.databricks.com/?username=xxxxx" --silent --output ~/.okta_aws_login_config 
        iii. Run "gimme-aws-creds" that creates temporary Credentials file in "~/.aws/credentials "
        
Step2. Use the Credentials profile of AWS in Terraform  (~/.aws/credentials)  




export TF_VAR_databricks_account_id="CHANGE_ME"

export TF_VAR_databricks_account_username="CHANGE_ME"

export TF_VAR_databricks_account_password="CHANGE_ME"

export TF_VAR_aws_profile="CHANGE_ME"

export TF_VAR_region="CHANGE_ME"

export TF_VAR_cross_account_role_arn="CHANGE_ME"

export TF_VAR_Owner="CHANGE_ME"

export TF_VAR_prefix="CHANGE_ME"

export TF_VAR_unity_metastore_bucket="CHANGE_ME"

export TF_VAR_unity_metastore_iam="CHANGE_ME"

export TF_VAR_unity_admin_groups="CHANGE_ME"

cd aws/aws-e2workspace
 -- Initialize terraform

terraform init

--- Apply and deploy clusters

terraform apply

Clean up step
terraform destroy
