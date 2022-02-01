variable "ct_home_region" {
  description = "This MUST be the same region as Control Tower is deployed."
  type        = string
  validation {
    condition     = can(regex("(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-\\d", var.ct_home_region))
    error_message = "Variable var: region is not valid."
  }
}

variable "create_vpc" {
  description = "Flag to enable / disable VPC module"
  default     = "false"
  type        = string
  validation {
    condition     = can(regex("(true|false", var.create_vpc))
    error_message = "Variable create_vpc: select true or false."
  }
}

variable "c9_instance_profile" {
  description = "Name of the IAM instance profile for Cloud9"
  type        = string
  default     = "cloud9-aft-profile"
}

variable "c9_instance_name" {
  description = "Name of the Cloud9 environment"
  type        = string
  default     = "cloud9-aft"
}