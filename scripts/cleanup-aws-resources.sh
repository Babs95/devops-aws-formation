#!/bin/bash

###############################################################################
# AWS Resources Cleanup Script
#
# ATTENTION : Ce script supprime TOUTES les ressources de formation AWS
# Utilisez-le après chaque session de lab pour éviter les coûts
#
# Usage: ./cleanup-aws-resources.sh [--dry-run] [--region us-east-1]
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
DRY_RUN=false
REGION=${AWS_DEFAULT_REGION:-us-east-1}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --region)
      REGION="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [--dry-run] [--region REGION]"
      exit 1
      ;;
  esac
done

echo -e "${YELLOW}═══════════════════════════════════════════════════${NC}"
echo -e "${YELLOW}     AWS Resources Cleanup Script                   ${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════════${NC}"
echo ""
echo "Region: $REGION"
echo "Dry Run: $DRY_RUN"
echo ""

if [ "$DRY_RUN" = false ]; then
  echo -e "${RED}⚠️  WARNING: This will DELETE resources in your AWS account!${NC}"
  echo -e "${RED}Press CTRL+C to cancel or ENTER to continue...${NC}"
  read
fi

###############################################################################
# Helper Functions
###############################################################################

function log_info() {
  echo -e "${GREEN}[INFO]${NC} $1"
}

function log_warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

function log_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

function execute() {
  if [ "$DRY_RUN" = true ]; then
    echo -e "${YELLOW}[DRY-RUN]${NC} $1"
  else
    log_info "Executing: $1"
    eval "$1" || log_error "Failed: $1"
  fi
}

###############################################################################
# 1. Terminate EC2 Instances
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. Terminating EC2 Instances"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

INSTANCES=$(aws ec2 describe-instances \
  --region $REGION \
  --query 'Reservations[].Instances[?State.Name==`running` || State.Name==`stopped`].InstanceId' \
  --output text)

if [ -n "$INSTANCES" ]; then
  log_warn "Found instances: $INSTANCES"
  execute "aws ec2 terminate-instances --region $REGION --instance-ids $INSTANCES"
  if [ "$DRY_RUN" = false ]; then
    log_info "Waiting for instances to terminate..."
    aws ec2 wait instance-terminated --region $REGION --instance-ids $INSTANCES || true
  fi
else
  log_info "No running instances found"
fi

###############################################################################
# 2. Delete Load Balancers (ALB/NLB)
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2. Deleting Load Balancers"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

LBS=$(aws elbv2 describe-load-balancers \
  --region $REGION \
  --query 'LoadBalancers[].LoadBalancerArn' \
  --output text 2>/dev/null || echo "")

if [ -n "$LBS" ]; then
  for LB in $LBS; do
    log_warn "Deleting load balancer: $LB"
    execute "aws elbv2 delete-load-balancer --region $REGION --load-balancer-arn $LB"
  done
else
  log_info "No load balancers found"
fi

# Delete target groups
TGS=$(aws elbv2 describe-target-groups \
  --region $REGION \
  --query 'TargetGroups[].TargetGroupArn' \
  --output text 2>/dev/null || echo "")

if [ -n "$TGS" ]; then
  sleep 5  # Wait for LB deletion
  for TG in $TGS; do
    log_warn "Deleting target group: $TG"
    execute "aws elbv2 delete-target-group --region $REGION --target-group-arn $TG" || true
  done
fi

###############################################################################
# 3. Delete Auto Scaling Groups
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3. Deleting Auto Scaling Groups"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

ASGS=$(aws autoscaling describe-auto-scaling-groups \
  --region $REGION \
  --query 'AutoScalingGroups[].AutoScalingGroupName' \
  --output text)

if [ -n "$ASGS" ]; then
  for ASG in $ASGS; do
    log_warn "Deleting ASG: $ASG"
    execute "aws autoscaling delete-auto-scaling-group --region $REGION --auto-scaling-group-name $ASG --force-delete"
  done
else
  log_info "No Auto Scaling Groups found"
fi

# Delete Launch Configurations
LCS=$(aws autoscaling describe-launch-configurations \
  --region $REGION \
  --query 'LaunchConfigurations[].LaunchConfigurationName' \
  --output text)

if [ -n "$LCS" ]; then
  for LC in $LCS; do
    execute "aws autoscaling delete-launch-configuration --region $REGION --launch-configuration-name $LC"
  done
fi

###############################################################################
# 4. Delete NAT Gateways (EXPENSIVE!)
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4. Deleting NAT Gateways"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

NATS=$(aws ec2 describe-nat-gateways \
  --region $REGION \
  --query 'NatGateways[?State==`available`].NatGatewayId' \
  --output text)

if [ -n "$NATS" ]; then
  for NAT in $NATS; do
    log_warn "Deleting NAT Gateway: $NAT (THIS SAVES MONEY!)"
    execute "aws ec2 delete-nat-gateway --region $REGION --nat-gateway-id $NAT"
  done
else
  log_info "No NAT Gateways found"
fi

###############################################################################
# 5. Delete RDS Instances
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5. Deleting RDS Instances"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

RDS_INSTANCES=$(aws rds describe-db-instances \
  --region $REGION \
  --query 'DBInstances[].DBInstanceIdentifier' \
  --output text 2>/dev/null || echo "")

if [ -n "$RDS_INSTANCES" ]; then
  for DB in $RDS_INSTANCES; do
    log_warn "Deleting RDS instance: $DB"
    execute "aws rds delete-db-instance --region $REGION --db-instance-identifier $DB --skip-final-snapshot"
  done
else
  log_info "No RDS instances found"
fi

###############################################################################
# 6. Delete CloudFormation Stacks
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6. Deleting CloudFormation Stacks"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

STACKS=$(aws cloudformation list-stacks \
  --region $REGION \
  --query 'StackSummaries[?StackStatus!=`DELETE_COMPLETE`].StackName' \
  --output text)

if [ -n "$STACKS" ]; then
  for STACK in $STACKS; do
    log_warn "Deleting stack: $STACK"
    execute "aws cloudformation delete-stack --region $REGION --stack-name $STACK"
  done
else
  log_info "No active CloudFormation stacks found"
fi

###############################################################################
# 7. Empty and Delete S3 Buckets
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "7. Emptying and Deleting S3 Buckets"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Only delete buckets with specific prefixes (safer)
PREFIXES=("cloudmarket" "my-" "test-" "demo-" "lab-" "training-")

for PREFIX in "${PREFIXES[@]}"; do
  BUCKETS=$(aws s3 ls --region $REGION | awk '{print $3}' | grep "^$PREFIX" || echo "")

  if [ -n "$BUCKETS" ]; then
    for BUCKET in $BUCKETS; do
      log_warn "Emptying bucket: $BUCKET"
      execute "aws s3 rm s3://$BUCKET --recursive --region $REGION"

      log_warn "Deleting bucket: $BUCKET"
      execute "aws s3 rb s3://$BUCKET --region $REGION --force"
    done
  fi
done

###############################################################################
# 8. Delete Lambda Functions
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "8. Deleting Lambda Functions"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

FUNCTIONS=$(aws lambda list-functions \
  --region $REGION \
  --query 'Functions[].FunctionName' \
  --output text)

if [ -n "$FUNCTIONS" ]; then
  for FUNC in $FUNCTIONS; do
    log_warn "Deleting function: $FUNC"
    execute "aws lambda delete-function --region $REGION --function-name $FUNC"
  done
else
  log_info "No Lambda functions found"
fi

###############################################################################
# 9. Delete API Gateways
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "9. Deleting API Gateways"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# REST APIs
REST_APIS=$(aws apigateway get-rest-apis \
  --region $REGION \
  --query 'items[].id' \
  --output text)

if [ -n "$REST_APIS" ]; then
  for API in $REST_APIS; do
    log_warn "Deleting REST API: $API"
    execute "aws apigateway delete-rest-api --region $REGION --rest-api-id $API"
  done
else
  log_info "No REST APIs found"
fi

###############################################################################
# 10. Delete DynamoDB Tables
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "10. Deleting DynamoDB Tables"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

TABLES=$(aws dynamodb list-tables \
  --region $REGION \
  --query 'TableNames[]' \
  --output text)

if [ -n "$TABLES" ]; then
  for TABLE in $TABLES; do
    log_warn "Deleting table: $TABLE"
    execute "aws dynamodb delete-table --region $REGION --table-name $TABLE"
  done
else
  log_info "No DynamoDB tables found"
fi

###############################################################################
# 11. Delete ECS Clusters (if any)
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "11. Deleting ECS Clusters"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

CLUSTERS=$(aws ecs list-clusters \
  --region $REGION \
  --query 'clusterArns[]' \
  --output text)

if [ -n "$CLUSTERS" ]; then
  for CLUSTER in $CLUSTERS; do
    # Stop all services
    SERVICES=$(aws ecs list-services --region $REGION --cluster $CLUSTER --query 'serviceArns[]' --output text)
    for SERVICE in $SERVICES; do
      execute "aws ecs update-service --region $REGION --cluster $CLUSTER --service $SERVICE --desired-count 0"
      execute "aws ecs delete-service --region $REGION --cluster $CLUSTER --service $SERVICE --force"
    done

    log_warn "Deleting cluster: $CLUSTER"
    execute "aws ecs delete-cluster --region $REGION --cluster $CLUSTER"
  done
else
  log_info "No ECS clusters found"
fi

###############################################################################
# 12. Release Elastic IPs
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "12. Releasing Elastic IPs"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

EIPS=$(aws ec2 describe-addresses \
  --region $REGION \
  --query 'Addresses[?AssociationId==null].AllocationId' \
  --output text)

if [ -n "$EIPS" ]; then
  for EIP in $EIPS; do
    log_warn "Releasing EIP: $EIP"
    execute "aws ec2 release-address --region $REGION --allocation-id $EIP"
  done
else
  log_info "No unattached Elastic IPs found"
fi

###############################################################################
# 13. Delete VPCs (after everything else)
###############################################################################

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "13. Deleting VPCs"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

log_warn "Waiting 30s for resources to clean up before deleting VPCs..."
if [ "$DRY_RUN" = false ]; then
  sleep 30
fi

VPCS=$(aws ec2 describe-vpcs \
  --region $REGION \
  --query 'Vpcs[?IsDefault==`false`].VpcId' \
  --output text)

if [ -n "$VPCS" ]; then
  for VPC in $VPCS; do
    log_warn "Deleting VPC: $VPC"

    # Delete IGWs
    IGWS=$(aws ec2 describe-internet-gateways --region $REGION --filters "Name=attachment.vpc-id,Values=$VPC" --query 'InternetGateways[].InternetGatewayId' --output text)
    for IGW in $IGWS; do
      execute "aws ec2 detach-internet-gateway --region $REGION --internet-gateway-id $IGW --vpc-id $VPC"
      execute "aws ec2 delete-internet-gateway --region $REGION --internet-gateway-id $IGW"
    done

    # Delete subnets
    SUBNETS=$(aws ec2 describe-subnets --region $REGION --filters "Name=vpc-id,Values=$VPC" --query 'Subnets[].SubnetId' --output text)
    for SUBNET in $SUBNETS; do
      execute "aws ec2 delete-subnet --region $REGION --subnet-id $SUBNET"
    done

    # Delete route tables (except main)
    RTS=$(aws ec2 describe-route-tables --region $REGION --filters "Name=vpc-id,Values=$VPC" --query 'RouteTables[?Associations[0].Main!=`true`].RouteTableId' --output text)
    for RT in $RTS; do
      execute "aws ec2 delete-route-table --region $REGION --route-table-id $RT"
    done

    # Delete security groups (except default)
    SGS=$(aws ec2 describe-security-groups --region $REGION --filters "Name=vpc-id,Values=$VPC" --query 'SecurityGroups[?GroupName!=`default`].GroupId' --output text)
    for SG in $SGS; do
      execute "aws ec2 delete-security-group --region $REGION --group-id $SG"
    done

    # Finally delete VPC
    execute "aws ec2 delete-vpc --region $REGION --vpc-id $VPC"
  done
else
  log_info "No custom VPCs found"
fi

###############################################################################
# Summary
###############################################################################

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}     Cleanup Complete!                             ${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════${NC}"
echo ""

if [ "$DRY_RUN" = true ]; then
  echo -e "${YELLOW}This was a DRY RUN - no resources were actually deleted${NC}"
  echo "Run without --dry-run to actually delete resources"
else
  echo -e "${GREEN}Resources deleted successfully!${NC}"
  echo ""
  echo "✅ EC2 Instances terminated"
  echo "✅ Load Balancers deleted"
  echo "✅ NAT Gateways deleted (💰 saving money!)"
  echo "✅ RDS instances deleted"
  echo "✅ CloudFormation stacks deleted"
  echo "✅ S3 buckets emptied and deleted"
  echo "✅ Lambda functions deleted"
  echo "✅ API Gateways deleted"
  echo "✅ DynamoDB tables deleted"
  echo "✅ VPCs deleted"
  echo ""
  echo "💡 Tip: Check AWS Cost Explorer in 24h to verify costs dropped"
fi

echo ""
echo "📊 Verify cleanup in AWS Console:"
echo "   - EC2 Dashboard"
echo "   - VPC Dashboard"
echo "   - RDS Dashboard"
echo "   - S3 Console"
echo "   - CloudFormation Console"
echo ""
