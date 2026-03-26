set -e

echo "--- Збірка артефактів ---"
mkdir -p artifacts

BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
COMMIT_HASH=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
PROJECT_NAME="Student-CI-Project"
VERSION="1.0.0"

cat <<EOF > artifacts/build_info.txt
build_time: $BUILD_TIME
commit: $COMMIT_HASH
project: $PROJECT_NAME
version: $VERSION
EOF

echo "Файл artifacts/build_info.txt створено."
