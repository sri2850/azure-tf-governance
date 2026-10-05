resource "azurerm_management_group_policy_assignment" "baseline_assignment" {
  name                 = "assign-platform-baseline"
  management_group_id  = var.management_group_id
  policy_definition_id = azurerm_policy_set_definition.platform_baseline.id
  display_name         = "Platform Baseline Governance [Enterprise MG]"
  description          = "Baseline guardrails inherited by all subscriptions and resource groups under this Management Group."
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
    content                        = "Platform Violation: Selected VM SKU is not permitted under corporate landing zone baseline."
    policy_definition_reference_id = "AllowedVmSkusRef"
  }

  non_compliance_message {
    content                        = "Platform Violation: Missing mandatory '${var.mandatory_tag_name}' tag."
    policy_definition_reference_id = "TagGovernanceRef"
  }

  non_compliance_message {
    content                        = "Platform Violation: Host encryption is required for all platform compute instances."
    policy_definition_reference_id = "HostEncryptionRef"
  }
}