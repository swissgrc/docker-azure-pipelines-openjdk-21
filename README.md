# Docker image for running Java applications in an Azure Pipelines container job

<!-- markdownlint-disable MD013 -->
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/swissgrc/docker-azure-pipelines-openjdk-21/blob/main/LICENSE) [![Build](https://img.shields.io/github/actions/workflow/status/swissgrc/docker-azure-pipelines-openjdk-21/publish.yml?branch=develop&style=flat-square)](https://github.com/swissgrc/docker-azure-pipelines-openjdk-21/actions/workflows/publish.yml) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=swissgrc_docker-azure-pipelines-openjdk-21&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=swissgrc_docker-azure-pipelines-openjdk-21) [![Pulls](https://img.shields.io/docker/pulls/swissgrc/azure-pipelines-openjdk.svg?style=flat-square)](https://hub.docker.com/r/swissgrc/azure-pipelines-openjdk) [![Stars](https://img.shields.io/docker/stars/swissgrc/azure-pipelines-openjdk.svg?style=flat-square)](https://hub.docker.com/r/swissgrc/azure-pipelines-openjdk)
<!-- markdownlint-restore -->

Docker image which provides [Eclipse Temurin OpenJDK] 21 in an [Azure Pipelines container jobs].
The image contains also Docker CLI to access Docker engine on the agent.

## Usage

This image can be used to run Java applications in [Azure Pipelines container jobs].

### Azure Pipelines Container Job

To use the image in an Azure Pipelines Container Job, add one of the following example tasks and use it with the `container` property.

The following example shows the container used for a deployment step which shows .NET version:

```yaml
  - stage: deploy
    jobs:
      - deployment: runJava
        container: swissgrc/azure-pipelines-openjdk:21
        environment: smarthotel-dev
        strategy:
          runOnce:
            deploy:
              steps:
                - bash: |
                    java -version
```

### Tags

| Tag         | Description                                                                                   | Base Image                       | OpenJDK   | Size                                                                                                                                |
|-------------|-----------------------------------------------------------------------------------------------|----------------------------------|-----------|-------------------------------------------------------------------------------------------------------------------------------------|
| latest      | Latest stable release (from `main` branch)                                                    | azure-pipelines-dockercli:25.0.3 | 21.0.2.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/latest?style=flat-square)      |
| 21          | Identical to `latest` tag                                                                     |                                  |           | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/21?style=flat-square)          |
| unstable    | Latest unstable release (from `develop` branch)                                               | azure-pipelines-dockercli:26.1.1 | 21.0.3.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/unstable?style=flat-square)    |
| 21-unstable | Identical to `unstable` tag                                                                   |                                  |           | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/21-unstable?style=flat-square) |
| 21.0.2.0    | Eclipse Temurin 21.0.2                                                                        | azure-pipelines-dockercli:25.0.3 | 21.0.2.0  | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/swissgrc/azure-pipelines-openjdk/21.0.2.0?style=flat-square)    |

### Configuration

These environment variables are supported:

| Environment variable   | Default value        | Description                                                      |
|------------------------|----------------------|------------------------------------------------------------------|
| OPENJDK_VERSION        | `21.0.2.0.0+13`      | Version of Eclipse Temurin OpenJDK installed in the image.       |

[Eclipse Temurin OpenJDK]: https://adoptium.net/temurin/
[Azure Pipelines container jobs]: https://docs.microsoft.com/en-us/azure/devops/pipelines/process/container-phases
