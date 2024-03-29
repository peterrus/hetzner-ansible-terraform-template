# Hetzner Ansible Terraform template

What's in the box:

- VPS/compute instance (Ubuntu 20.04) with persistent data volume
- Floating IP
- UFW Firewall on by default, only allowing rate limited SSH
- SSH Daemon with somewhat hardened default settings

# Bootstrap

## Terraform

```
cd terraform
terraform init
```

## Ansible

```
cd ansible
./bootstrap.sh # Installs ansible dependencies
```

If you wan't to use ansible-vault to store secrets in a local file (which you may, or may not commit to git, depending on your threat model):

```
# Create a vault, this will open your editor
# format is the same as all other variable files (like 'vars/variables/yml')
ansible-vault create secrets.yml.enc

# Optionally edit your vault afterwards
ansible-vault edit secrets.yml.enc
```

**By default the `secrets.yml.enc` file is not in `.gitignore`!**

# Running

## Terraform

*Creates infrastructure*

First create a `terraform/variables.auto.tfvars` file with the following content (adjust as needed, see [`variables.tf`](./terraform/variables.tf)).

```
hcloud_token = "redacted"
location = "nbg1"
server_name = "aloe-vera"
server_type = "cx21"
ssh_keys = ["hetzner_personal"]
volume_size = "32"
```

Once that is set up you can plan and apply:
```
cd terraform
terraform plan
terraform apply
```

Once the plan is executed you should be able to log in to your new server using (This connects via the regular non-floating ip outputted by terraform):
```
# Make sure your SSH key is loaded, use 'ssh-add ~/.ssh/<your_key>' if it is not.
ssh-add -l
ssh root@$(terraform output -raw server_ip)
```

## Ansible

*Provisions infrastructure*

```
cd ansible

# First we set a password for the administrative user so Ansible can use it instead of root.
# You get to choose this password and save it somewhere secure. Ansible will ask for this every
# run (the so called 'become' password).
ssh root@$(terraform -chdir=../terraform output -raw server_ip) passwd user

# Now we run the main playbook which will permanently disable root login through SSH
# and then run the rest of the playbook.
# This script will automatically unlock your vault when you have one (secrets.yml.enc).
./run.sh
```

# Destruction

- Remove the delete protection from the data volume through the Hetzner Cloud dashboard or `hcloud` cli utility (You will lose all data on this volume!).
- Optionally remove the delete protection from the floating ip so it also gets destroyed in the next step.
- `cd terraform; terraform destroy`
