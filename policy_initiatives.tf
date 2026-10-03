locals {
  initiative_raw = jsondecode(file("${path.module}/catalog/initiatives/baseline_governance.json"))
}

resource "azurerm_policy_set_definition" "platform_baseline" {
  name         = local.initiative_raw.name
  policy_type  = "Custom"
  display_name = local.initiative_raw.displayName
  description  = local.initiative_raw.description

  metadata = jsonencode({
    version  = var.governance_version
    category = "Platform Governance"
  })

  parameters = jsonencode({
    tagGovernanceEffect = {
      type         = "String"
      defaultValue = var.tag_governance_effect
      metadata = {
        displayName = "Tag Governance Effect"
      }
    }
    mandatoryTagName = {
      type         = "String"
      defaultValue = var.mandatory_tag_name
      metadata = {
        displayName = "Required Tag Name"
      }
    }
    hostEncryptionEffect = {
      type         = "String"
      defaultValue = var.host_encryption_effect
      metadata = {
        displayName = "Host Encryption Effect"
      }
    }
    allowedVmSizes = {
      type         = "Array"
      defaultValue = var.allowed_vm_skus
      metadata = {
        displayName = "Allowed VM SKUs"
      }
    }
  })

  dynamic "policy_definition_reference" {
    for_each = local.initiative_raw.policies
    content {
      policy_definition_id = lookup(policy_definition_reference.value, "definitionKey", null) != null ? (
        azurerm_policy_definition.catalog[policy_definition_reference.value.definitionKey].id
      ) : data.azurerm_policy_definition.allowed_vm_skus.id

      reference_id = policy_definition_reference.value.referenceId

      parameter_values = jsonencode({
        for param_key, param_value in policy_definition_reference.value.parameters :
        param_key => {
          value = param_value
        }
      })
    }
  }
}