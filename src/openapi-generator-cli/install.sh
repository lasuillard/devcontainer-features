#!/bin/sh

set -e

apt-get update && apt-get install -y curl

if [ "$VERSION" = 'latest' ]; then
    echo "Resolving latest version of OpenAPI Generator CLI"
    VERSION=$(
        curl https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/maven-metadata.xml \
            | grep -Eo '<latest>(.+)</latest>' \
            | sed -E 's/<latest>(.+)<\/latest>/\1/'
    )
fi

echo "Installing OpenAPI Generator CLI with version ${VERSION}"

curl -o /usr/local/lib/openapi-generator-cli.jar \
    "https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/${VERSION}/openapi-generator-cli-${VERSION}.jar"

echo "Creating wrapper script for OpenAPI Generator CLI"

cat <<EOF > /usr/local/bin/openapi-generator-cli
#!/bin/sh

java -jar /usr/local/lib/openapi-generator-cli.jar "\$@"
EOF
chmod +x /usr/local/bin/openapi-generator-cli
