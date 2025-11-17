# AWS Amplify Deployment Guide for 1001cats.org

This guide will walk you through setting up AWS Amplify to automatically deploy your 1001cats blog whenever you push to the main branch.

## Prerequisites

- AWS Account with appropriate permissions
- GitHub repository with your code pushed
- Domain: 1001cats.org (already purchased)

## Step 1: Access AWS Amplify Console

1. Log in to the [AWS Console](https://console.aws.amazon.com/)
2. Search for "Amplify" in the services search bar
3. Click on "AWS Amplify"

## Step 2: Create New Amplify App

1. Click **"New app"** → **"Host web app"**
2. Select your Git provider (GitHub)
3. Authorize AWS Amplify to access your GitHub account if prompted
4. Select your repository: `1001cats`
5. Select the branch: `main`

## Step 3: Configure Build Settings

AWS Amplify should automatically detect the `amplify.yml` configuration file in your repository. Verify the settings:

**App name:** 1001cats

**Build settings:**
- The build configuration should be auto-detected from `amplify.yml`
- Verify it shows:
  - Build command: `npm run build`
  - Base directory: `/dist`
  - Node version: 18 or higher (Amplify uses 18 by default)

**Security & Performance Headers:**
The `amplify.yml` file includes custom headers for:
- **Security headers**: X-Frame-Options, X-Content-Type-Options, X-XSS-Protection, Referrer-Policy, Permissions-Policy
- **Cache optimization**: Long-term caching for fonts and Astro assets, short-term for Pagefind search index
- These are automatically applied by Amplify - no additional configuration needed

**Advanced settings (optional):**
- You can add environment variables if needed (currently none required)

## Step 4: Review and Deploy

1. Review all settings
2. Click **"Save and deploy"**
3. AWS Amplify will now:
   - Clone your repository
   - Install dependencies (`npm ci`)
   - Run the build command (`npm run build`)
   - Deploy the `/dist` folder

The initial deployment typically takes 3-5 minutes.

## Step 5: Configure Custom Domain (1001cats.org)

After the initial deployment succeeds:

1. In the AWS Amplify console, navigate to your app
2. Click on **"Domain management"** in the left sidebar
3. Click **"Add domain"**
4. Enter your domain: `1001cats.org`
5. Amplify will provide you with DNS configuration details

### DNS Configuration Options

**Option A: Using Route 53 (Recommended if domain is in Route 53)**
- Amplify can automatically configure DNS records
- Select "Use Route 53" and follow the prompts

**Option B: External DNS Provider**
If your domain is registered with another provider (GoDaddy, Namecheap, etc.):

1. Amplify will show you CNAME records to add
2. Go to your domain registrar's DNS settings
3. Add the provided CNAME records:
   - For `www.1001cats.org`: Points to Amplify's provided URL
   - For root domain `1001cats.org`: Either ANAME/ALIAS or redirect to www

**Typical DNS Records:**
```
Type: CNAME
Name: www
Value: [amplify-provided-url].amplifyapp.com

Type: A (or ANAME/ALIAS depending on provider)
Name: @ (or blank for root)
Value: [IP address or ALIAS target provided by Amplify]
```

4. Click **"Update DNS records"** after configuring
5. Wait for DNS propagation (can take 5-48 hours, usually ~1 hour)

### SSL Certificate

AWS Amplify automatically provisions and manages SSL certificates via AWS Certificate Manager (ACM). This process:
- Happens automatically after DNS verification
- Provides free SSL/TLS certificates
- Auto-renews certificates before expiration
- Supports both www and root domain

## Step 6: Configure Redirect Rules (Optional)

To redirect www to non-www (or vice versa):

1. In Amplify console, go to **"Rewrites and redirects"**
2. Add a redirect rule:

**Redirect www to root domain:**
```json
Source: https://www.1001cats.org/<*>
Target: https://1001cats.org/<*>
Type: 301 (Permanent Redirect)
```

**Or redirect root to www:**
```json
Source: https://1001cats.org/<*>
Target: https://www.1001cats.org/<*>
Type: 301 (Permanent Redirect)
```

## Automatic Deployments

Once configured, AWS Amplify will automatically:

1. **Detect changes** to the `main` branch
2. **Trigger a build** whenever you push commits
3. **Run tests** (via `astro check` in the build command)
4. **Deploy** if the build succeeds
5. **Send notifications** on build success/failure

### Branch-Based Deployments

You can also set up preview environments for other branches:

1. Go to **"Branch deployments"** in Amplify console
2. Click **"Connect branch"**
3. Select a branch (e.g., `develop`, `staging`)
4. Each branch gets its own preview URL

## Monitoring and Notifications

### Build Notifications

Set up email or SNS notifications:

1. Go to **"Notifications"** in the Amplify console
2. Click **"Add notification"**
3. Choose notification type (Email recommended)
4. Select events:
   - Build succeeded
   - Build failed
   - Deployment succeeded

### View Build Logs

- Click on any deployment in the Amplify console
- View detailed logs for each build phase:
  - Provision
  - Build
  - Deploy
  - Verify

## Performance Optimization

AWS Amplify automatically provides:

- **Global CDN** via Amazon CloudFront
- **HTTP/2 and HTTP/3** support
- **Gzip/Brotli compression**
- **Edge caching** for static assets
- **Instant cache invalidation** on new deploys

## Environment Variables (If Needed Later)

To add environment variables:

1. Go to **"Environment variables"** in Amplify console
2. Click **"Manage variables"**
3. Add key-value pairs
4. Variables are available during build time

Example:
```
Key: PUBLIC_SITE_URL
Value: https://1001cats.org
```

## Build Cache

AWS Amplify caches `node_modules` between builds (as configured in `amplify.yml`). To clear the cache:

1. Go to your app in Amplify console
2. Click **"Build settings"**
3. Click **"Clear cache"**
4. Trigger a new build

## Troubleshooting

### Build Fails

1. Check the build logs in Amplify console
2. Common issues:
   - TypeScript errors: Run `npm run build` locally first
   - Missing dependencies: Ensure `package.json` is up to date
   - Node version: Amplify uses Node 18 by default

### Custom Node Version

If you need a specific Node version, add to `amplify.yml`:

```yaml
version: 1
frontend:
  phases:
    preBuild:
      commands:
        - nvm install 20
        - nvm use 20
        - npm ci
```

### Domain Not Working

1. Verify DNS records are correctly configured
2. Check SSL certificate status in Amplify console
3. Wait for DNS propagation (up to 48 hours)
4. Test with `nslookup 1001cats.org`

### Build Performance

If builds are slow:
- Check if `npm ci` is being used (faster than `npm install`)
- Verify cache is working (check build logs)
- Consider reducing dependencies

## Cost Estimation

AWS Amplify Free Tier (first 12 months):
- 1000 build minutes per month
- 15 GB served per month
- 5 GB stored per month

After free tier or beyond limits:
- Build minutes: ~$0.01 per minute
- Hosting: ~$0.15 per GB served
- Storage: ~$0.023 per GB stored

For a blog with moderate traffic, expect $0-5/month after free tier.

## Useful Commands

### Local Testing Before Deploy

```bash
# Run type checking and build
npm run build

# Preview the production build locally
npm run preview
```

### Force a Rebuild

In the Amplify console:
1. Go to your app
2. Click **"Run build"** on the main branch
3. Or push an empty commit to trigger:
```bash
git commit --allow-empty -m "Trigger rebuild"
git push origin main
```

## Security Best Practices

1. **Enable branch protection** on GitHub for the `main` branch
2. **Use preview deployments** for testing before merging to main
3. **Review Amplify IAM permissions** - ensure least privilege
4. **Enable AWS CloudTrail** for audit logging
5. **Set up AWS Budget alerts** to monitor costs

## Additional Resources

- [AWS Amplify Documentation](https://docs.aws.amazon.com/amplify/)
- [Astro Deployment Guide](https://docs.astro.build/en/guides/deploy/)
- [AWS Amplify Pricing](https://aws.amazon.com/amplify/pricing/)

## Quick Reference: Deployment Checklist

- [ ] AWS Amplify app created and connected to GitHub
- [ ] Initial deployment successful
- [ ] Custom domain (1001cats.org) configured
- [ ] DNS records updated with registrar
- [ ] SSL certificate verified
- [ ] www redirect configured (if desired)
- [ ] Build notifications set up
- [ ] Test automatic deployment by pushing to main
- [ ] Verify site is accessible at https://1001cats.org

---

**Last Updated:** 2025-11-16

**Hail Eris! All Hail Discordia!** 🍎

# 1001 Schrödinger's Cats - Deployment Guide

This guide covers deploying the blog to various hosting platforms.

## 📋 Pre-Deployment Checklist

Before deploying, ensure:

- [ ] Update `site` URL in `astro.config.mjs` to your production domain
- [ ] Update `robots.txt` sitemap URLs to match your domain
- [ ] Configure Giscus settings in `src/components/interactive/Comments.astro`
- [ ] Test build locally: `npm run build`
- [ ] Preview build locally: `npm run preview`
- [ ] Verify sitemap is generated: check `dist/sitemap-index.xml`

## 🚀 Deployment Options

### Option 1: Vercel (Recommended)

**Why Vercel?**
- Zero-config Astro support
- Automatic HTTPS
- Edge network for global performance
- Preview deployments for PRs
- Free tier available

**Steps:**

1. **Install Vercel CLI** (optional):
   ```bash
   npm install -g vercel
   ```

2. **Deploy via GitHub** (easiest):
   - Push code to GitHub
   - Visit [vercel.com/new](https://vercel.com/new)
   - Import your repository
   - Vercel auto-detects Astro and configures everything
   - Click "Deploy"

3. **Deploy via CLI**:
   ```bash
   vercel
   ```

4. **Configuration**:
   - The `vercel.json` file is already configured
   - No additional setup needed

**Environment Variables:**
- None required for basic setup
- Add any custom variables in Vercel dashboard

---

### Option 2: Netlify

**Why Netlify?**
- Great DX with instant rollbacks
- Form handling built-in
- Edge functions
- Free tier available

**Steps:**

1. **Deploy via GitHub**:
   - Push code to GitHub
   - Visit [app.netlify.com](https://app.netlify.com)
   - Click "Add new site" → "Import an existing project"
   - Select your repository
   - Build settings are auto-detected from `netlify.toml`
   - Click "Deploy"

2. **Deploy via CLI**:
   ```bash
   npm install -g netlify-cli
   netlify init
   netlify deploy --prod
   ```

3. **Configuration**:
   - The `netlify.toml` file is already configured
   - Build command: `npm run build`
   - Publish directory: `dist`
   - Node version: 18

---

### Option 3: Cloudflare Pages

**Why Cloudflare Pages?**
- Global CDN with excellent performance
- Unlimited bandwidth on free tier
- Built-in analytics
- Free tier available

**Steps:**

1. **Deploy via GitHub**:
   - Push code to GitHub
   - Visit [dash.cloudflare.com](https://dash.cloudflare.com)
   - Go to "Pages" → "Create a project"
   - Connect your GitHub repository
   - Configure build:
     - **Framework preset**: Astro
     - **Build command**: `npm run build`
     - **Build output directory**: `dist`
     - **Node version**: 18
   - Click "Save and Deploy"

2. **Configuration**:
   - Custom headers are in `public/_headers`
   - No additional config file needed

---

## 🔧 Build Configuration

### Environment

**Node Version**: 18 or higher
**Package Manager**: npm (default)

### Build Command

```bash
npm run build
```

This runs:
1. `astro check` - TypeScript checking
2. `astro build` - Build Astro site
3. `pagefind --site dist` - Generate search index

### Output Directory

```
dist/
```

All static files are generated here.

---

## 🌐 Custom Domain Setup

### DNS Configuration

**For Vercel:**
1. Add domain in Vercel dashboard
2. Update DNS records:
   - **A Record**: `76.76.21.21`
   - **CNAME**: `cname.vercel-dns.com`

**For Netlify:**
1. Add domain in Netlify dashboard
2. Update DNS records (provided by Netlify)
3. Or use Netlify DNS for easier setup

**For Cloudflare Pages:**
1. Your domain likely already uses Cloudflare DNS
2. Add CNAME pointing to your Pages URL

### SSL/HTTPS

All platforms automatically provision SSL certificates via Let's Encrypt.

---

## 📊 Post-Deployment Tasks

### 1. Verify Deployment

- [ ] Visit your site and check all pages load
- [ ] Test search functionality
- [ ] Verify time-based theme changes
- [ ] Check image lightbox works
- [ ] Test comments (Giscus) if configured
- [ ] Verify sitemap: `https://yourdomain.com/sitemap-index.xml`
- [ ] Check robots.txt: `https://yourdomain.com/robots.txt`

### 2. Configure Giscus Comments

1. Enable GitHub Discussions on your repo
2. Install Giscus app: https://github.com/apps/giscus
3. Visit https://giscus.app and configure
4. Update `src/components/interactive/Comments.astro` with your settings:
   ```html
   data-repo="USERNAME/REPO"
   data-repo-id="YOUR_REPO_ID"
   data-category="General"
   data-category-id="YOUR_CATEGORY_ID"
   ```

### 3. Submit Sitemap to Search Engines

**Google Search Console:**
1. Visit [search.google.com/search-console](https://search.google.com/search-console)
2. Add your property
3. Submit sitemap: `https://yourdomain.com/sitemap-index.xml`

**Bing Webmaster Tools:**
1. Visit [bing.com/webmasters](https://www.bing.com/webmasters)
2. Add your site
3. Submit sitemap: `https://yourdomain.com/sitemap-index.xml`

### 4. Set up Analytics (Optional)

**Privacy-Focused Options:**
- **Plausible**: Simple, privacy-friendly analytics
- **Fathom**: GDPR compliant analytics
- **Cloudflare Web Analytics**: Free, privacy-first

**Integration:**
Add analytics script to `src/layouts/BaseLayout.astro`

---

## 🔄 Continuous Deployment

### Automatic Deployments

All platforms support automatic deployment on git push:

1. **Production**: Push to `main` branch → deploys to production
2. **Preview**: Open PR → creates preview deployment
3. **Branches**: Push to other branches → creates branch deployment

### Manual Deployments

**Vercel:**
```bash
vercel --prod
```

**Netlify:**
```bash
netlify deploy --prod
```

**Cloudflare Pages:**
Use dashboard or `wrangler pages deploy dist`

---

## 🐛 Troubleshooting

### Build Fails

**Issue**: TypeScript errors
**Solution**: Run `npm run build` locally to see errors

**Issue**: Missing dependencies
**Solution**: Ensure all dependencies are in `package.json`, not `package-lock.json`

**Issue**: Pagefind fails
**Solution**: Ensure build completes before Pagefind runs

### Search Not Working

**Issue**: Pagefind files missing
**Solution**: Verify `pagefind/` directory exists in `dist/`

**Issue**: Import errors
**Solution**: Pagefind generates files at build time, won't work in dev mode

### Comments Not Showing

**Issue**: Giscus not loading
**Solution**:
1. Check GitHub Discussions is enabled
2. Verify Giscus app is installed
3. Confirm repo/category IDs are correct

---

## 📈 Performance Optimization

### Image Optimization

- Use Astro's `<Image>` component (already implemented)
- Serve images as WebP with fallbacks
- Lazy load images below the fold

### Caching

- Static assets cached for 1 year (configured)
- Pagefind index cached for 1 hour (configured)
- HTML pages: default platform caching

### CDN

All recommended platforms use global CDNs automatically.

---

## 🔒 Security Headers

Security headers are configured in:
- `vercel.json` (for Vercel)
- `netlify.toml` (for Netlify)
- `public/_headers` (for Cloudflare Pages)

Headers include:
- `X-Frame-Options: DENY`
- `X-Content-Type-Options: nosniff`
- `X-XSS-Protection: 1; mode=block`
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Permissions-Policy` restrictions

---

## 📝 Maintenance

### Update Dependencies

```bash
npm update
npm audit fix
```

### Monitor Performance

- Check Core Web Vitals in search console
- Run Lighthouse audits regularly
- Monitor build times

### Backup

All platforms maintain deployment history. Additionally:
- Git repository serves as source backup
- Consider backing up Giscus discussions

---

## 🎉 Launch Checklist

- [ ] Deploy to chosen platform
- [ ] Configure custom domain
- [ ] Set up SSL (automatic)
- [ ] Configure Giscus comments
- [ ] Submit sitemap to Google
- [ ] Submit sitemap to Bing
- [ ] Set up analytics (optional)
- [ ] Test all features
- [ ] Announce launch! 🚀

---

**Hail Eris! All Hail Discordia!** 🍎

May your deployments be bug-free and your uptime be infinite (or at least as close as quantum mechanics allows).
