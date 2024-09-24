resource "aws_instance" "expense" {
    # count = 3 or
    count = length(var.instance_names)
    ami                     = data.aws_ami.ami_info.id #u need ami id
    instance_type           = var.instance_names == "mysql" ? "t3.small" : "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_tcp.id]
    # tags = {
    #     Name = var.instance_name
    # }

    # tags = {
    #     name = var.instance_names[count.index]  
    # }

    tags = merge(
        var.common_tags, {
            Name = var.instance_names[count.index] #merges instance_names with tags which are some default details... 
        }
    )
}

resource "aws_security_group" "allow_tcp" {
  name        = "allow_tcp"
  description = "Allow port 22 inbound traffic and all outbound traffic"
  
  ingress {

    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = "tcp"
    cidr_blocks      = var.cidr
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.cidr
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
        var.common_tags, {
            Name = var.sg_name
        }
    )
}