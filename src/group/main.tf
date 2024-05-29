data "azuredevops_project" "default" {
  name = "Azuredevops_Project_Name"
}

data "azuredevops_users" "default" {
  for_each       = var.emails
  principal_name = each.value
}

resource "azuredevops_group" "default" {
  scope        = data.azuredevops_project.default.id
  display_name = "${replace(lower(var.name), " ", "-")}-approvers"
}

resource "azuredevops_group_membership" "default" {
  group   = azuredevops_group.default.descriptor
  members = local.user_descriptors
}
