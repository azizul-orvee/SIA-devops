
# Scopic Software DevOps Task by Azizul

The zip file should contain two folders, Intrastructure and Application. We'll begin by provisioning the Intrastructure.




## Tech Stack

**Infrastructure:** AWS, Terraform

**CI/CD:** Circle Ci

**Application:** Node, Express, React

## AWS servicec used:

**Frontend:** Cloudfront for CDN, S3 orign

**Backend:** Elastic Beanstalk

**Authentication:** AWS cognito

**Database:** RDS
## Infrastructure Provisioning

#### Step 1: Provisioning S3 State Bucket


- Navigate to the Terraform-state directory.
- Run the following commands to initialize Terraform and create the infrastructure:

```bash
terraform init
terraform plan
terraform apply
```
- Once the provisioning is complete, extract the outputs and save them to a file:
```bash
terraform output -json > outputs.json

```
- Open the outputs.json file and copy the value of s3-bucket-name.
#### Step 2: Provisioning Remaining Infrastructure

- Navigate to the Terraform directory.
- In main.tf on line 3, replace <bucket-name> with the s3-bucket-name value you copied from the previous step.
- Run the following commands to initialize Terraform and create the infrastructure:
```bash
terraform init
terraform plan
terraform apply -var 'beanstalkappenv=ScopicEnv' -var 'elasticapp=ScopicApp' -var 'elb_public_subnets=["subnet-041d20ec9feb666dd", "subnet-057aa400623fdf7e3"]' -var 'iam_role_name=<your-iam-role-name>' -var 'public_subnets=["subnet-041d20ec9feb666dd", "subnet-057aa400623fdf7e3"]' -var 'vpc_id=vpc-07365c98fd5f6fbec'


```
#### (please replace the variables, these are example variables from my aws account. Replace <your-iam-role-name> with the IAM role you created earlier. However, you can keep beanstalkappenv and elasticapp the same)
- This will start the provisioning process. Wait until it finishes.
- Once the provisioning is complete, extract the outputs and save them to a file:
```bash
terraform output -json > outputs.json

```

Remember to replace the placeholder values with your actual AWS resources and account information.


