
provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

resource "aws_instance" "web" {

  key_name      = "student"   # SSH key name, to access instance
  ami           = "ami-0e8cb4bdc5bb2e6c0"  # Amazon linux AMI
  instance_type = "t2.micro" 
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}" # IAM ROLE, with access to S3, ECR, Cloudformationm
  user_data     = file("init-script.sh") # Script file that initializes jenkins, and imports job backup
  vpc_security_group_ids = [aws_security_group.web-sg.id] # opens 8080 port

  tags = {
    Name        = "TerraCreatedThis" # Name for instance
  }

}