variable "main_vpc_cidr" {
    type = string
    default = "10.0.0.0/24"
}

variable "tag_name" {
    type = string
    default = "main-TEST-ENV"
}

variable "pub_subnet1a_cidr" {
    type = string
    default = "10.0.0.128/26" 
}

variable "pub_subnet1b_cidr"{
    type = string
    default = "10.0.0.204/26"
}

variable "priv_subnet1a_cidr" {
    type = string
    default = "10.0.0.192/26" 
}


variable "priv_subnet1b_cidr" {
    type = string
    default = "10.0.0.152/26" 
}
