/**
 * Calculate estimated reading time for blog posts
 * Based on average reading speed of 200-250 words per minute
 */

const WORDS_PER_MINUTE = 225;

export interface ReadingTimeResult {
  text: string;
  minutes: number;
  words: number;
}

/**
 * Calculate reading time from text content
 */
export function getReadingTime(content: string): ReadingTimeResult {
  // Remove HTML tags and extra whitespace
  const cleanContent = content
    .replace(/<[^>]*>/g, '')
    .replace(/\s+/g, ' ')
    .trim();

  // Count words
  const words = cleanContent.split(/\s+/).length;

  // Calculate minutes (round up)
  const minutes = Math.ceil(words / WORDS_PER_MINUTE);

  // Generate human-readable text
  const text = minutes === 1 ? '1 min read' : `${minutes} min read`;

  return {
    text,
    minutes,
    words,
  };
}
