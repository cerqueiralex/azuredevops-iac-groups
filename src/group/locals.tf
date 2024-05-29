locals {
  user_descriptors = flatten([for user in data.azuredevops_users.default : user.users[*].descriptor])
}
