
# Continuous Integration/Continuous Deployment (CI/CD)

This section describes how to set up a CI/CD pipeline using CircleCI for the application.


## Prerequisites

- A CircleCI account
- Git installed on your local machine


## Steps

- Navigate to the Application directory. This directory contains two folders for the front-end and back-end parts of the application.

- Run git init in the root of the Application folder to initialize a new Git repository.
- Commit and push the repository to GitHub
- Log in to CircleCI and connect your repository to a new CircleCI project.
- CircleCI should automatically detect the .circleci/config.yml file in the repository. This file contains the configuration for the CI/CD pipeline.
- The pipeline is configured to trigger every time a change is pushed or merged into the main branch.



## CircleCI Environment Variables
You'll need to set the following environment variables in your CircleCI project settings:

- APPLICATION_NAME: Copy the value of beanstalk_application from the outputs.json file.
- ENVIRONMENT_NAME: Copy the value of beanstalk_environment from the outputs.json file.
- S3_FOR_BEANSTALK: Copy the S3 bucket name which was created by AWS Beanstalk.
- S3_FOR_CLIENT: Copy the value of frontend_bucket_name from the outputs.json file.
- AWS_REGION: Copy the value of REGION from the outputs.json file.
- AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY: Add your AWS credentials here.
##### With these environment variables set, CI/CD pipeline should run without any errors whenever a change is pushed to the main branch. The pipeline is configured to build the front-end application and push it to the S3 bucket, as well as zip the back-end application and upload it to Elastic Beanstalk.