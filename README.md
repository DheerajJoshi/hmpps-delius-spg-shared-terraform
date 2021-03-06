# hmpps-delius-spg-shared-terraform.
Terraform Repo for the SPG in the shared VPC

USING TERRAFORM
================

A shell script has been created to automate the running of terraform.
Script takes the following arguments

* environment_type: Target environment eg dev - prod - int
* action_type: Operation to be completed eg plan - apply - test - output
* AWS_TOKEN: token to use when running locally eg hmpps-token

Example

```
sh run.sh plan hmpps-token
```


REMOTE STATE
============

Bucket name: [tf-eu-west-2-hmpps-delius-core-dev-remote-state](https://s3.console.aws.amazon.com/s3/object/tf-eu-west-2-hmpps-delius-core-dev-remote-state/vpc/terraform.tfstate?region=eu-west-2&tab=overview)

DEPLOYER KEY
============

The deployer key is stored in AWS [Parameter store](https://eu-west-2.console.aws.amazon.com/systems-manager/parameters/tf-eu-west-2-hmpps-delius-core-dev-alfresco-ssh-private-key/description?region=eu-west-2)
```
terragrunt output ssh_private_key_pem
```


TERRAGRUNT
===========

## DOCKER CONTAINER IMAGE

Container repo [hmpps-engineering-tools](https://github.com/ministryofjustice/hmpps-engineering-tools)

To run the container please run the following steps

#### ARN FOR NON PROD ENGINEERING

```
arn:aws:iam::563502482979:role/terraform
```

#### TERRAFORM REPOS

[hmpps-delius-spg-shared-terraform](https://github.com/ministryofjustice/hmpps-delius-SPG-shared-terraform)

[hmpps-terraform-modules](https://github.com/ministryofjustice/hmpps-terraform-modules)

Ensure hmpps-engineering-platform-terraform is cloned into the current directory

```
running ls in pwd will show at the very least:
hmpps-delius-spg-shared-terraform
hmpps-engineering-platform-terraform
```

#### START UP

Provide the docker container with the following environment variables

```
AWS_PROFILE
```

#### COMMAND

cd to the directory above this repo, replace 'hmpps-token' in the command below with one of your own, and run
```
docker run -it --rm \
	-v $(pwd)/hmpps-delius-spg-shared-terraform:/home/tools/data \
	-v ~/.aws:/home/tools/.aws \
	-e AWS_PROFILE=hmpps-token \
	hmpps/terraform-builder:latest bash
```
Once in the container, run

```
source env_configs/dev.properties
```
Now navigate to the directory for your configuration (e.g. service-jenkins-eng) and run terragrunt commands as normal?

```
terragrunt plan -detailed-exitcode --out ${TG_ENVIRONMENT_TYPE}.plan
terragrunt apply ${TG_ENVIRONMENT_TYPE}.plan
```

Terraform - automated run
==========================

A python script has been written up: docker-run.py.

The script takes arguments shown below:

```
python docker-run.py -h
usage: docker-run.py [-h] --env ENV --action {apply,plan,test,output}
                     [--component COMPONENT] [--token TOKEN]

terraform docker runner

optional arguments:
  -h, --help            show this help message and exit
  --env ENV             target environment
  --action {apply,plan,test,output}
                        action to perform
  --component COMPONENT
                        component to run task on
  --token TOKEN         aws token for credentials
````

## Usage

When running locally provide the token argument:

```
python docker-run.py --env delius-core-dev --action output --component common --token hmpps-token
python docker-run.py --env delius-test --action output --component s3buckets --token hmpps-token
```

When running in CI environment:

```
python docker-run.py --env delius-core-dev --action test

```


INSPEC
======

[Reference material](https://www.inspec.io/docs/reference/resources/#aws-resources)

## TERRAFORM TESTING

#### Temporary AWS creds 

Script __scripts/aws-get-temp-creds.sh__ has been written up to automate the process of generating the creds into a file __env_configs/inspec-creds.properties__

#### Usage

```
sh scripts/generate-terraform-outputs.sh
sh scripts/aws-get-temp-creds.sh
source env_configs/inspec-creds.properties
inspec exec ${inspec_profile} -t aws://${TG_REGION}
```

#### To remove the creds

```
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
export AWS_PROFILE=hmpps-token
source env_configs/dev.properties
rm -rf env_configs/inspec-creds.properties
```

## Adding a new security group
```
Add new security group ids to the sg_map
  hmpps-delius-spg-shared-terraform/common/main.tf:sg_map_ids

```
