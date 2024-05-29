variable "groups" {
  type = map(list(string))
}

variable "environments" {
  type = map(list(object({
    resource = string
    name     = string
    groups   = list(string)
    emails   = list(string)
  })))
}
