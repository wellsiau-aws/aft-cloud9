locals {
  vpc = {
    is_create_new        = lower(var.create_vpc) == "true" ? true : false
  }  
}