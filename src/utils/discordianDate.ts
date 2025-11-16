import { toDiscordian, format as formatDiscordian } from 'discordian-date-converter';

/**
 * Format a date in Discordian calendar with Gregorian date in small text
 * @param date - The date to format (Date object or ISO string)
 * @returns Object with Discordian and Gregorian formatted strings
 */
export function formatDiscordianDate(date: Date | string): {
  discordian: string;
  gregorian: string;
} {
  const dateObj = typeof date === 'string' ? new Date(date) : date;

  // Convert to Discordian
  const discDate = toDiscordian(dateObj);
  const discordianStr = formatDiscordian(discDate);

  // Format Gregorian as YYYY-MM-DD
  const year = dateObj.getFullYear();
  const month = String(dateObj.getMonth() + 1).padStart(2, '0');
  const day = String(dateObj.getDate()).padStart(2, '0');
  const gregorianStr = `${year}-${month}-${day}`;

  return {
    discordian: discordianStr,
    gregorian: gregorianStr,
  };
}
