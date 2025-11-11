# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-11-11

### Changed
- **BREAKING**: Updated from AWS CLI v1 to AWS CLI v2
- Updated base container image to `amazon/aws-cli:2.31.32`
- Updated authentication command from `aws ecr get-login` to `aws ecr get-login-password`
- Modernized Chart.yaml to apiVersion v2 for Helm 3 compatibility
- Enhanced values.yaml with comprehensive documentation and examples
- Improved default targetNamespace from `mapstack` to `default`

### Added
- Comprehensive error handling and validation in job scripts
- Detailed validation of AWS credentials before use
- Enhanced logging with credential masking for security
- Artifact Hub metadata annotations in Chart.yaml
- Complete README.md with detailed usage examples and troubleshooting
- Security considerations documentation
- IAM permissions requirements documentation
- .helmignore file for better package management
- This CHANGELOG.md file

### Fixed
- Improved error messages for failed ECR authentication
- Better handling of edge cases in credential refresh process

### Security
- Upgraded to latest AWS CLI with security patches
- Improved credential handling and logging (masked sensitive data)

## [1.5.0] - Previous Release

### Initial Features
- Basic ECR credential management
- CronJob for credential refresh every 8 hours
- Initial job for immediate credential setup
- ServiceAccount patching for imagePullSecrets
- Support for custom target namespaces

---

## Credits

- **Original Author**: [architectminds](https://github.com/architectminds/helm-charts) - Created the initial chart and concept
- **Maintainer (v2.0+)**: Mihma Inc - AWS CLI v2 migration and enhancements

## Migration Guide: v1.x to v2.0

### Breaking Changes
The main breaking change is the underlying AWS CLI version. However, this is **fully transparent** to users:

- No changes required to your values.yaml
- No changes required to your deployment configurations
- The chart upgrade is backward compatible

### Upgrade Process

```bash
# Upgrade to v2.0
helm upgrade aws-ecr-credential mihmacorp/aws-ecr-credential \
  --reuse-values \
  --version 2.0.0
```

### What Changed Under the Hood

1. **Base Image**: Changed from older AWS CLI v1 image to `amazon/aws-cli:2.31.32`
2. **Login Command**: 
   - Old: `$(aws ecr get-login --region ${AWS_REGION} --no-include-email)`
   - New: `aws ecr get-login-password --region ${AWS_REGION}`
3. **Benefits**:
   - Improved performance
   - Better security patches
   - More reliable authentication
   - Simpler command syntax

### Verifying the Upgrade

After upgrading, verify the new version is running:

```bash
# Check the CronJob image
kubectl get cronjob -n kube-system -o jsonpath='{.items[*].spec.jobTemplate.spec.template.spec.containers[0].image}'

# You should see: mihmacorp/aws-kubectl:1.1
```

Monitor the logs to ensure credentials are being refreshed successfully:

```bash
kubectl logs -n kube-system -l app.kubernetes.io/name=aws-ecr-credential --tail=50
```

## Support

For issues or questions:
- **Email**: business@mihma.com
- **GitHub Issues**: https://github.com/mihmacorp/aws-ecr-credential/issues
