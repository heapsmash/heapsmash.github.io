#!/bin/bash

set -e  # Exit on error

# Version file location
VERSION_FILE="version.txt"
RELEASES_DIR="releases"

# Function to display usage
usage() {
    echo "Usage: $0 [major|minor|patch|skip]"
    echo "  major - Bump major version (X.0.0)"
    echo "  minor - Bump minor version (0.X.0)"
    echo "  patch - Bump patch version (0.0.X)"
    echo "  skip  - Rebuild without bumping version"
    echo "  (default: patch)"
    exit 1
}

# Read current version
if [ ! -f "$VERSION_FILE" ]; then
    echo "1.0.0" > "$VERSION_FILE"
fi

CURRENT_VERSION=$(cat "$VERSION_FILE")
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR="${VERSION_PARTS[0]}"
MINOR="${VERSION_PARTS[1]}"
PATCH="${VERSION_PARTS[2]}"

# Determine what to bump (default: patch)
BUMP_TYPE="${1:-patch}"

if [ "$BUMP_TYPE" = "skip" ]; then
    # Skip version bumping, just rebuild
    NEW_VERSION="$CURRENT_VERSION"
    echo "Rebuilding without version bump (current version: $CURRENT_VERSION)"
else
    case "$BUMP_TYPE" in
        major)
            MAJOR=$((MAJOR + 1))
            MINOR=0
            PATCH=0
            ;;
        minor)
            MINOR=$((MINOR + 1))
            PATCH=0
            ;;
        patch)
            PATCH=$((PATCH + 1))
            ;;
        *)
            echo "Error: Invalid bump type '$BUMP_TYPE'"
            usage
            ;;
    esac

    NEW_VERSION="$MAJOR.$MINOR.$PATCH"
    echo "Bumping version from $CURRENT_VERSION to $NEW_VERSION"

    # Save new version
    echo "$NEW_VERSION" > "$VERSION_FILE"

    # Update version in main.tex
    # Looking for pattern like "Version 1.1 (on \today)" and replacing with new version
    echo "Updating version in main.tex..."
    sed -i '' "s/Version [0-9][0-9]*\.[0-9][0-9]*\(\.[0-9][0-9]*\)*/Version $NEW_VERSION/" main.tex
fi

# Building PDF version
echo "Building PDF..."
xelatex -jobname=paper main.tex
xelatex -jobname=paper main.tex  # Run twice for references

# Build HTML version with MathJax
echo "Building HTML..."
pandoc main.tex \
  -o paper.html \
  --from=latex \
  --to=html5 \
  --standalone \
  --mathjax \
  --metadata title="Coherence, Effect Logic, and the Structural Nature of Physical Systems" \
  --metadata author="pseudosig"

# Add version info to HTML
TEMP_HTML="paper_versioned.html"
{
    sed -n '1,/<body>/p' paper.html
    echo "<div style='text-align: center; margin: 2em 0;'>"
    echo "<p><strong>First published:</strong> November 13, 2025</p>"
    echo "<p><strong>Version:</strong> $NEW_VERSION ($(date '+%B %d, %Y'))</p>"
    echo "<p><strong>Author:</strong> pseudosig</p>"
    echo "</div>"
    echo "<hr>"
    sed -n '/<body>/,/<\/body>/p' paper.html | sed '1d;$d'
    sed -n '/<\/body>/,$p' paper.html
} > "$TEMP_HTML"
mv "$TEMP_HTML" paper.html

# Remove \ensuremath commands from HTML
sed -i '' 's/\\ensuremath{\([^}]*\)}/\1/g' paper.html

# Still build markdown for source viewing
echo "Building Markdown..."
pandoc main.tex \
  -o paper.md \
  --from=latex \
  --to=markdown \
  --wrap=none

# Remove \ensuremath commands that don't render properly
sed -i '' 's/\\ensuremath{\([^}]*\)}/\1/g' paper.md

# Create releases directory if it doesn't exist
mkdir -p "$RELEASES_DIR"

# Copy outputs to releases folder with version in filename
echo "Copying files to releases folder..."
cp paper.pdf "$RELEASES_DIR/paper-v$NEW_VERSION.pdf"
cp paper.html "$RELEASES_DIR/paper-v$NEW_VERSION.html"
cp paper.md "$RELEASES_DIR/paper-v$NEW_VERSION.md"

# Also keep latest versions without version suffix
cp paper.pdf "$RELEASES_DIR/paper-latest.pdf"
cp paper.html "$RELEASES_DIR/paper-latest.html"
cp paper.md "$RELEASES_DIR/paper-latest.md"

# Clean up temporary files
rm -f paper.aux paper.log paper.out

echo "Build complete!"
echo "Version: $NEW_VERSION"
echo "Files created:"
echo "  - $RELEASES_DIR/paper-v$NEW_VERSION.pdf"
echo "  - $RELEASES_DIR/paper-v$NEW_VERSION.html"
echo "  - $RELEASES_DIR/paper-v$NEW_VERSION.md"
echo "  - $RELEASES_DIR/paper-latest.pdf"
echo "  - $RELEASES_DIR/paper-latest.html"
echo "  - $RELEASES_DIR/paper-latest.md"
