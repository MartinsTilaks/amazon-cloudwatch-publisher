#!/usr/bin/env bash
set -e


# Create a user for the script and make sure it's in a group with sudo powers
sudo_groups="sudo wheel"
for sudo_group in $sudo_groups; do
  getent group $sudo_group && break
done
useradd -g $sudo_group -s /sbin/nologin cwpublisher


# Install dependencies
pip3 install -r requirements.txt


# Create folders and copy source and config
mkdir -p /opt/aws/amazon-cloudwatch-publisher/bin/
mkdir -p /opt/aws/amazon-cloudwatch-publisher/etc/
mkdir -p /opt/aws/amazon-cloudwatch-publisher/logs/
cp amazon-cloudwatch-publisher /opt/aws/amazon-cloudwatch-publisher/bin/
cp configs/amazon-cloudwatch-publisher-rpi.json /opt/aws/amazon-cloudwatch-publisher/etc/amazon-cloudwatch-publisher.json
chown -R cwpublisher: /opt/aws/amazon-cloudwatch-publisher
chmod -R u+rwX,g-rwx,o-rwx /opt/aws/amazon-cloudwatch-publisher





# Write the daemon configuration file
cat << EOF > /etc/systemd/system/amazon-cloudwatch-publisher.service
[Unit]
Description=amazon-cloudwatch-publisher
Requires=network.target
After=network.target
[Service]
Type=simple
User=cwpublisher
Group=sudo
ExecStart=/opt/aws/amazon-cloudwatch-publisher/bin/amazon-cloudwatch-publisher
[Install]
WantedBy=multi-user.target
EOF

# Install the publisher as a daemon that runs at boot, and then start it
systemctl enable amazon-cloudwatch-publisher
systemctl start amazon-cloudwatch-publisher
