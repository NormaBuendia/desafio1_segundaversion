#variable region donde se va adesplegar la EC2 instance
variable "region" {
    
    type = string
    description = " The AWS region to deploy to "
    default= "us-east-1"
}

#variable ami
variable "ami" {
    type = string
    description = " The AMI to use for the EC2instance"
    default= "ami-03b039a920e4e8966"
}

#variable tipo
variable "instant_type" {
    type = string
    description = "The instance type to use for the  EC2 instance"
    default= "t2.micro"
}

#variable clave de aws para ejecutar terraform
variable "key_name" {
    type = string
    description = "The key pairs name to use for the instance"
    default= "awsnueva"
}

#variable nombre grupo de seguridad
variable "security_group_name" {
    type = string
    description = "The name of the security group"
    default= "nginx-segurity-group"
}

#variable nombre de instancia
variable "server_name"{
    type = string
    description = "The name on EC2 instance"
    default = "nginx_name"
}