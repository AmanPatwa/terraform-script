import json
import urllib.parse
import boto3
import sys,os
import smtplib, ssl
import boto3

from base64 import b64decode

ENCRYPTED = os.environ['Password']
# Decrypt code should run once and variables stored outside of the function
# handler so that these are decrypted once per container
DECRYPTED = boto3.client('kms').decrypt(
    CiphertextBlob=b64decode(ENCRYPTED),
    EncryptionContext={'LambdaFunctionName': os.environ['AWS_LAMBDA_FUNCTION_NAME']}
)['Plaintext'].decode('utf-8')


s3 = boto3.client('s3')

def lambda_handler(event, context):
    
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    
    response = s3.get_object(Bucket=bucket, Key=key)
    body = response['Body'].read().decode('utf-8')
    
    body = json.loads(body)
    
    stu_rank = body["stu_rank"]
    prof_email = body["prof_email"]
    exam_name = body["exam_name"]
    prof_email_body=''

    
    smtp_server = "smtp.gmail.com"
    port = 587  # For starttls
    sender_email = "group.9801exam@gmail.com"
    password = DECRYPTED
    prof_email_body = '\nRank list for Exam: '+exam_name+'\n--------------------------------------------\n'
    
    # Create a secure SSL context
    context = ssl.create_default_context()
    
    # Try to log in to server and send email
    try:
        server = smtplib.SMTP(smtp_server,port)
        server.ehlo() # Can be omitted
        server.starttls(context=context) # Secure the connection
        server.ehlo() # Can be omitted
        server.login(sender_email, password)
        
        # TODO: Send email here
        for recipient_email in stu_rank.keys():
            stu_email_body = '\nExam: '+ exam_name + '\nRank : ' + str(stu_rank[recipient_email])
            server.sendmail(sender_email, recipient_email, stu_email_body)
            print(stu_email_body)
            prof_email_body += recipient_email + ': ' + str(stu_rank[recipient_email]) + '\n'
        
        server.sendmail(sender_email, prof_email, prof_email_body)
            
    except Exception as e:
        # Print any error messages to stdout
        print(e)
    finally:
        server.quit()