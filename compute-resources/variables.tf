/**
 * Update necessary values relative to AWS environment
 */ 
variable "region" {
  default = "eu-west-1"
}
variable "ami" {
  default = "ami-03fd334507439f4d1"
}

variable "vpc_id" {
  default = "vpc-08a8b0eca6c148977"
}

variable "security_group_ids" {
  type    = list(string)
  default = ["sg-055fe3d0e2f183113"]
}

variable "subnet_1a" {
  default = "subnet-0471546733fe99577"
}

variable "subnet_1b" {
  default = "subnet-092937f78fbac04e6"
}

variable "subnet_1c" {
  default = "subnet-0e1d07fcde4a24464"
}

variable "key_pair" {
  default = "k8s-cluster"
}