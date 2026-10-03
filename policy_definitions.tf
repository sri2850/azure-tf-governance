locals {
  definition_files = fileset("${path.module}/catalog/definitions", "*.json")

  definitions_raw = {
    for file in local.definition_files :
    trimsuffix(file, ".json") => jsondecode(file("${path.module}/catalog/definitions/${file}"))
  }
}

resource "azurerm_policy_definition" "catalog" {
  for_each = local.definitions_raw

  name         = each.value.name
  display_name = each.value.displayName
  description  = lookup(each.value, "description", null)
  policy_type  = "Custom"
  mode         = each.value.mode

  metadata = jsonencode({
    version  = var.governance_version
    category = lookup(each.value, "category", "Platform Governance")
  })

  parameters  = jsonencode(each.value.parameters)
  policy_rule = jsonencode(each.value.policyRule)
}