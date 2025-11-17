/**
 * Table of Contents utility
 * Extracts headings from markdown content
 */

export interface TocHeading {
  depth: number;
  slug: string;
  text: string;
}

/**
 * Generate table of contents from markdown headings
 * Supports h2 and h3 headings
 */
export function generateToc(content: string): TocHeading[] {
  const headings: TocHeading[] = [];

  // Match markdown headings (## and ###)
  const headingRegex = /^(#{2,3})\s+(.+)$/gm;
  let match;

  while ((match = headingRegex.exec(content)) !== null) {
    const level = match[1].length;
    const text = match[2].trim();

    // Generate slug (simple version)
    const slug = text
      .toLowerCase()
      .replace(/[^\w\s-]/g, '')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')
      .trim();

    headings.push({
      depth: level,
      slug,
      text,
    });
  }

  return headings;
}

/**
 * Check if content has enough headings for a TOC
 */
export function shouldShowToc(headings: TocHeading[]): boolean {
  // Show TOC if there are at least 3 headings
  return headings.length >= 3;
}
