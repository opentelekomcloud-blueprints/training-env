# Generate Identity Projects

# Tenant Provider
provider "opentelekomcloud" {
  tenant_name = "eu-de"
  region      = "eu-de"
}

# Identity Project
resource "opentelekomcloud_identity_project_v3" "CA" {
  name = "eu-de_thw-project"
  description = "Test Project"
}

