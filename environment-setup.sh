#!/bin/bash

/usr/bin/clear

#Source the global-vars.sh script first to pull in variables and functions
. ./global-vars.sh

############################################################################################

label "Creating VPC and Internet Gateway (and attaching)"

VPC_ID=$($AWS ec2 create-vpc \
  --cidr-block $VPC_CIDR \
  --query 'Vpc.{VpcId:VpcId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --resources $VPC_ID \
  --tags "Key=Name,Value=$VPC_NAME" \
  --region $AWS_REGION

echo -e "[ VPC ]"
echo -e "ID\t\t$VPC_ID"
echo -e "REGION\t\t$AWS_REGION"
echo -e "CIDR\t\t$VPC_CIDR"
echo -e "NAME TAG\t$VPC_NAME"
echo

IGW_ID=$($AWS ec2 create-internet-gateway \
  --query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $IGW_ID \
  --tags "Key=Name,Value=$IGW_NAME"

$AWS ec2 attach-internet-gateway \
  --vpc-id $VPC_ID \
  --internet-gateway-id $IGW_ID \
  --region $AWS_REGION

echo -e "[ IGW ]"
echo -e "ID\t\t$IGW_ID"
echo -e "VPC\t\t$VPC_NAME ($VPC_ID)"
echo -e "NAME TAG\t$IGW_NAME"

############################################################################################

label "Creating Subnets Web-A, Web-B, DB-A and DB-B"

SUBNET_1_ID=$($AWS ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_1_CIDR \
  --availability-zone $SUBNET_1_AZ \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $SUBNET_1_ID \
  --tags "Key=Name,Value=$SUBNET_1_NAME"

echo -e "[ SUBNET 1 ]"
echo -e "ID\t\t$SUBNET_1_ID"
echo -e "AZ\t\t$SUBNET_1_AZ"
echo -e "CIDR\t\t$SUBNET_1_CIDR"
echo -e "NAME TAG\t$SUBNET_1_NAME"
echo

SUBNET_2_ID=$($AWS ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_2_CIDR \
  --availability-zone $SUBNET_2_AZ \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $SUBNET_2_ID \
  --tags "Key=Name,Value=$SUBNET_2_NAME"

echo -e "[ SUBNET 2 ]"
echo -e "ID\t\t$SUBNET_2_ID"
echo -e "AZ\t\t$SUBNET_2_AZ"
echo -e "CIDR\t\t$SUBNET_2_CIDR"
echo -e "NAME TAG\t$SUBNET_2_NAME"
echo

SUBNET_3_ID=$($AWS ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_3_CIDR \
  --availability-zone $SUBNET_3_AZ \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $SUBNET_3_ID \
  --tags "Key=Name,Value=$SUBNET_3_NAME"

echo -e "[ SUBNET 3 ]"
echo -e "ID\t\t$SUBNET_3_ID"
echo -e "AZ\t\t$SUBNET_3_AZ"
echo -e "CIDR\t\t$SUBNET_3_CIDR"
echo -e "NAME TAG\t$SUBNET_3_NAME"
echo

SUBNET_4_ID=$($AWS ec2 create-subnet \
  --vpc-id $VPC_ID \
  --cidr-block $SUBNET_4_CIDR \
  --availability-zone $SUBNET_4_AZ \
  --query 'Subnet.{SubnetId:SubnetId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $SUBNET_4_ID \
  --tags "Key=Name,Value=$SUBNET_4_NAME"

echo -e "[ SUBNET 4 ]"
echo -e "ID\t\t$SUBNET_4_ID"
echo -e "AZ\t\t$SUBNET_4_AZ"
echo -e "CIDR\t\t$SUBNET_4_CIDR"
echo -e "NAME TAG\t$SUBNET_4_NAME"


############################################################################################

label "Creating Routing Tables and corresponding subnet associations"

SUBNET_1_ROUTE_TABLE_ID=$($AWS ec2 create-route-table \
  --vpc-id $VPC_ID \
  --query 'RouteTable.{RouteTableId:RouteTableId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $SUBNET_1_ROUTE_TABLE_ID \
  --tags "Key=Name,Value=$SUBNET_1_ROUTE_TABLE_NAME"

RESULT=$($AWS ec2 associate-route-table  \
  --subnet-id $SUBNET_1_ID \
  --route-table-id $SUBNET_1_ROUTE_TABLE_ID \
  --region $AWS_REGION)

echo -e "[ Route Table and Subnet Association ]"
echo -e "ID\t\t$SUBNET_1_ROUTE_TABLE_ID"
echo -e "VPC\t\t$VPC_NAME ($VPC_ID)"
echo -e "NAME TAG\t$SUBNET_1_ROUTE_TABLE_NAME"
echo

SUBNET_2_ROUTE_TABLE_ID=$($AWS ec2 create-route-table \
  --vpc-id $VPC_ID \
  --query 'RouteTable.{RouteTableId:RouteTableId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $SUBNET_2_ROUTE_TABLE_ID \
  --tags "Key=Name,Value=$SUBNET_2_ROUTE_TABLE_NAME"

RESULT=$($AWS ec2 associate-route-table  \
  --subnet-id $SUBNET_2_ID \
  --route-table-id $SUBNET_2_ROUTE_TABLE_ID \
  --region $AWS_REGION)

echo -e "[ Route Table and Subnet Association ]"
echo -e "ID\t\t$SUBNET_2_ROUTE_TABLE_ID"
echo -e "VPC\t\t$VPC_NAME ($VPC_ID)"
echo -e "NAME TAG\t$SUBNET_2_ROUTE_TABLE_NAME"
echo

SUBNET_3_ROUTE_TABLE_ID=$($AWS ec2 create-route-table \
  --vpc-id $VPC_ID \
  --query 'RouteTable.{RouteTableId:RouteTableId}' \
  --output text \
  --region $AWS_REGION)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $SUBNET_3_ROUTE_TABLE_ID \
  --tags "Key=Name,Value=$SUBNET_3_ROUTE_TABLE_NAME"

RESULT=$($AWS ec2 associate-route-table  \
  --subnet-id $SUBNET_3_ID \
  --route-table-id $SUBNET_3_ROUTE_TABLE_ID \
  --region $AWS_REGION)

echo -e "[ Route Table and Subnet Association ]"
echo -e "ID\t\t$SUBNET_3_ROUTE_TABLE_ID"
echo -e "VPC\t\t$VPC_NAME ($VPC_ID)"
echo -e "NAME TAG\t$SUBNET_3_ROUTE_TABLE_NAME"

############################################################################################

label "Creating default routes for Web Subnets and enabling Public IP Auto-Assign"

# Create default route to Internet Gateway
RESULT=$($AWS ec2 create-route \
  --route-table-id $SUBNET_1_ROUTE_TABLE_ID \
  --destination-cidr-block $DEF_ROUTE \
  --gateway-id $IGW_ID \
  --region $AWS_REGION)

aws ec2 modify-subnet-attribute \
  --subnet-id $SUBNET_1_ID \
  --map-public-ip-on-launch \
  --region $AWS_REGION

echo -e "[ Default Route & Auto-Assign Public IP ]"
echo -e "ID\t\t$SUBNET_1_ID"
echo -e "SUBNET NAME\t$SUBNET_1_NAME"
echo -e "DEFAULT ROUTE\t$DEF_ROUTE"
echo

# Create default route to Internet Gateway
RESULT=$($AWS ec2 create-route \
  --route-table-id $SUBNET_2_ROUTE_TABLE_ID \
  --destination-cidr-block $DEF_ROUTE \
  --gateway-id $IGW_ID \
  --region $AWS_REGION)

aws ec2 modify-subnet-attribute \
  --subnet-id $SUBNET_2_ID \
  --map-public-ip-on-launch \
  --region $AWS_REGION

echo -e "[ Default Route & Auto-Assign Public IP ]"
echo -e "ID\t\t$SUBNET_2_ID"
echo -e "SUBNET NAME\t$SUBNET_2_NAME"
echo -e "DEFAULT ROUTE\t$DEF_ROUTE"

############################################################################################

############################################################################################

label "Creating Elastic IP and NAT Gateway"

EIP_ALLOC_ID=$($AWS ec2 allocate-address \
  --domain vpc \
  --query '{AllocationId:AllocationId}' \
  --output text \
  --region $AWS_REGION)

EIP=$($AWS ec2 describe-addresses \
  --allocation-ids $EIP_ALLOC_ID \
  --output text \
  --region eu-west-1)

echo -e "[ Elastic IP for NAT Gateway ]"
echo -e "ID\t\t$EIP_ALLOC_ID"
echo -ne "IP\t\t"
echo -e "$EIP" | awk {'print $4'}
echo

# Create NAT Gateway
NGW_ID=$($AWS ec2 create-nat-gateway \
  --subnet-id $SUBNET_2_ID \
  --allocation-id $EIP_ALLOC_ID \
  --query 'NatGateway.{NatGatewayId:NatGatewayId}' \
  --output text \
  --region $AWS_REGION)

echo -e "[ Creating NAT Gateway ]"
echo -e "ID\t\t$NGW_ID"

FORMATTED_MSG="STATUS\t\t%s - %02dh:%02dm:%02ds elapsed while waiting for NAT gateway."

SECONDS=0
LAST_CHECK=0
STATE='PENDING'

until [[ $STATE == 'AVAILABLE' ]]; do
  INTERVAL=$SECONDS-$LAST_CHECK
  if [[ $INTERVAL -ge $CHECK_FREQUENCY ]]; then
    STATE=$($AWS ec2 describe-nat-gateways \
      --nat-gateway-ids $NGW_ID \
      --query 'NatGateways[*].{State:State}' \
      --output text \
      --region $AWS_REGION)
    STATE=$(echo $STATE | tr '[:lower:]' '[:upper:]')
    LAST_CHECK=$SECONDS
  fi
  SECS=$SECONDS
  STATUS_MSG=$(printf "$FORMATTED_MSG" \
    $STATE $(($SECS/3600)) $(($SECS%3600/60)) $(($SECS%60)))
  printf "$STATUS_MSG\033[0K\r"
  sleep 1
done

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $NGW_ID \
  --tags "Key=Name,Value=$NGW_NAME"
echo -e "Name\t\t$NGW_NAME"
echo

#Create default route to NAT Gateway
RESULT=$($AWS ec2 create-route \
  --route-table-id $SUBNET_3_ROUTE_TABLE_ID \
  --destination-cidr-block $DEF_ROUTE \
  --gateway-id $NGW_ID \
  --region $AWS_REGION)

echo -e "[ Default Route for NAT GW ]"
echo -e "ID\t\t$SUBNET_3_ID"
echo -e "SUBNET NAME\t$SUBNET_3_NAME"#
echo -e "DEFAULT ROUTE\t$DEF_ROUTE"


############################################################################################

label "Creating Security Groups"

SG_0_NAME="Load Balancers - $(echo $VPC_NAME | sed 's/|/-/'g)"
SG_1_NAME="Web Servers - $(echo $VPC_NAME | sed 's/|/-/'g)"
SG_2_NAME="DB Servers - $(echo $VPC_NAME | sed 's/|/-/'g)"

CLB_SG=$($AWS ec2 create-security-group \
  --group-name "$SG_0_NAME" \
  --description "$SG_0_NAME" \
  --vpc-id $VPC_ID \
  --region $AWS_REGION \
  --output text)

$AWS ec2 authorize-security-group-ingress \
  --group-id $CLB_SG \
  --protocol tcp \
  --port 80 \
  --cidr 0.0.0.0/0 \
  --region $AWS_REGION

echo -e "[ Load Balancer Security Group ] "
echo -e "ID\t\t$CLB_SG"
echo -e "NAME\t\t$SG_0_NAME"
echo -e "RULE1\t\tAllow 0.0.0./0 :80"
echo -e "RULE1\t\tAllow $TLN :22"
echo -e "RULE1\t\tAllow $VPN_LON3 :22"
echo

WEB_SG=$($AWS ec2 create-security-group \
  --group-name "$SG_1_NAME" \
  --description "$SG_1_NAME" \
  --vpc-id $VPC_ID \
  --region $AWS_REGION \
  --output text)

$AWS ec2 authorize-security-group-ingress \
  --group-id $WEB_SG \
  --protocol tcp \
  --port 80 \
  --source-group $CLB_SG \
  --region $AWS_REGION

$AWS ec2 authorize-security-group-ingress \
  --group-id $WEB_SG \
  --protocol tcp \
  --port 22 \
  --cidr $TLN \
  --region $AWS_REGION

$AWS ec2 authorize-security-group-ingress \
  --group-id $WEB_SG \
  --protocol tcp \
  --port 22 \
  --cidr $CBAST1 \
  --region $AWS_REGION

echo -e "[ Web Server Security Group ] "
echo -e "ID\t\t$WEB_SG"
echo -e "NAME\t\t$SG_1_NAME"
echo -e "RULE1\t\tAllow $SG_0_NAME :80"
echo -e "RULE2\t\tAllow $TLN :22"
echo -e "RULE3\t\tAllow $VPN_LON3 :22"
echo

DB_SG=$($AWS ec2 create-security-group \
  --group-name "$SG_2_NAME" \
  --description "$SG_2_NAME" \
  --vpc-id $VPC_ID \
  --region $AWS_REGION \
  --output text)

$AWS ec2 authorize-security-group-ingress \
  --group-id $DB_SG \
  --protocol tcp \
  --port 22 \
  --source-group $WEB_SG \
  --region $AWS_REGION

$AWS ec2 authorize-security-group-ingress \
  --group-id $DB_SG \
  --protocol tcp \
  --port 3306 \
  --source-group $WEB_SG \
  --region $AWS_REGION

echo -e "[ DB Server Security Group ] "
echo -e "ID\t\tDB_SG"
echo -e "NAME\t\t$SG_2_NAME"
echo -e "RULE1\t\tAllow $SG_1_NAME :22"
echo -e "RULE2\t\tAllow $SG_1_NAME :3306"

############################################################################################

label "Creating Web Server Instances"

WEBSERVER_1_NAME="Web Server 1 - Scripted"
WEBSERVER_1=$($AWS ec2 run-instances \
  --image-id $WEB_AMI \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name eu-west-1 \
  --security-group-ids $WEB_SG \
  --subnet-id $SUBNET_1_ID \
  --region $AWS_REGION \
  --query 'Instances[*].InstanceId' \
  --output text)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $WEBSERVER_1 \
  --tags Key=Name,Value="$WEBSERVER_1_NAME"

echo -e "[ First Webserver Instance ]"
echo -e "ID\t\t$WEBSERVER_1"
echo -e "NAME TAG\t$WEBSERVER_1_NAME"
echo -e "SUBNET ID\t$SUBNET_1_ID"
echo -e "SUBNET NAME\t$SUBNET_1_NAME"
echo -e "SG\t\t$WEB_SG"
echo -e "AMI\t\t$WEB_AMI"
echo -e "TYPE\t\t$INSTANCE_TYPE"
echo

WEBSERVER_2_NAME="Web Server 2 - Scripted"
WEBSERVER_2=$($AWS ec2 run-instances \
  --image-id $WEB_AMI \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name eu-west-1 \
  --security-group-ids $WEB_SG \
  --subnet-id $SUBNET_2_ID \
  --region $AWS_REGION \
  --query 'Instances[*].InstanceId' \
  --output text)

$AWS ec2 create-tags \
  --region $AWS_REGION \
  --resources $WEBSERVER_2 \
  --tags Key=Name,Value="$WEBSERVER_2_NAME"

echo -e "[ Second Webserver Instance ]"
echo -e "ID\t\t$WEBSERVER_2"
echo -e "SUBNET ID\t$SUBNET_2_ID"
echo -e "NAME TAG\t$WEBSERVER_2_NAME"
echo -e "SUBNET NAME\t$SUBNET_2_NAME"
echo -e "SG\t\t$WEB_SG"
echo -e "AMI\t\t$WEB_AMI"
echo -e "TYPE\t\t$INSTANCE_TYPE"

############################################################################################

label "Create Classic Load Balancer and register web servers"

CLB_FQDN=$($AWS elb create-load-balancer \
  --load-balancer-name $CLB_NAME \
  --listeners "Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80" \
  --region eu-west-1 \
  --security-groups $CLB_SG \
  --subnets $SUBNET_1_ID $SUBNET_2_ID \
  --output text)

RESULT=$($AWS elb modify-load-balancer-attributes \
  --load-balancer-name $CLB_NAME \
  --load-balancer-attributes "{\"CrossZoneLoadBalancing\":{\"Enabled\":true}}" \
  --region $AWS_REGION)

RESULT=$($AWS elb configure-health-check \
  --load-balancer-name $CLB_NAME \
  --health-check Target=HTTP:80/index.php,Interval=30,UnhealthyThreshold=2,HealthyThreshold=2,Timeout=3 \
  --region $AWS_REGION)

RESULT=$($AWS elb register-instances-with-load-balancer \
  --load-balancer-name $CLB_NAME \
  --instances $WEBSERVER_1 $WEBSERVER_2 \
  --region eu-west-1)

echo -e "[ Load Balancer ]"
echo -e "FQDN\t\t$CLB_FQDN"
echo -e "INSTANCE1\t$WEBSERVER_1"
echo -e "INSTANCE2\t$WEBSERVER_2"


############################################################################################

label "Creating DB Subnet Group & MySQL RDS Instance"

RESULT=$($AWS rds create-db-subnet-group \
  --db-subnet-group-name dbsng-$AWS_REGION \
  --db-subnet-group-description "Database Subnet Group in $AWS_REGION" \
  --subnet-ids $SUBNET_3_ID $SUBNET_4_ID \
  --region=$AWS_REGION)

RESULT=$($AWS rds create-db-instance \
  --engine mysql \
  --db-name scripted_db \
  --db-instance-identifier scripted-db \
  --allocated-storage 20 \
  --db-instance-class db.t2.micro \
  --master-username user1 \
  --master-user-password secret99 \
  --vpc-security-group-ids $DB_SG \
  --availability-zone $SUBNET_3_AZ \
  --region $AWS_REGION \
  --no-publicly-accessible \
  --backup-retention-period 0 \
  --db-subnet-group-name dbsng-$AWS_REGION)


FORMATTED_MSG="STATUS\t\t%s - %02dh:%02dm:%02ds elapsed while waiting for Database."

SECONDS=0
LAST_CHECK=0
STATE='PENDING'

until [[ $STATE == 'AVAILABLE' ]]; do
  INTERVAL=$SECONDS-$LAST_CHECK
  if [[ $INTERVAL -ge $CHECK_FREQUENCY ]]; then
      STATE=$($AWS rds describe-db-instances \
       --region $AWS_REGION \
       --query 'DBInstances[*].DBInstanceStatus' \
       --output text)
    STATE=$(echo $STATE | tr '[:lower:]' '[:upper:]')
    LAST_CHECK=$SECONDS
  fi
  SECS=$SECONDS
  STATUS_MSG=$(printf "$FORMATTED_MSG" \
    $STATE $(($SECS/3600)) $(($SECS%3600/60)) $(($SECS%60)))
  printf "$STATUS_MSG\033[0K\r"
  sleep 1
done


echo -e "[ Database ]"
echo -e "STATUS\t\t READY"