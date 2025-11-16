import { defineCollection, z } from 'astro:content';

/**
 * Blog post schema with validation
 * Enforces required fields and formats
 */
const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string().max(100, 'Title must be 100 characters or less'),
    description: z.string().max(200, 'Description must be 200 characters or less'),
    pubDate: z.coerce.date(),
    updatedDate: z.coerce.date().optional(),
    author: z.string().default('1001cats'),

    // Tags: Maximum 5 (Law of Fives!)
    tags: z.array(z.string()).max(5, 'Maximum 5 tags allowed (Law of Fives!)'),

    // Category
    category: z.enum([
      'science',
      'philosophy',
      'technology',
      'discordianism',
      'life',
      'universe',
      'everything',
    ]),

    // Featured image
    image: z.object({
      url: z.string(),
      alt: z.string(), // Required for accessibility
    }).optional(),

    // Series support
    series: z.string().optional(),
    seriesOrder: z.number().int().positive().optional(),

    // Draft status
    draft: z.boolean().default(false),

    // Featured post flag
    featured: z.boolean().default(false),
  }),
});

export const collections = {
  blog,
};
