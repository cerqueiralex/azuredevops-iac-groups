data "azuredevops_project" "dataname" {
  name = "Azuredevops_Project_Name"
}

data "azuredevops_users" "emails_all" {
  for_each       = local.l_emails_map
  principal_name = each.value
}

resource "azuredevops_environment" "env" {
  for_each   = local.envmap
  project_id = data.azuredevops_project.dataname.id
  name       = each.key
}

resource "azuredevops_check_approval" "approvals" {
  for_each                   = local.envmap
  project_id                 = data.azuredevops_project.dataname.id
  target_resource_id         = azuredevops_environment.env[each.key].id
  target_resource_type       = "environment"
  requester_can_approve      = true
  minimum_required_approvers = 1

  approvers = concat(
    [for x in each.value.groups : var.group_origin_ids[x]],
    [for x in each.value.emails : one(data.azuredevops_users.emails_all[x].users).id]
  )
}
