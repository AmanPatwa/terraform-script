module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "group3-lambda-tf-2"
  description   = "Lambda function to send email to students and professor"
  handler       = "lambda.lambda_handler"
  runtime       = "python3.8"
  create_layer    = false  # to control creation of the Lambda Layer and related resources
  create_role     = false 
  lambda_role = "arn:aws:iam::488599217855:role/PE-Training-2021"

  source_path = "./lambda.py"

  tags = {
    Name = "group3-lambda-tf-1"
  }

  environment_variables = {
    Password = "Password@123"
  }

  kms_key_arn = "arn:aws:kms:us-east-1:488599217855:key/c982ec23-f1c5-40ca-a440-5c6302f7a998"

}
#resource "aws_s3_bucket" "bucket" {
 # bucket = "group3-tf-bucket"
#}
resource "aws_s3_bucket_notification" "aws-lambda-trigger" {
    bucket = "group3-exam-bucket"
    lambda_function {
        lambda_function_arn = "${module.lambda_function.lambda_function_arn}"
        events              = ["s3:ObjectCreated:*"]
        filter_prefix       = "result/"
        filter_suffix       = ".txt"
    }   
}
resource "aws_lambda_permission" "test" {
    statement_id  = "AllowS3Invoke"
    action        = "lambda:InvokeFunction"
    function_name = "${module.lambda_function.lambda_function_name}"
    principal = "s3.amazonaws.com"
    source_arn = "arn:aws:s3:::group3-exam-bucket"
}