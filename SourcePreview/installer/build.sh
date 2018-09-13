#!/bin/bash

# Name of the package
NAME="SourcePreview"

# Once installed the identifier is used as the filename for a receipt files in /var/db/receipts/
IDENTIFIER="tsif.$NAME"

# Package version number
VERSION="1.0.1"

# The location to copy the contents of files
INSTALL_LOCATION="$HOME/Library/QuickLook/"

FILES_DIR="./files"
SCRIPTS_DIR="./scripts"
COMPILED_DIR="./compiled"

# Remove any unwanted .DS_Store files
find "$FILES_DIR/" -name '*.DS_Store' -type f -delete

# Set full read, write, execute permissions for owner and just read and execute permissions for group and other
/bin/chmod -R 755 "$FILES_DIR/"

# Remove any extended attributes (ACEs)
/usr/bin/xattr -rc "$FILES_DIR/"

# Build package
/usr/bin/pkgbuild \
    --root "$FILES_DIR/" \
    --install-location "$INSTALL_LOCATION" \
    --scripts "$SCRIPTS_DIR/" \
    --identifier "$IDENTIFIER" \
    --version "$VERSION" \
    "$COMPILED_DIR/$NAME-$VERSION.pkg"
