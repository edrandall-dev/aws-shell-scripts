#!/bin/bash

THIS_SERVER=$(curl http://169.254.169.254/latest/meta-data/hostname)
LOCAL_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
SECURITY_GROUPS=$(curl http://169.254.169.254/latest/meta-data/security-groups)

yum update -y
yum install httpd php php-mysql -y

cd /var/www/html
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.1.1.tar.gz
chmod -R 755 wp-content
chown -R apache:apache wp-content

wget https://s3.amazonaws.com/bucketforwordpresslab-donotdelete/htaccess.txt
mv htaccess.txt .htaccess

>info.html

echo "<html>" >> info.html
echo "<body>" >> info.html
echo "<h1>Welcome to $THIS_SERVER<h1>" >> info.html
echo "<h2>Local IP: $LOCAL_IP</h2>" >> info.html
echo "<h2>Security Groups: $SECURITY_GROUPS</h2>" >> info.html
echo" <h2>Built on: $(date)</h2>" >> info.html
echo "</body>" >> info.html

chkconfig httpd on
service httpd start

