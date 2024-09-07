variable "region" {
  description = "The AWS region to create resources in."
  default     = "us-west-2"
}

variable "ami" {
  description = "The AMI to use for the instance."
  default     = "ami-0c55b159cbfafe1f0" # Update with a valid AMI ID for your region
}

variable "instance_type" {
  description = "The type of instance to start."
  default     = "t2.micro"
}
