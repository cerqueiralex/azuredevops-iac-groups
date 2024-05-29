locals {
  group_origin_ids = { for name, output in module.group : name => output.group_origin_id }
}
