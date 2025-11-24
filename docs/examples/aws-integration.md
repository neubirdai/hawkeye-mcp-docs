# AWS Integration Example

Complete guide to integrating Hawkeye with AWS.

## Overview

Connect Hawkeye to AWS to investigate incidents across:
- CloudWatch Logs & Metrics
- EC2 Instances
- RDS Databases
- Lambda Functions
- ECS/EKS Services

## Prerequisites

- AWS account with admin access (for setup)
- AWS CLI installed
- Hawkeye project created

## Step 1: Create IAM Role

### Option A: CloudFormation (Recommended)

Create `hawkeye-role.yaml`:

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'Hawkeye ReadOnly IAM Role'

Parameters:
  ExternalId:
    Type: String
    Description: 'External ID for Hawkeye'
    Default: 'hawkeye-external-id-2024'

Resources:
  HawkeyeRole:
    Type: AWS::IAM::Role
    Properties:
      RoleName: HawkeyeReadOnly
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              AWS: 'arn:aws:iam::HAWKEYE_ACCOUNT_ID:root'
            Action: 'sts:AssumeRole'
            Condition:
              StringEquals:
                'sts:ExternalId': !Ref ExternalId
      ManagedPolicyArns:
        - 'arn:aws:iam::aws:policy/ReadOnlyAccess'
      Description: 'Read-only access for Hawkeye investigation'

Outputs:
  RoleArn:
    Description: 'Role ARN for Hawkeye'
    Value: !GetAtt HawkeyeRole.Arn
    Export:
      Name: HawkeyeRoleArn
```

Deploy:

```bash
aws cloudformation create-stack \
  --stack-name hawkeye-readonly-role \
  --template-body file://hawkeye-role.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameters ParameterKey=ExternalId,ParameterValue=your-external-id

# Wait for completion
aws cloudformation wait stack-create-complete \
  --stack-name hawkeye-readonly-role

# Get Role ARN
aws cloudformation describe-stacks \
  --stack-name hawkeye-readonly-role \
  --query 'Stacks[0].Outputs[0].OutputValue' \
  --output text
```

### Option B: Manual Creation

1. **Create Role:**
   ```bash
   aws iam create-role \
     --role-name HawkeyeReadOnly \
     --assume-role-policy-document file://trust-policy.json
   ```

2. **Trust Policy** (`trust-policy.json`):
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": {
           "AWS": "arn:aws:iam::HAWKEYE_ACCOUNT_ID:root"
         },
         "Action": "sts:AssumeRole",
         "Condition": {
           "StringEquals": {
             "sts:ExternalId": "your-external-id-here"
           }
         }
       }
     ]
   }
   ```

3. **Attach ReadOnly Policy:**
   ```bash
   aws iam attach-role-policy \
     --role-name HawkeyeReadOnly \
     --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess
   ```

## Step 2: Create Connection in Hawkeye

```
User: Create an AWS connection named "Production AWS" with:
- Role ARN: arn:aws:iam::123456789012:role/HawkeyeReadOnly
- External ID: your-external-id-here
- Regions: us-east-1, us-west-2, eu-west-1

Claude: ✓ Created AWS connection "Production AWS"
UUID: conn-aws-12345678
Status: SYNCING
```

## Step 3: Wait for Sync

```
User: Wait for my AWS connection to sync

Claude: ⏳ Syncing AWS resources...
⏳ Progress: 25% (2 min)
⏳ Progress: 50% (4 min)
⏳ Progress: 75% (6 min)
✓ Sync complete! (8 minutes)

Discovered Resources:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Compute:
- 52 EC2 instances
- 15 ECS services
- 12 EKS clusters
- 45 Lambda functions

Databases:
- 8 RDS instances
- 4 DynamoDB tables
- 2 ElastiCache clusters

Networking:
- 25 Load Balancers (ALB/NLB)
- 10 CloudFront distributions
- 30 VPCs

Logs & Metrics:
- 180 CloudWatch log groups
- 600+ CloudWatch metrics
- 45 CloudWatch alarms

Total: 1000+ resources indexed
```

## Step 4: Verify Resources

```
User: Show me available CloudWatch log groups

Claude: Available Log Groups (180):

Production Services:
- /aws/lambda/payment-service
- /aws/lambda/user-service
- /aws/lambda/order-service
- /aws/ecs/api-gateway
- /aws/rds/instance/prod-db/error

Staging Services:
- /aws/lambda/payment-service-staging
- ...

Infrastructure:
- /aws/eks/production/cluster
- /aws/vpc/flowlogs
- ...
```

## Step 5: Add to Project

```
User: Add my AWS connection to the Production project

Claude: ✓ Added "Production AWS" to Production project

Your project can now investigate incidents using:
- CloudWatch logs from 180 log groups
- CloudWatch metrics (600+)
- EC2 instance metrics and logs
- RDS database metrics and logs
- Lambda execution logs and metrics
- ECS/EKS container logs
```

## Example Investigation: EC2 High CPU

```
User: Show me uninvestigated EC2 alerts

Claude: Found 1 uninvestigated EC2 alert:

High CPU - prod-web-server-01
Alert ID: /aws/cloudwatch/alerts/ec2-cpu-20240115
Severity: P1
Instance: i-0123456789abcdef0
Region: us-east-1
```

```
User: Investigate this alert

Claude: ROOT CAUSE:
CPU spike caused by runaway cron job (backup-cleanup.sh)
processing 50,000+ files without rate limiting.

CORRECTIVE ACTIONS:
1. Kill runaway process (AUTO-EXECUTED)
   aws ssm send-command \
     --instance-ids i-0123456789abcdef0 \
     --document-name "AWS-RunShellScript" \
     --parameters 'commands=["pkill -f backup-cleanup.sh"]'

2. Add rate limiting to cron job
   sed -i 's/find \/backups/find \/backups | head -n 1000/' \
     /opt/scripts/backup-cleanup.sh

PREVENTIVE MEASURES:
- Add timeout to all cron jobs
- Implement file count limits
- Add CloudWatch alarm for sustained high CPU
```

## Multi-Region Setup

For organizations with resources across regions:

```
User: Create AWS connection "Global AWS" with:
- Role ARN: arn:aws:iam::123456789012:role/HawkeyeReadOnly
- External ID: hawkeye-global-2024
- Regions: us-east-1, us-west-1, us-west-2, eu-west-1, eu-central-1, ap-southeast-1

Claude: ✓ Created multi-region AWS connection
Regions: 6
Estimated sync time: 15-20 minutes
```

## Advanced: Custom Permissions

For tighter security, create a custom policy instead of ReadOnlyAccess:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:Describe*",
        "cloudwatch:Get*",
        "cloudwatch:List*",
        "logs:Describe*",
        "logs:Get*",
        "logs:FilterLogEvents",
        "ec2:Describe*",
        "rds:Describe*",
        "lambda:List*",
        "lambda:Get*",
        "ecs:Describe*",
        "ecs:List*"
      ],
      "Resource": "*"
    }
  ]
}
```

## Troubleshooting

### Sync Fails

**Check role ARN:**
```bash
aws iam get-role --role-name HawkeyeReadOnly
```

**Verify external ID:**
- Must match exactly
- No extra spaces

**Check regions:**
- Ensure regions are active
- Use standard region names (us-east-1, not USE1)

### Missing Resources

**Verify permissions:**
```bash
aws iam get-role-policy \
  --role-name HawkeyeReadOnly \
  --policy-name ReadOnlyAccess
```

**Check region:**
- Resources only discovered in configured regions
- Add region if missing

## See Also

- [Azure Integration](azure-integration.md)
- [Datadog Integration](datadog-integration.md)
- [Managing Connections](../guides/managing-connections.md)
