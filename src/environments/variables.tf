variable "environments" {
  type = map(list(object({
    resource = string
    name     = string
    groups   = list(string)
    emails   = list(string)
  })))
}

variable "group_origin_ids" {
  type = map(string)
}
