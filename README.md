# CloudPlatform AWS Infrastructure (Terraform)

A production-style AWS platform built with Terraform using a modular
architecture and multiple environments (`dev` and `prod`).

This project demonstrates how to design and provision a scalable,
secure, and observable application platform on AWS.

------------------------------------------------------------------------

## 🚀 Platform capabilities

This infrastructure includes:

-   Multi-AZ VPC networking
-   Public and private subnet architecture
-   Internet Gateway + NAT Gateway
-   Application Load Balancer (ALB)
-   Auto Scaling Group with Launch Template
-   Private EC2 instances (no public IP)
-   IAM role + AWS Systems Manager (SSM) access
-   CloudWatch monitoring and alarms
-   Private RDS database with Secrets Manager
-   Environment isolation (dev and prod)

------------------------------------------------------------------------

## 📁 Repository structure

    AWS-PRODUCTION/
    ├── environments/
    │   ├── dev/
    │   └── prod/
    ├── modules/
    │   ├── vpc/
    │   ├── security-groups/
    │   ├── alb/
    │   ├── asg/
    │   ├── iam/
    │   ├── monitoring/
    │   └── rds/
    ├── README.md
    └── .gitignore

------------------------------------------------------------------------

## 🏗️ Architecture diagram

### Network and compute flow

                        Internet
                           |
                           v
                +-----------------------+
                |   Application LB      |
                |  (Public Subnets)     |
                +----------+------------+
                           |
                           v
                   Target Group :8080
                           |
                           v
            +--------------------------------+
            |     Auto Scaling Group         |
            |     EC2 instances (Private)    |
            +--------------------------------+
                           |
                           v
                      AWS SSM Access
                   (no SSH required)

### Data layer

          EC2 Application Tier (Private)
                     |
                     v
            +---------------------+
            |        RDS          |
            |   (Private Subnets) |
            +---------------------+

------------------------------------------------------------------------

## 🔐 Security model

-   EC2 instances run in private subnets
-   ALB is the only public entry point
-   Application security group allows traffic only from ALB SG
-   RDS security group allows traffic only from App SG
-   Access to instances via AWS Systems Manager (Session Manager)
-   No SSH exposure

------------------------------------------------------------------------

## 📊 Observability

CloudWatch alarms monitor:

-   Target group unhealthy hosts
-   Target 5XX errors
-   ALB 5XX errors
-   Application latency
-   Auto Scaling capacity health

------------------------------------------------------------------------

## ⚙️ How to run

Initialize and deploy an environment:

    terraform -chdir=environments/dev init
    terraform -chdir=environments/dev plan
    terraform -chdir=environments/dev apply

For production:

    terraform -chdir=environments/prod init
    terraform -chdir=environments/prod plan
    terraform -chdir=environments/prod apply

------------------------------------------------------------------------

## 🌍 Environments

  Environment   Purpose                   Sizing
  ------------- ------------------------- -----------------
  dev           Testing and development   smaller
  prod          Production baseline       multi-AZ and HA

------------------------------------------------------------------------

## 📤 Outputs

After deployment:

    terraform -chdir=environments/dev output alb_dns_name

Test the platform:

    http://<alb_dns_name>

------------------------------------------------------------------------

## 🎯 Project goals

This project demonstrates:

-   Modular Terraform design
-   Environment separation
-   Production networking patterns
-   Private compute architecture
-   Autoscaling patterns
-   Infrastructure observability
-   Secure database access model

------------------------------------------------------------------------

## 📜 License

MIT
