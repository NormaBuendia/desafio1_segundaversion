#proveedor
resource "aws-instance" "nginx-server"{
    ami= var.ami
    instant_type = var.instant_type

    tag={
        Name= var.server_name
    }

    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y nginx
                echo " Hola Norma " > /var/www/html/index.nginx-debian.html
                EOF
    key_name = var.key_name  # Reemplaza por el usuario en AWS para que se ejecute terraform

    #configurar grupo de seguridad
    vcp_security_group_ids = [aws_security_group.nginx-sg.id]
}

resource "aws_security_group" "nginx-sg" {
   name = var.security_group_name
   description = "Allow HTTP inboud traffic"

   ingress {
    from_port =80
    to_port = 80
    protocol = "tpc"    
    cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
    from_port = 0
    to_port = 0
    protocol =-1
    cidr_blocks = ["0.0.0.0/0"]
    
   }








}