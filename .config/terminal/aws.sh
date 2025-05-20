#!/bin/bash

function ec2_instance_id_by_name() {
    if [ -z "$AWS_PROFILE" ]; then
        echo "AWS_PROFILE is not set. Please set it to your desired AWS profile."
        exit 1
    fi

    instance_id=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" --query "Reservations[].Instances[].InstanceId" --output text)
    echo $instance_id
}

function ssm_session_by_name() {
    if [ -z "$AWS_PROFILE" ]; then
        echo "AWS_PROFILE is not set. Please set it to your desired AWS profile."
        sleep 2
        exit 1
    fi

    if [ -z "$1" ]; then
        echo "Usage: $0 <instance-name>"
        sleep 2
        exit 1
    fi

    instance_name=$1
    instance_id=$(aws $profile ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" --query "Reservations[].Instances[].InstanceId" --output text)

    if [ -z "$instance_id" ]; then
        echo "No instance found with name: $instance_name"
        sleep 2
        exit 1
    fi

    echo "Starting SSM session for instance with name: $instance_name"
    aws ssm start-session --target $instance_id
}

function instance_connect() {
    if [ -z "$AWS_PROFILE" ]; then
        echo "AWS_PROFILE is not set. Please set it to your desired AWS profile."
        sleep 2
        exit 1
    fi

    if [ -z "$1" ]; then
        echo "Usage: $0 <instance-name>"
        sleep 2
        exit 1
    fi

    instance_name=$1
    instance_id=$(aws $profile ec2 describe-instances --filters "Name=tag:Name,Values=$instance_name" --query "Reservations[].Instances[].InstanceId" --output text)

    echo "Starting EC2 Instance Connect for instance with id: $instance_id"
    if [ -z "$instance_id" ]; then
        echo "No instance found with name: $instance_name"
        sleep 2
        exit 1
    fi

    aws ec2-instance-connect ssh --instance-id $instance_id
}
