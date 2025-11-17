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
