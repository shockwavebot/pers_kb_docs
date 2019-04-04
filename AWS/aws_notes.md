# AWS 

## Environment setup

### Installing the AWS CLI 

```
pip install awscli
aws --version
```

### Configuring AWS CLI 

`aws configure`

## Operations 

#### List instances 
`aws ec2 describe-instances --filters "Name=tag:Creator,Values=ts054"`
