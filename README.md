# Set up a single VPS in Hetzner Cloud

This terraform script sets up a single VPS in Hetzner Cloud ready to be used with Kamal.

## Why a single VPS?

I love the Django, SQLite, and Redis combo. So I like setting up a single VPS where I can have everything I need.

## How to use it

1. Generate two SSH keys, one for the root user and one for the kamal user using `make generate-ssh-key USER_NAME=root` and `make generate-ssh-key USER_NAME=kamal`
2. Generate a new API key in Hetzner Cloud and save it in a secure place
3. Create a file `terraform.tfvars` at the root of the repository with your Hetzner API key and SSH keys, it will look like this:
   ```terraform
   hetzner_api_key = "your-api-key"
   ssh_vps_root_key = "<your-ssh-root-public-key>"
   ssh_vps_kamal_key = "<your-ssh-kamal-public-key>"
   ```
4. Run `terraform init` to initialize the terraform environment
5. Run `terraform plan` to see the changes that will be applied
6. Run `terraform apply` to apply the changes

## Acknowledgements

This script is based on the great work of [luizkowalski](https://github.com/luizkowalski) in [terraform-hetzner](https://github.com/luizkowalski/terraform-hetzner).
