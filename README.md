# terraform_docker-Traefik
Terraform Module for Traefik Docker Container

## Setup
To create an Traefik container:

```
$ terraform init
$ terraform apply
```
Go to http://127.0.0.1:8080 to Traefik Dashboard.

## Module
For use this on your project, add the following lines to your terraform file:

```
module "traefik" {
    source = "git@github.com:sburgosl/terraform_docker-Traefik.git"
}
```

## Variables
#### Traefik Version
To select Traefik image version change the variable `traefik_version` with desired image tag.
For example:
```
variable "traefik_version" {
  type        = string
  default     = "v2.3.2"
  description = "Docker Image Tag"
}
```

#### Traefik Config Path
Change the variable `traefik_conf` with the desired host file path.
Docker will only load this configuration if the file exists.


#### Change Dashboard (HTTP)
You can change the dashboard http external port.
Select port in `web_ui_port` variable.


#### Dashboard through Traefik
To use the Dashboard through Traefik reverse proxy, set the variable `dashboard_router` to **true**.
When using this option, the dashboard port will not be exposed outside the container.


#### Domain Name
Set your domain in the variable `domain_name` to use in Host router Rule"

## Work In progress
- [ ] HTTPs configuration.