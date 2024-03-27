module "label" {
  source = "cloudposse/label/null"
  version = "0.25.0"

  namespace = var.namespace
  stage = var.stage
  name = var.table_name
}

module "label_api" {
  source = "cloudposse/label/null"
  version = "0.25.0"

  name = "api"
  context = module.label.context
}

