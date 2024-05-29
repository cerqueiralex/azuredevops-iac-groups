locals {
  environments = flatten(values(var.environments))
  envmap       = { for n in local.environments : "${n.resource}-approvers-${n.name}" => n }
  l_emails     = distinct(flatten(local.environments[*].emails))
  l_emails_map = { for x in local.l_emails : x => x }
}
