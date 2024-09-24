variable "instances" {
    type = map
}

variable "zone_id" {
  type = string
  default = "Z075800523JQAT1TRA35I"
}

variable "domain_name" {
  type = string
  default = "dev-ops81s.online"
}

variable "ami_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
    description = "ami id of instance"
}

variable "tags" {
    type = map
}

variable "common_tags" {
    default = {
        project = "multiple-env"
        terraform = "true"

    }
}

variable "environment" {
  
}