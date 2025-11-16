# Giscus Comments Setup Guide

This blog uses [Giscus](https://giscus.app) for comments, which are powered by GitHub Discussions.

## Setup Steps

### 1. Enable GitHub Discussions

1. Go to your repository settings on GitHub
2. Navigate to the "Features" section
3. Enable "Discussions"

### 2. Install the Giscus App

1. Visit [https://github.com/apps/giscus](https://github.com/apps/giscus)
2. Click "Install"
3. Choose the repository for your blog
4. Grant the necessary permissions

### 3. Get Your Configuration

1. Visit [https://giscus.app](https://giscus.app)
2. Enter your repository in the format `owner/repo`
3. Select your preferred settings:
   - **Discussion Category**: Choose "General" or create a specific category for comments
   - **Mapping**: Use "pathname" (recommended)
   - **Reactions**: Enable (recommended)
   - **Theme**: Set to "preferred_color_scheme" (matches time-based themes automatically)

4. Copy the configuration values shown at the bottom

### 4. Update the Comments Component

Edit `src/components/interactive/Comments.astro` and replace these values:

```html
data-repo="OWNER/REPO"              <!-- e.g., "ibrahimcesar/1001cats" -->
data-repo-id="REPO_ID"              <!-- From giscus.app -->
data-category="General"              <!-- Your chosen category -->
data-category-id="CATEGORY_ID"      <!-- From giscus.app -->
```

### 5. Verify

1. Build and deploy your blog
2. Visit a blog post
3. Scroll to the comments section
4. You should see the Giscus comment interface

## Features

- ✅ Comments sync with GitHub Discussions
- ✅ Markdown support in comments
- ✅ Reactions and nested replies
- ✅ Automatic theme matching (adapts to time-based themes)
- ✅ No ads or tracking
- ✅ Moderation through GitHub

## Troubleshooting

### Comments not showing?

1. Verify Discussions are enabled in your repository
2. Check that the Giscus app is installed
3. Confirm your repo is public (Giscus requires public repos)
4. Verify the `data-repo` and IDs match your configuration

### Theme not matching?

The comments component automatically detects and applies the matching theme:
- **Morning/Afternoon** → Light theme
- **Evening** → Dark dimmed theme
- **Night** → Dark theme

## Alternative Options

If you prefer other commenting systems:

- **Utterances** - Simpler, uses GitHub Issues instead of Discussions
- **Webmentions** - Federated, IndieWeb-compatible
- **Disqus** - Traditional third-party comments (has ads on free tier)

For privacy and integration with the existing GitHub workflow, Giscus is recommended.

---

**Need help?** Check the [Giscus documentation](https://github.com/giscus/giscus/blob/main/ADVANCED-USAGE.md) for advanced configuration options.
