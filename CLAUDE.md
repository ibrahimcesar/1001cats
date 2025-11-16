# 1001cats Astro Blog - Project Plan

**A Discordian blog on science, philosophy, life, the universe, and everything**

---

## 📋 Project Overview

This document outlines the comprehensive plan for building the 1001cats blog using Astro, with a focus on accessibility, interactivity, and unique user experience features.

### Core Requirements
- Modern Astro-based blog (English-only)
- Time-based dynamic color scheme
- Integrated commenting system
- Strong accessibility features (WCAG 2.1 AA compliance)
- Interactive and engaging user experience

---

## 🛠 Technology Stack

### Core Framework
- **Astro 4.x** - Static Site Generation with islands architecture
- **TypeScript** - Type safety and enhanced developer experience
- **Tailwind CSS** - Utility-first styling with custom theming
- **Content Collections** - Type-safe content management

### Additional Tools
- **Shiki/Prism** - Syntax highlighting for code blocks
- **Pagefind/Fuse.js** - Client-side search functionality
- **Giscus** - GitHub Discussions-based commenting
- **View Transitions API** - Smooth page transitions

---

## 🎨 Time-Based Color Scheme System

### Concept
Dynamic theming that adapts to the user's local time of day, creating an immersive reading experience that changes throughout the day.

### Time Periods & Themes

**🌅 Morning (6am-12pm)**
- Soft, warm pastels
- Gentle awakening colors
- Optimistic and fresh feel

**☀️ Afternoon (12pm-6pm)**
- Bright, energetic colors
- High contrast for readability
- Vibrant and active

**🌆 Evening (6pm-10pm)**
- Warm, muted tones
- Relaxed atmosphere
- Transitional colors

**🌙 Night (10pm-6am)**
- Dark mode with cool accents
- Reduced eye strain
- Calm and contemplative

### Technical Implementation
```javascript
// Time-based theme detection
- Client-side JavaScript detects local time
- CSS custom properties for theme variables
- Smooth transitions between themes (transition-duration: 300ms)
- LocalStorage persistence for user preferences
- Manual override toggle available
```

### CSS Custom Properties
```css
--bg-primary        /* Main background */
--bg-secondary      /* Cards, sections */
--text-primary      /* Body text */
--text-secondary    /* Muted text */
--accent-primary    /* Links, CTAs */
--accent-secondary  /* Hover states */
--border-color      /* Borders, dividers */
--shadow-color      /* Shadows, depth */
```

---

## 💬 Commenting System

### Recommended: Giscus

**Why Giscus?**
- ✅ Built on GitHub Discussions
- ✅ Free and open-source
- ✅ Privacy-friendly (no tracking)
- ✅ Markdown support
- ✅ Reactions and nested replies
- ✅ No ads or analytics
- ✅ Integrates with existing GitHub repo

**Implementation Details:**
- Lazy loading (loads when scrolled into view)
- Respects time-based theme
- Per-post discussion categories
- Moderation through GitHub
- SEO-friendly (comments are indexed)

**Alternative Options:**
- **Utterances** - Simpler, GitHub Issues-based
- **Webmentions** - Federated, IndieWeb standard

---

## ♿ Accessibility Features

### WCAG 2.1 AA Compliance

#### Visual Accessibility
- ✅ **Contrast Ratios**: Minimum 4.5:1 for all text
- ✅ **Scalable Fonts**: rem units, respects user preferences
- ✅ **Focus Indicators**: Visible focus states for all interactive elements
- ✅ **Color Independence**: Information not conveyed by color alone
- ✅ **Reduced Motion**: Respects `prefers-reduced-motion` media query

#### Semantic Structure
- ✅ **HTML5 Semantics**: `<article>`, `<nav>`, `<main>`, `<aside>`, `<header>`, `<footer>`
- ✅ **Skip Links**: "Skip to main content" for keyboard users
- ✅ **Heading Hierarchy**: Logical h1→h2→h3 structure
- ✅ **ARIA Labels**: Where semantic HTML isn't sufficient
- ✅ **Landmarks**: Proper document structure for screen readers

#### Content Accessibility
- ✅ **Alt Text**: Required for all images (enforced in content schema)
- ✅ **Descriptive Links**: No generic "click here" text
- ✅ **Multimedia**: Transcripts/descriptions when needed
- ✅ **Typography**: 16px minimum, 1.5 line height
- ✅ **Line Length**: Maximum ~75 characters for optimal readability

#### Keyboard Navigation
- ✅ **Tab Order**: Logical and intuitive
- ✅ **Keyboard Shortcuts**: Document any custom shortcuts
- ✅ **Focus Management**: Proper focus handling in interactive components
- ✅ **No Keyboard Traps**: Users can navigate freely

#### Forms & Interactions
- ✅ **Input Labels**: Properly associated labels
- ✅ **Error Messages**: Clear, descriptive, and accessible
- ✅ **Required Fields**: Clearly indicated
- ✅ **Validation**: Accessible error states

---

## 🎯 Interactive Features

### Reading Experience Enhancements

**Reading Progress Bar**
- Visual indicator at top of page
- Shows scroll progress through article
- Smooth animation

**Estimated Reading Time**
- Calculated from word count (200-250 WPM)
- Displayed prominently on post cards and headers

**Table of Contents**
- Auto-generated from heading structure
- Sticky sidebar on desktop
- Collapsible on mobile
- Active section highlighting
- Smooth scroll to sections

**Code Features**
- Syntax highlighting with Shiki
- Copy to clipboard button
- Line numbers for long snippets
- Language badges

**Anchor Links**
- Hoverable heading links
- Copy link to specific sections
- Deep linking support

### Discovery & Navigation

**Search Functionality**
- Client-side search (Pagefind or Fuse.js)
- Search by title, content, tags
- Keyboard shortcuts (/ to focus)
- Instant results

**Related Posts**
- Algorithm based on shared tags
- Display 3-5 related articles
- Promotes content discovery

**Tags & Categories**
- Filterable tag pages
- Tag clouds or lists
- Category archives
- Multi-tag filtering

**Series/Collections**
- Multi-part blog posts
- Navigation between series parts
- Series progress indicator

### Social & Sharing

**Share Buttons**
- Twitter/X
- Mastodon
- Email
- Copy link
- Native Web Share API on mobile

**RSS Feed**
- Full content RSS
- Separate feeds per category/tag
- Auto-discovery meta tags

**View Counter** (Optional)
- Privacy-friendly analytics
- No personal data collection
- Simple page view stats

### Visual Polish

**View Transitions API**
- Smooth page-to-page transitions
- Maintained scroll position
- Progressive enhancement

**Hover Effects**
- Subtle animations on cards
- Link underline animations
- Button states

**Image Lightbox**
- Click to expand images
- Keyboard navigation
- Captions support

**Loading States**
- Skeleton screens
- Graceful degradation
- No layout shift

### Easter Eggs 🎭

**Discordian References**
- "Fnord" hidden in posts (visible on hover)
- 5/23 date celebrations
- Sacred Chao favicon option
- Kallisti awards for featured posts
- Law of Fives (5 tags max, 5 related posts, etc.)
- Random Principia Discordia quotes

---

## 📁 Project Structure

```
1001cats/
├── src/
│   ├── components/
│   │   ├── blog/
│   │   │   ├── BlogCard.astro           # Post preview card
│   │   │   ├── BlogPost.astro           # Full post layout
│   │   │   ├── ReadingProgress.astro    # Progress bar
│   │   │   ├── TableOfContents.astro    # Auto-generated TOC
│   │   │   ├── RelatedPosts.astro       # Related content
│   │   │   └── SeriesNav.astro          # Series navigation
│   │   ├── common/
│   │   │   ├── Header.astro             # Site header
│   │   │   ├── Footer.astro             # Site footer
│   │   │   ├── Navigation.astro         # Main nav
│   │   │   └── SkipLink.astro           # Accessibility skip link
│   │   ├── interactive/
│   │   │   ├── Search.astro             # Search component
│   │   │   ├── ThemeManager.astro       # Time-based theme handler
│   │   │   ├── Comments.astro           # Giscus integration
│   │   │   ├── ShareButtons.astro       # Social sharing
│   │   │   └── ImageLightbox.astro      # Image viewer
│   │   └── ui/
│   │       ├── Button.astro             # Reusable button
│   │       ├── Card.astro               # Content card
│   │       ├── Tag.astro                # Tag pill
│   │       └── Badge.astro              # Status badges
│   ├── content/
│   │   ├── blog/
│   │   │   ├── welcome.md               # First blog post
│   │   │   └── ...                      # More posts
│   │   └── config.ts                    # Content collections config
│   ├── layouts/
│   │   ├── BaseLayout.astro             # Base HTML structure
│   │   ├── BlogLayout.astro             # Blog post layout
│   │   └── PageLayout.astro             # Static page layout
│   ├── pages/
│   │   ├── index.astro                  # Homepage
│   │   ├── blog/
│   │   │   ├── index.astro              # Blog listing
│   │   │   ├── [slug].astro             # Individual posts
│   │   │   ├── tag/
│   │   │   │   └── [tag].astro          # Tag archives
│   │   │   └── category/
│   │   │       └── [category].astro     # Category archives
│   │   ├── about.astro                  # About page
│   │   ├── search.astro                 # Search page
│   │   ├── rss.xml.ts                   # RSS feed
│   │   └── sitemap.xml.ts               # Sitemap
│   ├── styles/
│   │   ├── global.css                   # Global styles
│   │   ├── themes.css                   # Theme definitions
│   │   └── prose.css                    # Typography styles
│   ├── utils/
│   │   ├── time-theme.ts                # Time detection logic
│   │   ├── reading-time.ts              # Reading time calculator
│   │   ├── formatDate.ts                # Date formatting
│   │   ├── toc.ts                       # TOC generator
│   │   └── related-posts.ts             # Related content algorithm
│   └── env.d.ts                         # TypeScript env declarations
├── public/
│   ├── fonts/                           # Custom fonts
│   ├── images/                          # Static images
│   │   ├── og-default.png               # Default OG image
│   │   └── sacred-chao.svg              # Discordian icon
│   ├── robots.txt                       # SEO robots file
│   └── manifest.json                    # PWA manifest (optional)
├── astro.config.mjs                     # Astro configuration
├── tailwind.config.mjs                  # Tailwind configuration
├── tsconfig.json                        # TypeScript configuration
├── package.json                         # Dependencies
├── README.md                            # Project readme
└── CLAUDE.md                            # This file
```

---

## 📝 Content Strategy

### Blog Post Schema

```typescript
interface BlogPost {
  title: string              // Post title
  description: string        // SEO description / excerpt
  pubDate: Date             // Publication date
  updatedDate?: Date        // Last updated (optional)
  author: string            // Author name
  tags: string[]            // Content tags (max 5)
  category: string          // Primary category
  image?: {                 // Featured image
    url: string
    alt: string             // Required for accessibility
  }
  series?: string           // Series name (optional)
  seriesOrder?: number      // Position in series
  draft: boolean            // Draft status
  featured?: boolean        // Featured post flag
}
```

### Content Guidelines

**Language:** English-only

**Format:**
- Markdown with MDX support for interactive components
- Frontmatter validation via Zod schema
- Code blocks with language specification

**Images:**
- WebP format with PNG/JPG fallbacks
- Responsive sizes via Astro `<Image>` component
- Required alt text enforced by schema

**Writing Style:**
- Discordian philosophy
- Science, philosophy, existential topics
- Humor and deep thinking balanced
- References to The Hitchhiker's Guide encouraged

---

## ⚡ Performance Targets

### Lighthouse Scores
- **Performance:** 95+
- **Accessibility:** 100
- **Best Practices:** 95+
- **SEO:** 100

### Core Web Vitals
- **First Contentful Paint (FCP):** < 1.5s
- **Largest Contentful Paint (LCP):** < 2.5s
- **Time to Interactive (TTI):** < 3.5s
- **Cumulative Layout Shift (CLS):** < 0.1
- **First Input Delay (FID):** < 100ms

### Optimization Strategies
- Image optimization with Astro's `<Image>` component
- CSS/JS minification and bundling
- Critical CSS inlining
- Lazy loading for images and comments
- Preloading critical resources
- Font optimization (woff2, font-display: swap)

---

## 🔍 SEO Strategy

### Meta Tags
- Title tags (55-60 characters)
- Meta descriptions (150-160 characters)
- OpenGraph tags for social sharing
- Twitter Card tags
- Canonical URLs
- Language declaration

### Structured Data
```json
{
  "@type": "BlogPosting",
  "headline": "...",
  "datePublished": "...",
  "dateModified": "...",
  "author": {...},
  "image": "...",
  "publisher": {...}
}
```

### Technical SEO
- XML sitemap generation
- robots.txt configuration
- RSS feed with full content
- Semantic HTML structure
- Clean, descriptive URLs
- Internal linking strategy

---

## 🚀 Development Phases

### Phase 1: Foundation (Week 1)
- [ ] Initialize Astro project with TypeScript
- [ ] Set up Tailwind CSS
- [ ] Create base layouts (BaseLayout, PageLayout)
- [ ] Implement time-based theming system
- [ ] Set up content collections with schema
- [ ] Create basic component library

### Phase 2: Core Blog Features (Week 2)
- [ ] Blog listing page with pagination
- [ ] Individual blog post pages
- [ ] Tag and category pages
- [ ] Navigation and routing
- [ ] RSS feed generation
- [ ] SEO meta tags and structured data

### Phase 3: Interactivity (Week 3)
- [ ] Search functionality
- [ ] Comments integration (Giscus)
- [ ] Reading progress indicator
- [ ] Table of contents component
- [ ] Share buttons
- [ ] Related posts algorithm
- [ ] Image lightbox

### Phase 4: Polish & Accessibility (Week 4)
- [ ] Accessibility audit (WAVE, axe DevTools)
- [ ] Keyboard navigation testing
- [ ] Screen reader testing
- [ ] Performance optimization
- [ ] Responsive design refinement
- [ ] Easter eggs implementation
- [ ] Documentation

### Phase 5: Launch Preparation (Week 5)
- [ ] Final testing across browsers
- [ ] Mobile testing
- [ ] SEO audit
- [ ] Deployment setup
- [ ] Analytics integration (privacy-focused)
- [ ] Monitoring setup
- [ ] Launch! 🎉

---

## 🌐 Hosting & Deployment

### Recommended Platforms

**Vercel** (Recommended)
- Excellent Astro support
- Edge functions
- Automatic HTTPS
- Preview deployments
- Zero config deployment

**Alternatives:**
- **Netlify** - Great DX, form handling, edge functions
- **Cloudflare Pages** - Fast global CDN, free tier

### CI/CD Pipeline
- Auto-deploy on push to main branch
- Preview deployments for pull requests
- Build-time checks:
  - TypeScript compilation
  - Accessibility linting
  - Link checking
  - Image optimization validation

### Domain & DNS
- Custom domain setup
- HTTPS enforcement
- www → non-www redirect (or vice versa)
- DNS configuration

---

## 📊 Analytics & Monitoring (Optional)

### Privacy-Focused Analytics
- **Plausible** - Simple, privacy-friendly
- **Fathom** - GDPR compliant
- **Umami** - Self-hosted option

**What to Track:**
- Page views
- Popular posts
- Referral sources
- Time on page
- NO personal data

### Error Monitoring
- **Sentry** - Error tracking
- Build failure notifications
- Uptime monitoring

---

## 🎭 Discordian Elements & Easter Eggs

### Visual Elements
- Sacred Chao (☯️ + 🍎) as favicon/logo option
- Golden Apple (Kallisti) awards
- Pentagon and pentagram motifs (Law of Fives)

### Content Features
- "Fnord" counter (hidden words visible on hover)
- Random Principia Discordia quotes
- 5/23 (Discordian New Year) special styling
- Chaos/Order balance indicators

### Interactive Surprises
- Konami code easter egg
- 23 enigma references
- Pope card generator
- Random "Hail Eris!" messages

### Law of Fives Implementation
- Maximum 5 tags per post
- Display exactly 5 related posts
- 5 recent posts on homepage
- Comment threads show 5 replies before "show more"

---

## 📚 Documentation

### For Content Authors
- Markdown syntax guide
- Frontmatter reference
- Image guidelines
- SEO best practices
- How to use MDX components

### For Developers
- Component API documentation
- Theming system guide
- Adding new features
- Deployment guide
- Troubleshooting

---

## 🔧 Maintenance & Updates

### Regular Tasks
- Update dependencies monthly
- Security patches as needed
- Content backups
- Performance monitoring
- Broken link checks

### Future Enhancements
- Newsletter integration
- Podcast RSS feed
- Dark mode manual toggle improvements
- Advanced search with filters
- Reading lists / bookmarks
- Author profiles (if multi-author)

---

## ✅ Success Criteria

### Technical
- ✅ All Lighthouse scores 95+
- ✅ WCAG 2.1 AA compliance
- ✅ Zero accessibility errors in automated tests
- ✅ Sub-2s page load times
- ✅ Mobile-responsive across devices

### User Experience
- ✅ Intuitive navigation
- ✅ Easy content discovery
- ✅ Engaging reading experience
- ✅ Active community via comments
- ✅ Unique Discordian personality

### Content
- ✅ Regular publishing schedule
- ✅ High-quality, well-researched articles
- ✅ Engaging with readers
- ✅ Building an audience

---

## 📞 Resources & References

### Astro Documentation
- [Astro Docs](https://docs.astro.build)
- [Content Collections](https://docs.astro.build/en/guides/content-collections/)
- [View Transitions](https://docs.astro.build/en/guides/view-transitions/)

### Accessibility
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM](https://webaim.org/)
- [A11y Project](https://www.a11yproject.com/)

### Performance
- [web.dev](https://web.dev/)
- [Core Web Vitals](https://web.dev/vitals/)

### Discordianism
- [Principia Discordia](http://www.principiadiscordia.com/)
- [The Law of Fives](https://discordia.fandom.com/wiki/Law_of_Fives)

---

**Last Updated:** 2025-11-16
**Project Status:** Planning Phase
**Next Milestone:** Phase 1 - Foundation

---

*"All statements are true in some sense, false in some sense, meaningless in some sense, true and false in some sense, true and meaningless in some sense, false and meaningless in some sense, and true and false and meaningless in some sense." - Principia Discordia*

**Hail Eris! All Hail Discordia! 🍎**
