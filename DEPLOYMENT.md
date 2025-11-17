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
