data "azurerm_subscription" "current" {}

data "azurerm_policy_definition" "allowed_vm_skus" {
  display_name = "Allowed virtual machine size SKUs"
}

data "azurerm_resource_group" "targets" {
  for_each = toset(var.target_resource_groups)
  name     = each.value
}