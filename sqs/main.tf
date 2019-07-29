module "labels" {
  source        = "../labels"
  enabled             = var.enabled
  name                = var.name
  namespace           = var.namespace
  environment         = var.environment
  attributes          = var.attributes
  tags                = var.tags
  delimiter           = var.delimiter
  label_order         = var.label_order
  filter_regex        = var.filter_regex
  additional_tag_map  = var.additional_tag_map
}

resource "aws_sqs_queue" "queue_deadletter" {
  count = var.enable && var.enable_dlq ? 1 : 0
  name = "${module.labels.id}-dlq"
  delay_seconds = var.dlq_delay_seconds != "" ? var.dlq_delay_seconds : var.delay_seconds
  max_message_size = var.dlq_max_message_size != "" ? var.dlq_max_message_size : var.max_message_size
  message_retention_seconds = var.dlq_message_retention_seconds != "" ? var.dlq_message_retention_seconds : var.message_retention_seconds
  visibility_timeout_seconds = var.dlq_visibility_timeout_seconds != "" ? var.dlq_visibility_timeout_seconds : var.visibility_timeout_seconds

  tags = merge(
  module.labels.tags,
  map("Name", "${module.labels.id}-dlq")
  )
}


resource "aws_sqs_queue" "queue" {
  count                      = var.enable && !var.enable_dlq ? 1 : 0
  name                       = module.labels.id
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  tags                       = module.labels.tags
}

resource "aws_sqs_queue" "queue_with_dlq" {
  count                      = var.enable && var.enable_dlq ? 1 : 0
  name                       = module.labels.id
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  tags                       = module.labels.tags
  redrive_policy             = "{\"deadLetterTargetArn\":\"${element(aws_sqs_queue.queue_deadletter.*.arn, count.index)}\",\"maxReceiveCount\":${var.max_receive_count}}"
}
