
 resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profilins" #Creates IAM role profile
  role = "${aws_iam_role.ec2_role.name}"
}


resource "aws_iam_role" "ec2_role" {
  name = "ec2_skaistuls"
  # Creates IAM role
    assume_role_policy = "${file("ec2-assume.json")}"
    
      inline_policy {
        # Adds permissions
         name = "ec2_policijs"
         policy = "${file("ex2-policy.json")}"

     }


  }
