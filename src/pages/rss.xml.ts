import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import type { APIContext } from 'astro';

export async function GET(context: APIContext) {
  const posts = await getCollection('blog', ({ data }) => {
    return data.draft !== true;
  });

  const sortedPosts = posts.sort(
    (a, b) => b.data.pubDate.valueOf() - a.data.pubDate.valueOf()
  );

  return rss({
    title: '1001 Schrödinger\'s Cats',
    description: 'A Discordian blog on science, philosophy, life, the universe, and everything',
    site: context.site || 'https://1001cats.com',
    items: sortedPosts.map((post) => ({
      title: post.data.title,
      description: post.data.description,
      pubDate: post.data.pubDate,
      link: `/blog/${post.slug}/`,
      author: post.data.author,
      categories: [post.data.category, ...(post.data.tags || [])],
      customData: post.data.updatedDate
        ? `<lastBuildDate>${post.data.updatedDate.toUTCString()}</lastBuildDate>`
        : undefined,
    })),
    customData: `<language>en-us</language>
<copyright>All wrongs reserved</copyright>
<webMaster>1001cats</webMaster>
<generator>Astro</generator>
<docs>https://www.rssboard.org/rss-specification</docs>`,
  });
}
