//resource "aws_route53_record" "devops-domain-record" {
//  name = "nina-codes.it"
//  zone_id = "Z361UGF21STUR6"
//  type = "A"
//
//  alias {
//    name                   = aws_alb.devops-alb.dns_name
//    zone_id                = aws_alb.devops-alb.zone_id
//    evaluate_target_health = true
//  }
//}
//
//resource "aws_route53_record" "jenkins-domain-record" {
//  name = "jenkins.nina-codes.it"
//  zone_id = "Z361UGF21STUR6"
//  type = "A"
//
//  alias {
//    name                   = aws_alb.devops-alb.dns_name
//    zone_id                = aws_alb.devops-alb.zone_id
//    evaluate_target_health = true
//  }
//}
//
//resource "aws_route53_record" "artifactory-domain-record" {
//  name = "artifactory.nina-codes.it"
//  zone_id = "Z361UGF21STUR6"
//  type = "A"
//
//  alias {
//    name                   = aws_alb.devops-alb.dns_name
//    zone_id                = aws_alb.devops-alb.zone_id
//    evaluate_target_health = true
//  }
//}
