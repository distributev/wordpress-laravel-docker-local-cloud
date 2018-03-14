
# Setup the local environment

1. Clone this project
2. Go to setup folder
3. Setup the local environment using

    ```
    PROJECT_PATH=path_to_your_new_project 
    WP_INIT=yes 

    and then run the command

    docker-compose up
    ```

    * You need to provide the path to the project where the setup will create the new bedrock project via `PROJECT_PATH` variable
    * `WP_INIT` has to be set to `yes` the first time in order to initialize the project (bedrock, sage,...), when omitted, the project will not be initialized and this assumes that `PROJECT_PATH` already contains bedrock project


# Setup the production environment on AWS

This section will guide you step by step how to provision production environment using an automated setup based on Terraform


## Prerequisites

1. [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
2. Generate AWS key/secret (If you already have that, skip this step)
[This guide to how to generate AWS keys](https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)
3. Generate 2 ssh keys
    * ssh key will be used to connect to EC2
    * ssh key will be used to push code to Dokku
You can also use the same ssh key for both connecting to EC2 and pushing code to Dokku
[This is guide to how to generate ssh key in Windows](https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-windows)

## Prepare the environment

1. Open terminal, clone this project and go to aws provisioning folder
2. Prepare variables. Check `variables.tf` to see full list of required variables, their default values and description
    * copy `secret.auto.tfvars.example` to `secret.auto.tfvars`. This file is intended to contains all secret variables and should not be versioned (it figures in `.gitignore` btw)
    * Fill all the other non secret variables in `variables.tf`
3. Install AWS Terraform provider with `terraform init`

## Provision AWS environment

Now, we are ready to launch our stack, but before, it's good to verify the plan that Terraform is willing to execute

```
terraform plan
```

This command will display all the resource that Terraform will create/update/delete. It's good practice to check that before proceeding to running the plan

Run the plan
```
terraform apply
```

When Terraform finish AWS resources creation, the EC2 ip address will be printed in the console. You need to set your domain to that ip address in your DNS
Note that, even after Terraform finish, you need to wait for `provision.sh` script to finish installing and configuring Dokku. To see the status of `provision.sh` execution, check `/var/log/cloud-init-output.log` log file
```
tail -f /var/log/cloud-init-output.log
```

## Deploy

### First time deployment

1. Go to the project folder
2. initialize git with `git init`
3. set git remote to Dokku server
    ```
    git remote add dokku dokku@$domain.tld:$wordpress
    ```
    Replace:
    * $domain.tld
    * $wordpress with `app_name` set before in `variables.tf`

4. Commit changes

First time 

`git add -A .`

`git commit -am "my first commit"`

5. `git push dokku master`

### Subsequent deployments

1. Commit changes
2. `git push dokku master`


## How To SSH to Dokku EC2?

### What and how needs to be configured in Putty for connecting to Dokku EC2?

### Which SSH user and password needs to be used in Putty for connecting to Dokku EC2?

## How To SSH to Docker Container?

### What and how needs to be configured in Putty for connecting to Docker Container?

### Which SSH user and password needs to be used in Putty for connecting to Docker Container?

