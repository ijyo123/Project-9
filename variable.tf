variable "vpc-cidr" {
    default = "10.0.0.0/16"
    description = "vpc-cidr"
    type =string
}

variable "publicsub1-cidr" {
    default = "10.0.0.0/24"
    description = "publicsub1-cidr"
    type =string
}
variable "publicsub2-cidr" {
    default = "10.0.1.0/24"
    description = "publicsub2-cidr"
    type =string
}
variable "privatesub1-cidr" {
    default = "10.0.2.0/24"
    description = "privatesub1-cidr"
    type =string
}
variable "privatesub2-cidr" {
    default = "10.0.3.0/24"
    description = "privatesub2-cidr"
    type =string
}

variable "ami-id" {
    default = "ami-0fc15d50d39e4503c"
    description = "ami-id"
    type =string
}

variable "provider-region" {
    default = "eu-west-2"
    description = "provider-region"
    type =string
}