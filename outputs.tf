output "governance_version" {
  value = var.governance_version
}

output "policy_definitions_count" {
  description = "Number of custom definitions managed by the catalog engine."
  value       = length(azurerm_policy_definition.catalog)
}

output "policy_set_definition_id" {
  value = azurerm_policy_set_definition.platform_baseline.id
}

output "policy_assignment_ids" {
  description = "Map of resource group names to policy assignment IDs."
  value = {
    for k, v in azurerm_resource_group_policy_assignment.baseline_assignment : k => v.id
  }
}

output "remediation_identities" {
  description = "Map of resource group names to their Managed Identity principal IDs."
  value = {
    for k, v in azurerm_resource_group_policy_assignment.baseline_assignment : k => v.identity[0].principal_id
  }
}