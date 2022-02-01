locals {
  vpc = {
    is_use_aft_vpc        = lower(var.use_aft_vpc) == "true" ? true : false
  }  
}