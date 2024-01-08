variable "configuration" {
  description = "Configuration to use for the deployment"
  type = list(object({
    name         = string
    count        = number
    labels       = map(list(string))
    machine_type = string
    image        = string
    tags         = optional(list(string))
    disk = optional(object({
      name = string
      size = number
      type = string
    }))
  }))
}
