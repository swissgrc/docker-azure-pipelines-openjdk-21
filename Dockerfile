# Base image containing dependencies used in builder and final image
FROM ghcr.io/swissgrc/azure-pipelines-dockercli:27.3.1 AS base

# Make sure to fail due to an error at any stage in shell pipes
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Builder image
FROM base AS build

# Make sure to fail due to an error at any stage in shell pipes
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# renovate: datasource=repology depName=debian_12/curl versioning=loose
ENV CURL_VERSION=7.88.1-10+deb12u7
# renovate: datasource=repology depName=debian_12/lsb-release versioning=loose
ENV LSBRELEASE_VERSION=12.0-1
# renovate: datasource=repology depName=debian_12/gnupg2 versioning=loose
ENV GNUPG_VERSION=2.2.40-1.1

RUN apt-get update -y && \
  # Install necessary dependencies
  apt-get install -y --no-install-recommends \
    curl=${CURL_VERSION} \
    gnupg=${GNUPG_VERSION} \
    lsb-release=${LSBRELEASE_VERSION} && \
  # Add Eclipse Adoptium public key
  curl --proto "=https" -fsSL https://packages.adoptium.net/artifactory/api/gpg/key/public \
    | tee /etc/apt/keyrings/adoptium.asc && \
  # Add Eclipse Adoptium APT repository to the list of sources
  echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" \
    | tee /etc/apt/sources.list.d/adoptium.list > /dev/null


# Final image
FROM base AS final

LABEL org.opencontainers.image.vendor="Swiss GRC AG"
LABEL org.opencontainers.image.authors="Swiss GRC AG <opensource@swissgrc.com>"
LABEL org.opencontainers.image.title="azure-pipelines-openjdk"
LABEL org.opencontainers.image.documentation="https://github.com/swissgrc/docker-azure-pipelines-openjdk"

# Make sure to fail due to an error at any stage in shell pipes
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /
COPY --from=build /etc/apt/keyrings/ /etc/apt/keyrings
COPY --from=build /etc/apt/sources.list.d/ /etc/apt/sources.list.d

# Install OpenJDK

# renovate: datasource=adoptium-java depName=java-jdk versioning=loose
ENV OPENJDK_VERSION=21.0.4.0.0+7-1

# Install OpenJDK
RUN apt-get update -y && \
  apt-get install -y --no-install-recommends temurin-21-jdk=${OPENJDK_VERSION} && \
  # Clean up
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  # Smoke test
  java -version
