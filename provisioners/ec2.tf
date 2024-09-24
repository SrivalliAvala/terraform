resource "aws_security_group" "allow_ssh" {
    name        = "allow_ssh" 
    description = "Allow port number 22 for SSH access"

    # usually we allow everything in egress
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"  # represents all ports
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    dynamic "ingress" {
        for_each = [80,8080,9090,22]
        iterator = port
        content{
            from_port = port.value
            to_port = port.value
            protocol         = "tcp"
            cidr_blocks      = ["0.0.0.0/0"] #allow from everyone
            ipv6_cidr_blocks = ["::/0"]
    }
  }

    tags = {
        Name = "allow_shh"
    }
}

resource "aws_instance" "provisioners" {

    ami = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    tags = {
        Name = "provisioners"
    }

    provisioner "local-exec" {   #local level
        command = "echo private_ip address is : ${self.private_ip} > private_ip.txt"
    }

    connection {  #remote level
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = self.public_ip
    }

    provisioner "remote-exec" {
        inline = [
            "sudo dnf install ansible -y",
            "sudo dnf install nginx -y",
            "sudo systemctl start nginx"
        ]
    }

    provisioner "remote-exec" {
        when    = destroy
        inline = [
            "sudo systemctl stop nginx",
        ]
    }
}