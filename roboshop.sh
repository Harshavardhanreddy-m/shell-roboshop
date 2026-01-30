#!.bin/bash

SG_ID="sg-0d413b79717fa7fc6" # replace with your ID
AMI_ID="ami-0220d79f3f480ecf5"

for instance in $@
do
    Instance_Id=$( aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t3.micro" \
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query 'Instance[0].InstanceId' \
    --output text )

    if [ $instance == "frontend" ]; then
        IP=$(
            aws ec2 describe-instances \
            --instance-ids $Instance_Id \
            --query 'Reservations[].PublicIpAddress' \ 
            --output text
        )
    else
        if [ $instance == "frontend" ]; then
        IP=$(
            aws ec2 describe-instances \
            --instance-ids $Instance_Id\
            --query 'Reservations[].PrivateIpAddress' \ 
            --output text
        )
    fi
     echo "IP Address: $IP"             
done
