#!/bin/bash

# Colors and emojis
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo ""
echo -e "${BLUE}✍️  1001 Schrödinger's Cats - New Blog Post Creator ✍️${NC}"
echo ""

# Function to slugify text
slugify() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9-]/-/g' | sed 's/--*/-/g' | sed 's/^-//' | sed 's/-$//'
}

# Function to validate category
validate_category() {
    local category=$1
    local valid_categories=("science" "philosophy" "technology" "discordianism" "life" "universe" "everything")

    for valid in "${valid_categories[@]}"; do
        if [ "$category" = "$valid" ]; then
            return 0
        fi
    done
    return 1
}

# Get post title
while true; do
    echo -e "${GREEN}📝 Post Title:${NC}"
    read -r title
    if [ -n "$title" ]; then
        break
    else
        echo -e "${RED}❌ Title cannot be empty!${NC}"
    fi
done

# Generate slug from title
slug=$(slugify "$title")
echo -e "${YELLOW}📎 Generated slug: ${slug}${NC}"
echo -e "${YELLOW}   Press Enter to accept, or type a custom slug:${NC}"
read -r custom_slug
if [ -n "$custom_slug" ]; then
    slug=$custom_slug
fi

# Check if file already exists
filepath="src/content/blog/${slug}.md"
if [ -f "$filepath" ]; then
    echo -e "${RED}❌ Error: A post with this slug already exists!${NC}"
    exit 1
fi

# Get description
echo ""
echo -e "${GREEN}📄 Description (max 200 chars):${NC}"
read -r description
while [ ${#description} -gt 200 ]; do
    echo -e "${RED}❌ Description too long (${#description} chars). Max 200 chars.${NC}"
    read -r description
done

# Get author
echo ""
echo -e "${GREEN}✨ Author (default: 1001cats):${NC}"
read -r author
author=${author:-"1001cats"}

# Get category
echo ""
echo -e "${GREEN}📚 Category:${NC}"
echo -e "${YELLOW}   Available: science, philosophy, technology, discordianism, life, universe, everything${NC}"
while true; do
    read -r category
    if validate_category "$category"; then
        break
    else
        echo -e "${RED}❌ Invalid category. Please choose from the list above.${NC}"
    fi
done

# Get tags (Law of Fives - max 5!)
echo ""
echo -e "${GREEN}🏷️  Tags (comma-separated, max 5 - Law of Fives!):${NC}"
read -r tags_input
IFS=',' read -ra tags_array <<< "$tags_input"
tags_count=${#tags_array[@]}

if [ $tags_count -gt 5 ]; then
    echo -e "${YELLOW}⚠️  You provided ${tags_count} tags. Only the first 5 will be used (Law of Fives).${NC}"
    tags_array=("${tags_array[@]:0:5}")
fi

# Format tags for frontmatter
tags_formatted=""
for tag in "${tags_array[@]}"; do
    # Trim whitespace
    tag=$(echo "$tag" | xargs)
    if [ -n "$tag" ]; then
        tags_formatted="${tags_formatted}'${tag}', "
    fi
done
# Remove trailing comma and space
tags_formatted=${tags_formatted%, }

# Ask for featured image
echo ""
echo -e "${GREEN}🖼️  Featured image URL (optional, press Enter to skip):${NC}"
read -r image_url

image_section=""
if [ -n "$image_url" ]; then
    echo -e "${GREEN}🖼️  Image alt text (required for accessibility):${NC}"
    read -r image_alt
    while [ -z "$image_alt" ]; do
        echo -e "${RED}❌ Alt text is required for accessibility!${NC}"
        read -r image_alt
    done

    image_section="image:
  url: '$image_url'
  alt: '$image_alt'
"
fi

# Ask if it's a draft
echo ""
echo -e "${GREEN}📋 Is this a draft? (y/N):${NC}"
read -r is_draft
if [[ "$is_draft" =~ ^[Yy]$ ]]; then
    draft="true"
else
    draft="false"
fi

# Ask if featured
echo ""
echo -e "${GREEN}⭐ Is this a featured post? (y/N):${NC}"
read -r is_featured
if [[ "$is_featured" =~ ^[Yy]$ ]]; then
    featured="true"
else
    featured="false"
fi

# Ask about series
echo ""
echo -e "${GREEN}📖 Is this part of a series? (y/N):${NC}"
read -r is_series

series_section=""
if [[ "$is_series" =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}📖 Series name:${NC}"
    read -r series_name
    echo -e "${GREEN}📖 Part number in series:${NC}"
    read -r series_order

    series_section="series: '$series_name'
seriesOrder: $series_order
"
fi

# Get current date
current_date=$(date +%Y-%m-%d)

# Create the post file
cat > "$filepath" << EOF
---
title: '$title'
description: '$description'
pubDate: $current_date
author: '$author'
tags: [$tags_formatted]
category: '$category'
${image_section}draft: $draft
featured: $featured
${series_section}---

## Introduction

Write your introduction here...

## Main Content

Add your content here...

## Conclusion

Wrap it up here...

---

**Hail Eris! All Hail Discordia! 🍎**
EOF

# Success message
echo ""
echo -e "${GREEN}✅ Blog post created successfully!${NC}"
echo -e "${BLUE}📁 File: ${filepath}${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "  1. Edit the post: ${BLUE}${filepath}${NC}"
echo -e "  2. Start dev server: ${BLUE}make dev${NC}"
echo -e "  3. View at: ${BLUE}http://localhost:4321/blog/${slug}${NC}"
echo ""

# Ask if they want to open the file
echo -e "${GREEN}🚀 Open the file now? (y/N):${NC}"
read -r open_file
if [[ "$open_file" =~ ^[Yy]$ ]]; then
    # Try to detect the editor
    if [ -n "$EDITOR" ]; then
        $EDITOR "$filepath"
    elif command -v code >/dev/null 2>&1; then
        code "$filepath"
    elif command -v nano >/dev/null 2>&1; then
        nano "$filepath"
    elif command -v vim >/dev/null 2>&1; then
        vim "$filepath"
    else
        echo -e "${YELLOW}⚠️  No editor found. Please open manually: ${filepath}${NC}"
    fi
fi

echo ""
echo -e "${BLUE}🍎 Happy writing! 🍎${NC}"
echo ""
