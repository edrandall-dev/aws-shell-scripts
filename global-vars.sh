#!/bin/bash

AWS=$(which aws 2> /dev/null)
[ -e "$AWS" ] || { echo "Error: Please verify that the AWS CLI is installed on this system." && exit 1; }

$AWS ec2 describe-instances --region eu-west-1 &> /dev/null
[ "$?" == "0" ] || { echo "Error: Check that EC2 instance role with correct permissions is attached." ; exit 1; }

########################################################################

AWS_REGION="eu-west-1"

VPC_CIDR="192.168.0.0/16"
VPC_NAME="VPC1 | $AWS_REGION | $VPC_CIDR"

DEF_ROUTE="0.0.0.0/0"
IGW_NAME="IGW | $VPC_NAME"
NGW_NAME="NGW | $VPC_NAME"

SUBNET_1_CIDR="192.168.1.0/24"
SUBNET_1_AZ="$AWS_REGION"a
SUBNET_1_NAME="$SUBNET_1_CIDR | $SUBNET_1_AZ | WEB-A"
SUBNET_1_ROUTE_TABLE_NAME="$SUBNET_1_NAME"

SUBNET_2_CIDR="192.168.2.0/24"
SUBNET_2_AZ="$AWS_REGION"b
SUBNET_2_NAME="$SUBNET_2_CIDR | $SUBNET_2_AZ | WEB-B"
SUBNET_2_ROUTE_TABLE_NAME="$SUBNET_2_NAME"

SUBNET_3_CIDR="192.168.3.0/24"
SUBNET_3_AZ="$AWS_REGION"c
SUBNET_3_NAME="$SUBNET_3_CIDR | $SUBNET_3_AZ | DB-A"
SUBNET_3_ROUTE_TABLE_NAME="$SUBNET_3_NAME"

SUBNET_4_CIDR="192.168.4.0/24"
SUBNET_4_AZ="$AWS_REGION"a
SUBNET_4_NAME="$SUBNET_4_CIDR | $SUBNET_4_AZ | DB-B"
SUBNET_4_ROUTE_TABLE_NAME="$SUBNET_4_NAME"

TLN="$(dig +short XXXXXX.ddns.net)/32"
CBAST1=XXX.XXX.XXX.XXX/32
VPN_LON3=XXX.XXX.XXX.XXX/32

WEB_AMI="ami-023dc1a9d86039260"

INSTANCE_TYPE="t2.micro"

CLB_NAME="Web-CLB-Scripted"

CHECK_FREQUENCY=5

########################################################################

separator()
{
 echo "|------------------------------------------------------------------------------|";
}

label()
{
 echo
 echo
 separator;
 echo -e "  $1";
 separator;
 echo
}
