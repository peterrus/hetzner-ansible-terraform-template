# Bootstrap

## Terraform

```
cd terraform
terraform init
```

## Ansible
TODO

# Running

## Terraform

First create a `terraform/variables.auto.tfvars` file with the following content (adjust as needed):

```
hcloud_token = "redacted"
location = "nbg1"
server_name = "aloe-vera"
server_type = "cx21"
ssh_keys = ["hetzner_personal"]
volume_size = "32"
```
You can find more information about these variables in the `variables.tf` file.

Once that is set up you can plan and apply:
```
cd terraform
terraform plan
terraform apply
```

Once the plan is executed you should be able to log in to your new server using (This connects via the floating ip):
```
ssh -i ~/.ssh/<your_ssh_key> root@$(terraform output -raw server_ip)
```

## Ansible
TODO

# Destruction

- Remove the delete protection from the data volume through the Hetzner Cloud dashboard or `hcloud` cli utility (You will lose all data on this volume!).
- Optionally remove the delet protection from the floating ip so it also gets destroyed in the next step.
- `cd terraform; terraform destroy`
