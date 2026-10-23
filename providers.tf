
provider "aws" {
  region = var.mumbai_region
}

provider "aws" {
  alias  = "virginia"
  region = var.virginia_region
}
