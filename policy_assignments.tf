resource "azurerm_resource_group_policy_assignment" "baseline_assignment" {
  name                 = "assign-platform-baseline"
  resource_group_id    = var.assignment_scope
  policy_definition_id = azurerm_policy_set_definition.platform_baseline.id
  display_name         = "Platform Baseline Governance Assignment"
  description          = "Baseline guardrails enforced on workloads."
  enforce              = true
  location             = var.assignment_location

  identity {
    type = "SystemAssigned"
  }

  parameters = jsonencode({
    tagGovernanceEffect  = { value = var.tag_governance_effect }
    mandatoryTagName     = { value = var.mandatory_tag_name }
    hostEncryptionEffect = { value = var.host_encryption_effect }
    allowedVmSizes       = { value = var.allowed_vm_skus }
  })

  non_compliance_message {
    content                        = "Policy Violation: The selected VM SKU is unapproved. Consult platform documentation."
    policy_definition_reference_id = "AllowedVmSkusRef"
  }

  non_compliance_message {
    content                        = "Policy Violation: Mandatory '${var.mandatory_tag_name}' tag is missing from the resource payload."
    policy_definition_reference_id = "TagGovernanceRef"
  }

  non_compliance_message {
    content                        = "Policy Violation: VM host encryption is required for platform workloads."
    policy_definition_reference_id = "HostEncryptionRef"
  }
}