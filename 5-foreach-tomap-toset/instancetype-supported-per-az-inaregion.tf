# Get List of Availability Zones in a Specific Region
# Region is set in c1-versions.tf in Provider Block
# Datasource-1
data "aws_availability_zones" "my_azones" {
  filter {
    name   = "opt-in-status" #list of if the AZ available to this account
    values = ["opt-in-not-required"] ##https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
  }
}

# Check if that respective Instance Type is supported in that Specific Region in list of availability Zones
# Get the List of Availability Zones in a Particular region where that respective Instance Type is supported
# Datasource-2
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_instance_type_offerings
data "aws_ec2_instance_type_offerings" "my_ins_type" {
  #for_each = toset(data.aws_availability_zones.my_azones.names)
  for_each = toset(["us-east-1a", "us-east-1b"]) #for_each only accepts maps and sets
#https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}