# aws-ecr-credential

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/mihmacorp)](https://artifacthub.io/packages/search?repo=mihmacorp)

This Chart seamlessly integrates Kubernetes with AWS ECR using **AWS CLI v2**.

Simply deploy this chart to your kubernetes cluster and you will be able to pull and run images from your AWS ECR (Elastic Container Registry) in your cluster.

This chart automatically refreshes ECR credentials every 8 hours via a CronJob.

# Usage

Run the following command to install this chart

```sh
helm install --name aws-ecr-credential mihmacorp/aws-ecr-credential \
  --set-string aws.account=<aws account nubmer> \
  --set aws.region=<aws region> \
  --set aws.accessKeyId=<base64> \
  --set aws.secretAccessKey=<base64> \
  --set targetNamespace=default
```

That chart will create a secret object names `aws-registry`.

In you kubernetes deployment use `imagePullSecrets: aws-registry`.

Example:
```yaml
apiVersion: apps/v1
kind: Deployment
spec:
  template:
    spec:
      imagePullSecrets:
      - name: aws-registry
      containers:
        - name: node
          image: node:latest
```