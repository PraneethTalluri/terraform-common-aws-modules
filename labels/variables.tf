variable "enabled" {
  description = "Set this to false to prevent this module from creating any resources"
  type        = bool
  default     = true
}

variable "namespace" {
  description = "Namespace - could be your organization name or abbreviation"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment e.g. 'prod', 'qa', 'dev'"
  type        = string
  default     = ""
}

variable "name" {
  description = "name, e.g. 'app name' or 'jenkins'"
  type        = string
  default     = ""
}

variable "delimiter" {
  description = "Delimiter to be used between 'namespace', 'environment', 'name' and 'attributes'"
  type        = string
  default     = "_"
}

variable "attributes" {
  description = "Additional attributes (e.g. ['abc',''xyz'])"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags (e.g. `map('Owner','XYZ')`"
  type        = map(string)
  default     = {}
}

variable "additional_tag_map" {
  description = "Additional tags for appending to each tag map"
  type        = map(string)
  default     = {}
}

variable "label_order" {
  description = "Naming order in the id"
  type        = list(string)
  default     = []
}

variable "filter_regex" {
  description = "Regex to replace chars in `namespace`, `environment` and `name` with an empty string. By default only hyphens, letters and digits are allowed, all other chars are removed"
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
}

variable "context" {
  description = "Default context to use for passing state between label invocations"
  type = object({
    enabled             = bool
    namespace           = string
    environment         = string
    name                = string
    delimiter           = string
    attributes          = list(string)
    label_order         = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    filter_regex = string
  })
  default = {
    enabled             = true
    namespace           = ""
    environment         = ""
    name                = ""
    delimiter           = ""
    attributes          = []
    label_order         = []
    tags                = {}
    additional_tag_map  = {}
    filter_regex = ""
  }
}

