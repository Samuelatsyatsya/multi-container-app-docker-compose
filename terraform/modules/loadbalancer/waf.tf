resource "aws_wafv2_ip_set" "manual_block" {
  count = var.enable_waf && length(var.blocked_ips) > 0 ? 1 : 0

  name               = "${var.project_name}-manual-block-${var.environment}"
  description        = "Manually blocked IPs"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.blocked_ips

  tags = {
    Name = "${var.project_name}-manual-block"
  }
}

resource "aws_wafv2_web_acl" "alb" {
  count = var.enable_waf ? 1 : 0

  name        = "${var.project_name}-waf-${var.environment}"
  description = "WAF for ${var.project_name}"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = length(aws_wafv2_ip_set.manual_block) > 0 ? [1] : []
    content {
      name     = "ManualIPBlock"
      priority = 0

      action {
        block {}
      }

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.manual_block[0].arn
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = var.waf_cloudwatch_metrics_enabled
        metric_name                = "ManualIPBlock"
        sampled_requests_enabled   = var.waf_sampled_requests_enabled
      }
    }
  }

  rule {
    name     = "RateLimit"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = var.waf_rate_limit
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = var.waf_cloudwatch_metrics_enabled
      metric_name                = "RateLimit"
      sampled_requests_enabled   = var.waf_sampled_requests_enabled
    }
  }

  dynamic "rule" {
    for_each = var.enable_sqli_protection ? [1] : []
    content {
      name     = "SQLInjection"
      priority = 2

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = "AWSManagedRulesSQLiRuleSet"
          vendor_name = "AWS"
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = var.waf_cloudwatch_metrics_enabled
        metric_name                = "SQLInjection"
        sampled_requests_enabled   = var.waf_sampled_requests_enabled
      }
    }
  }

  dynamic "rule" {
    for_each = var.enable_common_attacks_protection ? [1] : []
    content {
      name     = "CommonAttacks"
      priority = 3

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = "AWSManagedRulesCommonRuleSet"
          vendor_name = "AWS"
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = var.waf_cloudwatch_metrics_enabled
        metric_name                = "CommonAttacks"
        sampled_requests_enabled   = var.waf_sampled_requests_enabled
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = var.waf_cloudwatch_metrics_enabled
    metric_name                = "${var.project_name}-waf"
    sampled_requests_enabled   = var.waf_sampled_requests_enabled
  }

  tags = {
    Name        = "${var.project_name}-waf-${var.environment}"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_wafv2_web_acl_association" "alb" {
  count = var.enable_waf ? 1 : 0

  resource_arn = aws_lb.app.arn
  web_acl_arn  = aws_wafv2_web_acl.alb[0].arn
}
