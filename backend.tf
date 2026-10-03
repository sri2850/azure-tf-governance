terraform {
  required_version = ">=1.5.0"
  # Partial backend configuration
  # Specific parameters supplied at `terraform init -backend-config=...`
  backend "azurerm" {}
}