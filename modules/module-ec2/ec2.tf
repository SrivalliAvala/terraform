module "ec2" {
    source = "C:/devops/daws-81s/repos/terraform/terraform-aws-ec2-module"
    # these are variables expected module, not arguments of resource definition
    # You can also create variables or else you can directly use values here
    ami_id = var.ami_something
    instance_type = "t3.medium"
    security_group_ids = ["sg-0372233cbe1615ef2"]
}