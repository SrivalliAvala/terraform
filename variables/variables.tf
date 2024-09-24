variable "ami_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
    description = "ami id of instance"
}

variable "instance_type" {
    type = string
    default = "t3.micro"
    description = "type of the instance"
}

variable "from_port" {
    type = number
    default = 22
}

variable "to_port" {
    type = number
    default = 22
}

variable "instance_name" {
    type = string
    default = "terraform"
}

variable "cidr" {
    type = list(string)
    default = [ "0.0.0.0/0" ] 
}

variable "tags" {
    type = map 
    default = {
        Name = "default"
        Project = "expense"
        Component = "backend"
        Environment = "DEV"
        Terraform = "true"
    }
}

variable "Environment" {
    type = string
    default = "prod"
}