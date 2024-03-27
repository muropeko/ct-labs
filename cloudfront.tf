module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  default_root_object = "index.html"
  comment             = "My awesome CloudFront"
  enabled             = true
  price_class         = "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }


  origin = {
    s3_one = {
      domain_name = "590184041689-s3-frontend.s3.eu-north-1.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }
  

  default_cache_behavior = {
    target_origin_id           = "s3_one"
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }


  custom_error_response = [{
    error_code = 404
    response_code = 200
    response_page_path = "/index.html"
    error_caching_min_ttl = 10
  }, 
  {
    error_code = 403
    response_code = 200
    response_page_path = "/index.html"
    error_caching_min_ttl = 10
  }]
}