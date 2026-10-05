output "governance_version" {
  value = var.governance_version
}

output "policy_definitions_count" {
  value = length(azurerm_policy_definition.catalog)
}

output "policy_set_definition_id" {
  value = azurerm_policy_set_definition.platform_baseline.id
}

output "policy_assignment_id" {
  value = azurerm_management_group_policy_assignment.baseline_assignment.id
}

output "remediation_identity_principal_id" {
  value = azurerm_management_group_policy_assignment.baseline_assignment.identity[0].principal_id
}