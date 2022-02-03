variable "teamid" {
  description = "(Required) Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply'"
  type        = string
}

variable "prjid" {
  description = "(Required) Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply'"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual network."
  type        = string
}

variable "deploy_subnet" {
  description = "feature flag to deploy this resource or not"
  default     = true
  type        = bool
}

variable "subnet_cidr_list" {
  description = "The address prefixes for the subnet"
  default     = ["10.0.1.0/24"]
  type        = list(string)
}

variable "enforce_private_link_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false"
  default     = false
  type        = bool
}

variable "enforce_private_link_service_network_policies" {
  description = "Enable or Disable network policies for the private link service on the subnet. Setting this to true will Disable the policy and setting this to false will Enable the policy. Default value is false"
  default     = false
  type        = bool
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet. Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  default     = []
  type        = list(string)
}

variable "subnet_delegation" {
  description = <<EOD
Configuration delegations on subnet
object({
  name = object({
    name = string,
    actions = list(string)
  })
})
EOD
  type        = map(list(any))
  default     = {}
}

variable "subnet_name" {
  description = "Subnet name"
  default     = null
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual network name"
  default     = null
  type        = string
}
