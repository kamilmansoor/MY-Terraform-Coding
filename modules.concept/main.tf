#profile details
provider "aws" {
  profile = "485146087273_Auxin-DevOps"
  region  = "us-east-1"
}

module "creating-vpc" {
    source = "./vpc"
    umer = var.kamil
   
}

module "creating-IGW" {
    source = "./internetgateway"
    hello = module.creating-vpc.nikal

}
