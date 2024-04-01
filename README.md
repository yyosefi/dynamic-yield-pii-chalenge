# Personally Identifiable Information (PII) Detector

The _Data Direct_ service enables the sharing of Comma Separated Value (CSV) files. The objective of this assignment is to enhance the service by implementing a sanitization pipeline that removes PII.

## Objective

Implement a sanitization process that blocks files with [Email addresses]

## Prerequisites

- Docker runtime environment (E.g. [Rancher Desktop], [Docker Desktop], etc.)
- [Docker Compose] version 2

## Instructions

You are provided with two S3 buckets: `input` and `output`. The `input` bucket stores uploaded files, while the `output` bucket is for sanitized files (objects).
The sanitization pipeline should scan each object in the `input` bucket. If an Email address is detected, the object should be moved to the `blocked` prefix within the `input` bucket. Otherwise, if no PII is detected, the object should be moved to the `output` bucket.

## Clarification

1. Each uploaded file is not larger than 64MB
2. Use `src` directory for the implementation
3. Push your implementation to `my-solution` Git branch and open a pull-request (PR) on GitHub
4. All [status checks] must pass before submitting the assignment
5. You may add your own [workflows] but do not modify existing steps
6. Do not modify the `tests` directory
7. We leverage Localstack, see [Localstack AWS services supportability] for more information
8. Add your solution notes and instructions to this README

## Development Environment

You can use your local workstation for development. Yet, we provide a cloud development environment and you can create your codespace using either:

- [Web browser](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace-for-a-repository#creating-a-codespace-for-a-repository)
- [GitHub CLI](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace-for-a-repository?tool=cli)
- [VSCode](https://code.visualstudio.com/docs/devcontainers/containers)

## Confidentiality and Non-Disclosure Agreement (NDA)

By accepting this assignment, you understand, acknowledge and agree that you will not, including but not limited to — publicly expose, share and/or copy.

## Contributing

1. Install pre-commit `pre-commit install`
2. Use [Conventional Commits] in your commit messages

## Solution

TBD

<!-- References -->

[Email addresses]: https://en.wikipedia.org/wiki/Email_address#Syntax
[Rancher Desktop]: https://github.com/rancher-sandbox/rancher-desktop
[Docker Desktop]: https://www.docker.com/products/docker-desktop
[Docker Compose]: https://docs.docker.com/compose/install/#installation-scenarios
[status checks]: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/about-status-checks
[workflows]: https://docs.github.com/en/actions/using-workflows/about-workflows
[Localstack AWS services supportability]: https://docs.localstack.cloud/user-guide/aws/feature-coverage/
[conventional commits]: https://www.conventionalcommits.org/en/v1.0.0/
