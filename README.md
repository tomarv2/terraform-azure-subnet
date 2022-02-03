<p align="center">
    <a href="https://github.com/tomarv2/terraform-azure-subnet/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-azure-subnet/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-azure-subnet" /></a>
    <a href="https://github.com/tomarv2/terraform-azure-subnet/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-azure-subnet" /></a>
    <a href="https://github.com/tomarv2/terraform-azure-subnet/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-azure-subnet" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

# Terraform module to create Azure Subnet

## Versions

- Module tested for Terraform 1.0.1.
- Azure provider version [2.90.0](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-azure-subnet/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-azure-subnet" /></a> in your releases)

## Usage

### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

### Option 2:

#### Recommended method (stores remote state in storage using `prjid` and `teamid` to create directory structure):

- Create python 3.8+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote --upgrade
```

- Set below environment variables:
```
export TF_AZURE_STORAGE_ACCOUNT=tfstatexxxxx # Output of remote_state.sh
export TF_AZURE_CONTAINER=tfstate # Output of remote_state.sh
export ARM_ACCESS_KEY=xxxxxxxxxx # Output of remote_state.sh
```

- Updated `examples` directory to required values

- Run and verify the output before deploying:
```
tf -c=azure plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=azure apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=azure destroy -var='teamid=foo' -var='prjid=bar'
```
**NOTE:**

- Read more on [tfremote](https://github.com/tomarv2/tfremote)

### [Authenticate with Azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)

Terraform supports a number of different methods for authenticating to Azure:

- Authenticating to Azure using the Azure CLI
- Authenticating to Azure using Managed Service Identity
- Authenticating to Azure using a Service Principal and a Client Certificate
- Authenticating to Azure using a Service Principal and a Client Secret

---

##### Create Subnet

```
provider "azurerm" {
  features {}
}

module "subnet" {
  source              = "../../"

  virtual_network_name = "demo-vnet"
  resource_group_name = "demo-resource_group"
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid

}
```

##### Create Subnet with Network security group

```
provider "azurerm" {
  features {}
}

module "network_security_group" {
  source = "git@github.com:tomarv2/terraform-azure-network-security-group.git"

  resource_group_name = "demo-resource_group"
  location            = "westus2"
  source_address      = "10.2.0.0/18"
  dest_port           = ["80", "22"]
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

module "subnet" {
  source = "../../"

  virtual_network_name = "demo-vnet"
  resource_group_name = "demo-resource_group"
  # ---------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}

resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  subnet_id                 = module.subnet.subnet_id
  network_security_group_id = module.network_security_group.network_security_group_id
}
```

Please refer to examples directory [link](examples) for references.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.90 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.90 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_subnet"></a> [deploy\_subnet](#input\_deploy\_subnet) | feature flag to deploy this resource or not | `bool` | `true` | no |
| <a name="input_enforce_private_link_endpoint_network_policies"></a> [enforce\_private\_link\_endpoint\_network\_policies](#input\_enforce\_private\_link\_endpoint\_network\_policies) | Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false | `bool` | `false` | no |
| <a name="input_enforce_private_link_service_network_policies"></a> [enforce\_private\_link\_service\_network\_policies](#input\_enforce\_private\_link\_service\_network\_policies) | Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `"westus2"` | no |
| <a name="input_network_security_group_name"></a> [network\_security\_group\_name](#input\_network\_security\_group\_name) | The Network Security Group name to associate with the subnets | `string` | `null` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | (Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. | `string` | n/a | yes |
| <a name="input_service_endpoints"></a> [service\_endpoints](#input\_service\_endpoints) | The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web. | `list(string)` | `[]` | no |
| <a name="input_subnet_cidr_list"></a> [subnet\_cidr\_list](#input\_subnet\_cidr\_list) | The address prefixes for the subnet | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_subnet_delegation"></a> [subnet\_delegation](#input\_subnet\_delegation) | Configuration delegations on subnet<br>object({<br>  name = object({<br>    name = string,<br>    actions = list(string)<br>  })<br>}) | `map(list(any))` | `{}` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Subnet name | `string` | `null` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | (Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | Virtual network name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of the resource group in which the subnet is created in |
| <a name="output_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#output\_subnet\_address\_prefixes) | The address prefixes for the subnet |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The subnet ID |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The subnet name |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of the virtual network in which the subnet is created in |
