variable "governance_version" {
  type        = string
  description = "CalVer release tag passed from CI/CD."
  default     = "2026.2.0"
}

variable "management_group_id" {
  type        = string
  description = "ARM Resource ID of the target Management Group (e.g. /providers/Microsoft.Management/managementGroups/<MG_ID>)."
}

variable "assignment_location" {
  type        = string
  description = "Primary region for Policy Managed Identity provisioning."
  default     = "eastus"
}

variable "tag_governance_effect" {
  type    = string
  default = "Deny"
}

variable "mandatory_tag_name" {
  type    = string
  default = "CostCenter"
}

variable "host_encryption_effect" {
  type    = string
  default = "Audit"
}

variable "allowed_vm_skus" {
  type    = list(string)
  default = ["Standard_B2s", "Standard_D2s_v5", "Standard_D4s_v5", "Standard_D2as_v4"] # Added your D2as_v4 SKU
}