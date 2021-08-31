Aws-cloudwatch-publisher is python based code to publish logs and metrics to Amazon cloudwatch. It uses boto3 librarie to comunicate wtih aws. Will run on any device running python 3

1. Create cloudwatch user 
Using AWS Console create IAM User with CloudWatchAgentAdminPolicy & CloudWatchAgentServerPolicy permissions.
1.1.  permissions:
                        'logs:CreateLogGroup',
                        'logs:CreateLogStream',
                        'logs:DescribeLogGroups',
                        'logs:DescribeLogStreams',
                        'logs:PutLogEvents',
1.2. Save credentials (aws_access_key, aws_secret_access_key)
2. Clone this repository localy
3. Edit ./configs/amazon-cloudwatch-publisher-rpi.json file
3.1. Manditory - replace following variables (Can do it in config file manualy or later while running installation bash script - safer option):
    - Region
    - AWS_ACCESS_KEY
    - AWS_SECRET_ACCESS_KEY

3.2. Add/Replace
     - Log file path to necesery logs

4. Run the install-rpi.bash with root permissions
 sudo ./install-rpi.bash

5. To check status 
systemctl status amazon-cloudwatch-publisher


6. If something needs to be changed later: change config file and/or python script in /opt/aws/amazon-cloudwatch-publisher 
6.1. cd /opt/aws/amazon-cloudwatch-publisher (need root permissions to access folder)
6.2. Open/edit config file etc/amazon-cloudwatch-publisher.json with text editor
6.3. Open/edit python script bin/amazon-cloudwatch-publisher
6.4. Restart cloud watch service:
     systemctl restart amazon-cloudwatch-publisher

7.  Amazon-cloudwatch-publisher logs are stored in ./logs folder.
7.1. To enable debug mode, in ./etc/amazon-cloudwatch-publisher.json change "debug": false.

8. Delete cloned files, especially if aws credentials written in config file manually.


