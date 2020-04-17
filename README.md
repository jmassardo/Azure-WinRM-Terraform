# Azure-WinRM-Terraform

## Summary

This is an example of using Terraform to provision a Windows 2019 server on Azure using a WinRM HTTP listener. It also shows how to provision and execute a configuration script, in this case, it sets up the [Habitat Supervisor](https://www.habitat.sh) as a Windows service.

## Usage

To provision using this sample, follow these steps:

- Clone this repo
- Copy `tfvars.example` to `terraform.tfvars`
- Update the items in `terrafrom.tfvars` with your info
- Depending on your auth type with Azure, you may need to create a `~/.azure/credentials` or run `az login`. More info about authentifcation with Terraform and Azure [here](https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html).
- Run `terraform apply`