module "group" {
  source   = "./group"
  for_each = var.groups
  name     = each.key
  emails   = each.value
}

module "environments" {
  source           = "./environments"
  environments     = var.environments
  group_origin_ids = local.group_origin_ids
}
