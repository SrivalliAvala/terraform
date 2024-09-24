resource "aws_route53_record" "terraform_f_each" {
    for_each = aws_instance.terraform_feach
    zone_id = var.zone_id
    name    = each.key == "frontend" ? var.domain_name : "${each.key}.${var.domain_name}" 
    type    = "A"
    ttl     = 1
    records = each.key == "frontend" ? [each.value.public_ip] : [each.value.private_ip]
    # aws_instance.terraform_feach.public_ip is not needed.....bcz output list key is frontend... 
    allow_overwrite = true
}


