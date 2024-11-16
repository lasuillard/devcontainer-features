#!/bin/sh

set -e

if ! command -v curl; then
  echo "Installing curl"
  apt-get update && apt-get install -y curl
fi

# Java
# ----------------------------------------------------------------------------
if [ "$INSTALL_JAVA" = 'true' ]; then
  echo "Installing default-jre as \$INSTALL_JAVA is set to true"
  apt-get update && apt-get install -y default-jre
fi

# OpenAPI Generator CLI
# ----------------------------------------------------------------------------
if [ "$OPENAPI_GENERATOR_CLI_VERSION" = 'latest' ]; then
  echo "Resolving latest version of OpenAPI Generator CLI"
  OPENAPI_GENERATOR_CLI_VERSION=$(
    curl https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/maven-metadata.xml |
      grep -Eo '<latest>(.+)</latest>' |
      sed -E 's/<latest>(.+)<\/latest>/\1/'
  )
fi

echo "Installing OpenAPI Generator CLI with version ${OPENAPI_GENERATOR_CLI_VERSION}"
curl -o /usr/local/lib/openapi-generator-cli.jar \
  "https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/${OPENAPI_GENERATOR_CLI_VERSION}/openapi-generator-cli-${OPENAPI_GENERATOR_CLI_VERSION}.jar"

# Wrapper
# ----------------------------------------------------------------------------
echo "Creating wrapper script for OpenAPI Generator CLI"
cat <<EOF >/usr/local/bin/openapi-generator-cli
#!/bin/sh

java -jar /usr/local/lib/openapi-generator-cli.jar "\$@"
EOF
chmod +x /usr/local/bin/openapi-generator-cli
