#!/bin/bash
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo
echo "Running create-instance.sh on "$DATE
echo

# Hard coded values
region="us-east-1"
echo "Region: "$region
instanceType="t2.small"
echo "Instance Type: "$instanceType
profile="default"
echo "Profile: "$profile

#Brown TODO: 
# 1. AMI Retrieval
# You're using sed -n 2p
# to extract the AMI ID from the SSM response. That works, but it's a bit brittle-if the output format changes or the AMI list grows, it might break. Consider using  for precision:
# --query "Parameters[0].Value" --output text

# 2.  Key Pair Selection
# You're grabbing the first key name with:
# grep KeyName | cut -d '"' -f4
# If multiple key pairs exist, this could be unpredictable. You might want to filter by a known tag or name prefix if you're standardizing key usage.

# 3. Security Group Logic
# The SG deletion prompt is great. You could add a check to ensure the SG isn't attached to any other resources before deletion, just to avoid dependency errors.

# 4. JSON Parsong
# Using python -m json.tool | grep works, but it's fragile. If you want bulletproof parsing, consider switching to jq:
# instanceId=$(echo $instanceDetails | jq -r '.Instances[0].InstanceId')
# Same for public IP:
# pubIp=$(aws ec2 describe-instances --instance-id $instanceId --region $region --profile $profile | jq -r '.Reservations[0].Instances[0].PublicIpAddress')

#5. Safety Enhancements
# - Add a set -e at the top to exit on any command failure.
# Consider logging output to a file for auditability:
# exec > >(tee -i create-instance.log)
# exec 2>&1

# Bonus: Modularization
# You could break this into reusable functions like:
# get_vpc_id() { ... }
# get_subnet_id() { ... }
# create_security_group() { ... }
# Then call them in sequence. Makes it easier to test and extend

echo
echo "Looking up account values..."

# get vpcId
vpc=$(aws ec2 describe-vpcs \
--filters "Name=tag:Name,Values='MomPopCafe VPC'" \
--region $region \
--profile $profile | grep VpcId | cut -d '"' -f4 | sed -n 1p)
echo "VPC: "$vpc

# get subnetId
subnetId=$(aws ec2 describe-subnets \
--filters "Name=tag:Name,Values='MomPopCafe Public Subnet 1'" \
--region $region \
--profile $profile \
--query "Subnets[?contains(AvailabilityZone, 'us-east-1a')]" | grep SubnetId | cut -d '"' -f4 | sed -n 1p)
echo "Subnet Id: "$subnetId

# Get keypair name
key=$(aws ec2 describe-key-pairs \
--profile $profile | grep KeyName | cut -d '"' -f4 )
echo "Key: "$key

# Get AMI ID
imageId=$(aws ssm get-parameters \
--names '/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2' \
--profile $profile \
--region $region | grep ami- | cut -d '"' -f4 | sed -n 2p)
echo "AMI ID: "$imageId

#check for existing mompopcafe instance
existingEc2Instance=$(aws ec2 describe-instances \
--region $region \
--profile $profile \
--filters "Name=tag:Name,Values=mompopcafeserver" "Name=instance-state-name,Values=running" \
| grep InstanceId | cut -d '"' -f4)
if [[ "$existingEc2Instance" != "" ]]; then
  echo
  echo "WARNING: Found existing running EC2 instance with instance ID "$existingEc2Instance"."
  echo "This script will not succeed if it already exists. "
  echo "Would you like to delete it? [Y/N]"
  echo ">>"

  validResp=0
  while [ $validResp -eq 0 ];
  do
      read answer
      if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
          echo
          echo "Deleting the existing instance..."
          aws ec2 terminate-instances --instance-ids $existingEc2Instance --region $region --profile $profile
          #wait for confirmation it was terminated
          aws ec2 wait instance-terminated --instance-ids $existingEc2Instance --region $region --profile $profile
          validResp="1"
      elif [[ "$answer" == "N" || "$answer" == "n" ]]; then
          echo "Ok, exiting."
          exit 1
      else
          echo "Please reply with Y or N."
      fi
  done

  sleep 10 #give it 10 seconds before trying to delete the SG this instance used.
fi

#check for existing mompopcafeSG security Group
existingMpSg=$(aws ec2 describe-security-groups \
--region $region \
--query "SecurityGroups[?contains(GroupName, 'mompopcafeSG')]" \
--profile $profile | grep GroupId | cut -d '"' -f4)

if [[ "$existingMpSg" != "" ]]; then
  echo
  echo "WARNING: Found existing security group with name "$existingMpSg"."
  echo "This script will not succeed if it already exists. "
  echo "Would you like to delete it? [Y/N]"
  echo ">>"

  validResp=0
  while [ $validResp -eq 0 ];
  do
      read answer
      if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
          echo
          echo "Deleting the existing security group..."
          aws ec2 delete-security-group --group-id $existingMpSg --region $region --profile $profile
          validResp="1"
      elif [[ "$answer" == "N" || "$answer" == "n" ]]; then
          echo "Ok, exiting."
          exit 1
      else
          echo "Please reply with Y or N."
      fi
  done
  sleep 10 #give it 10 seconds before trying to recreate the SG
fi

# CREATE a security group and capture the name of it
echo
echo "Creating a new security group..."
securityGroup=$(aws ec2 create-security-group --group-name "mompopcafeSG" \
--description "mompopcafeSG" \
--region $region \
--group-name "mompopcafeSG" \
--vpc-id $vpc --profile $profile | grep GroupId | cut -d '"' -f4 )
echo "Security Group: "$securityGroup

# Open ports in the security group
echo
echo "Opening port 22 in the new security group"
aws ec2 authorize-security-group-ingress \
--group-id $securityGroup \
--protocol tcp \
--port 22 \
--cidr 0.0.0.0/0 \
--region $region \
--profile $profile

echo "Opening port 80 in the new security group"
aws ec2 authorize-security-group-ingress \
--group-id $securityGroup \
--protocol tcp \
--port 80 \
--cidr 0.0.0.0/0 \
--region $region \
--profile $profile

echo
echo "Creating an EC2 instance in "$region
instanceDetails=$(aws ec2 run-instances \
--image-id $imageId \
--count 1 \
--instance-type $instanceType \
--region $region \
--subnet-id $subnetId \
--security-group-ids $securityGroup \
--tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=mompopcafeserver}]' \
--associate-public-ip-address \
--profile $profile \
--user-data file://create-lamp-instance-userdata.txt )

#if the create instance command failed, exit this script
if [[ "$?" -ne "0" ]]; then
  exit 1
fi

echo
echo "Instance Details...."
echo $instanceDetails | python -m json.tool

# Extract instanceId
instanceId=$(echo $instanceDetails | python -m json.tool | grep InstanceId | sed -n 1p | cut -d '"' -f4)
echo "instanceId="$instanceId
echo
echo "Waiting for a public IP for the new instance..."
pubIp=""
while [[ "$pubIp" == "" ]]; do
  sleep 10;
  pubIp=$(aws ec2 describe-instances --instance-id $instanceId --region $region --profile $profile | grep PublicIp | sed -n 1p | cut -d '"' -f4)
done

echo
echo "The public IP of your LAMP instance is: "$pubIp
echo
echo "Download the Key Pair from the Qwiklabs page."
echo
echo "Then connect using this command (with .pem or .ppk added to the end of the keypair name):"
echo "ssh -i path-to/"$key" ec2-user@"$pubIp
echo
echo "The website should also become available at"
echo "http://"$pubIp"/mompopcafe/"

echo
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo
echo "Done running create-instance.sh at "$DATE
echo
