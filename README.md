# Unit 4 – Launch a Windows VM and Connect Using RDP

**Student:** Jagruti Pawar  
**PRN:** 2124UCSF1046  
**Course area:** Cloud Security

## Contents

- `main.tf` – AWS provider, Windows Server 2022 AMI lookup, restricted RDP security group, and EC2 instance.
- `variables.tf` – Configurable AWS region, network IDs, key pair, and administrator public IP.
- `outputs.tf` – Instance ID, public IPv4 address, and security-group ID.
- `terraform.tfvars.example` – Example configuration with placeholders.
- `screenshots/` – Screenshots supplied for the assignment.
- `Unit_4_Assignment_Report.pdf` – Assignment report supplied with the request.

## Important screenshot note

The provided screenshots include labels such as “example,” “illustrative output,” and “use your actual screenshot.” They are included as **reference/sample screenshots**, not as proof that the resources were actually created. Replace them with screenshots from your own AWS account and Windows VM after completing the lab.

## Prerequisites

1. Terraform CLI installed.
2. AWS CLI installed and configured with credentials for your own AWS account, or another supported AWS credential method.
3. An existing VPC and a **public subnet** with a route to an Internet Gateway.
4. An existing EC2 key pair in the selected AWS region.
5. Your current public IPv4 address.

Use a lab account and review AWS pricing before creating resources. Windows EC2 instances can incur charges.

## Configure

1. Copy `terraform.tfvars.example` to `terraform.tfvars`.
2. Replace the placeholders with your actual values:
   - `admin_public_ip`: your public IPv4 address, without `/32`
   - `key_pair_name`: an existing EC2 key pair name
   - `vpc_id`: your VPC ID
   - `subnet_id`: your public subnet ID
3. Do not upload `terraform.tfvars`, AWS credentials, passwords, or private key files to GitHub.

## Run Terraform

From this folder, run:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Review the plan before approving `terraform apply`. The code creates an EC2 Windows Server instance and a security group allowing TCP port 3389 **only** from `admin_public_ip/32`.

The configuration expects an existing VPC, public subnet, and EC2 key pair. It does not create these network prerequisites.

## Connect and finish the practical

1. In AWS Console → EC2, wait until the instance is `Running` and status checks pass.
2. Use **Connect → RDP client** to retrieve/decrypt the initial Administrator password using the matching private key, where supported.
3. Connect to the instance's public IPv4 address using Remote Desktop Connection (`mstsc`) from a Windows computer.
4. On the Windows VM, run the PowerShell commands in the assignment report to inspect system information, create the `labuser` account, enable Windows Firewall, and create the desktop text file.
5. Capture your own actual screenshots for the report/repository. Never show the actual password.

## Clean up

When the lab is complete, remove resources to avoid ongoing charges:

```bash
terraform destroy
```

Review the plan and confirm before destroying. This removes the EC2 instance and security group managed by this configuration; it does not remove your pre-existing VPC, subnet, or key pair.

## Security notes

- Never open RDP to `0.0.0.0/0`.
- Restrict port 3389 to your current trusted IP address. If your public IP changes, update `admin_public_ip` and apply again.
- Keep private keys and AWS credentials out of the repository.
- Confirm the AWS region, instance type pricing, and Free Tier eligibility (if applicable) before applying.
