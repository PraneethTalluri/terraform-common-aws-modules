output "id" {
  description = "Fully formatted name ID"
  value       = local.enabled ? local.id : ""
}

output "namespace" {
  description = "Namespace"
  value       = local.enabled ? local.namespace : ""
}

output "environment" {
  description = "Environment"
  value       = local.enabled ? local.environment : ""
}

output "name" {
  description = "Name"
  value       = local.enabled ? local.name : ""
}

output "attributes" {
  description = "List of attributes"
  value       = local.enabled ? local.attributes : []
}

output "delimiter" {
  description = "Delimiter between `namespace`, `environment`, `name` and `attributes`"
  value       = local.enabled ? local.delimiter : ""
}

output "tags" {
  description = "Maps of Tags"
  value       = local.enabled ? local.tags : {}
}

output "tags_as_list_of_maps" {
  description = "Additional tags as a list of maps, which can be used in several AWS resources"
  value       = local.tags_as_list_of_maps
}

output "label_order" {
  description = "The naming order of the id output and Name tag"
  value       = local.label_order
}

output "context" {
  description = "Context of this module to pass to other label modules"
  value       = local.output_context
}

