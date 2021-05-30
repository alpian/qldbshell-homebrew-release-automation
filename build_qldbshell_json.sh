#!/bin/bash
VERSION=$1
LINUX_SHA=$(curl -sL https://github.com/awslabs/amazon-qldb-shell/releases/download/v$VERSION/qldb-v$VERSION-linux.tar.gz.sha256)
MAC_SHA=$(curl -sL https://github.com/awslabs/amazon-qldb-shell/releases/download/v$VERSION/qldb-v$VERSION-mac.tar.gz.sha256)

if [[ "$LINUX_SHA" == "Not Found" || "$MAC_SHA" == "Not Found" ]]; then
    echo "No release found with version \"$VERSION\""
    exit 1
fi

echo '{
  "name": "qldbshell",
  "version": "'$VERSION'",
  "bin": "qldb",
  "bottle": {
    "root_url": "https://github.com/awslabs/amazon-qldb-shell/releases/download/",
    "sha256": {
      "sierra": "'$MAC_SHA'",
      "linux": "'$LINUX_SHA'"
    }
  }
}' > qldbshell.json
