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

# Build markdown version
echo "Building Markdown..."
pandoc main.tex \
  -o paper.md \
  --from=latex \
  --to=gfm \
  --wrap=none
  #--to=markdown+tex_math_dollars+raw_tex-fenced_divs \
  #--wrap=none

awk '
  /^[[:space:]]*``` math[[:space:]]*$/ { print "$$"; in_math=1; next }
  in_math && /^[[:space:]]*```.*$/ { print "$$"; in_math=0; next }
  { print }
' paper.md > paper_tmp.md && mv paper_tmp.md paper.md

# Ensure blank lines around $$ blocks (but not between $$ and content)
# This awk script adds blank lines before opening $$ and after closing $$
awk '
  /^\$\$$/ {
    if (!in_math) {
      # Opening $$
      if (NR > 1 && prev_line != "") print ""
      print
      in_math = 1
    } else {
      # Closing $$
      print
      in_math = 0
      needs_blank = 1
    }
    next
  }
  {
    if (needs_blank && NF > 0) {
      print ""
      needs_blank = 0
    }
    print
    prev_line = $0
  }
' paper.md > paper_tmp.md && mv paper_tmp.md paper.md

# Remove \ensuremath commands that GitHub doesn't render
# This removes \ensuremath{...} and leaves just the content
sed -i '' 's/\\ensuremath{\([^}]*\)}/\1/g' paper.md

# Insert version header into markdown
TEMP_MD="paper_versioned.md"
{
    echo "---"
    echo ""
    echo "First published: November 13, 2025"
    echo "Version: $NEW_VERSION (on $(date '+%B %d, %Y'))"
    echo ""
    echo "---"
    echo "### Authored by pseudosig"
    cat paper.md
} > "$TEMP_MD"
mv "$TEMP_MD" paper.md

# Create releases directory if it doesn't exist
mkdir -p "$RELEASES_DIR"

# Copy outputs to releases folder with version in filename
echo "Copying files to releases folder..."
cp paper.pdf "$RELEASES_DIR/paper-v$NEW_VERSION.pdf"
cp paper.md "$RELEASES_DIR/paper-v$NEW_VERSION.md"

# Also keep latest versions without version suffix
cp paper.pdf "$RELEASES_DIR/paper-latest.pdf"
cp paper.md "$RELEASES_DIR/paper-latest.md"

# Clean up temporary files
rm -f paper.aux paper.log paper.out

echo "Build complete!"
echo "Version: $NEW_VERSION"
echo "Files created:"
echo "  - $RELEASES_DIR/paper-v$NEW_VERSION.pdf"
echo "  - $RELEASES_DIR/paper-v$NEW_VERSION.md"
echo "  - $RELEASES_DIR/paper-latest.pdf"
echo "  - $RELEASES_DIR/paper-latest.md"
