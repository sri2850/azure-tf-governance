variable "governance_version" {
  type        = string
  description = "CalVer release tag passed from CI/CD (e.g. 2026.2.0 or 2026.3.0-dev)."
  default     = "2026.2.0"
}

variable "assignment_scope" {
  type        = string
  description = "Target ARM Scope ID (Resource Group or Subscription ID)."
}

variable "assignment_location" {
  type        = string
  description = "Region for Managed Identity provisioning."
  default     = "eastus"
}

variable "tag_governance_effect" {
  type        = string
  description = "Effect for Tag Governance: Audit (for bake-in) or Deny (for enforcement)."
  default     = "Deny"
}

variable "mandatory_tag_name" {
  type        = string
  description = "Mandatory governance tag key."
  default     = "CostCenter"
}

variable "host_encryption_effect" {
  type        = string
  description = "Effect for host encryption policy."
  default     = "Audit"
}

variable "allowed_vm_skus" {
  type        = list(string)
  description = "List of approved Azure VM SKUs."
  default     = ["Standard_B2s", "Standard_D2s_v5", "Standard_D4s_v5"]
}

variable "target_resource_groups" {
  type        = list(string)
  description = "List of target resource group names where baseline governance will be enforced."
  default     = ["rg-governance-test-eastus"]
}