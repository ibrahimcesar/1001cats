/**
 * Time-Based Theme System
 * Detects the current time and returns the appropriate theme
 */

export type ThemeName = 'morning' | 'afternoon' | 'evening' | 'night';

export interface TimeTheme {
  name: ThemeName;
  label: string;
  icon: string;
  startHour: number;
  endHour: number;
  description: string;
}

/**
 * Theme definitions based on time of day
 */
export const TIME_THEMES: Record<ThemeName, TimeTheme> = {
  morning: {
    name: 'morning',
    label: 'Morning',
    icon: '🌅',
    startHour: 6,
    endHour: 12,
    description: 'Soft, warm pastels for a gentle awakening',
  },
  afternoon: {
    name: 'afternoon',
    label: 'Afternoon',
    icon: '☀️',
    startHour: 12,
    endHour: 18,
    description: 'Bright, energetic colors for peak productivity',
  },
  evening: {
    name: 'evening',
    label: 'Evening',
    icon: '🌆',
    startHour: 18,
    endHour: 22,
    description: 'Warm, muted tones for winding down',
  },
  night: {
    name: 'night',
    label: 'Night',
    icon: '🌙',
    startHour: 22,
    endHour: 6,
    description: 'Dark mode with cool accents for late-night reading',
  },
};

/**
 * Get the current theme based on the user's local time
 */
export function getCurrentTheme(): TimeTheme {
  const now = new Date();
  const hour = now.getHours();

  if (hour >= 6 && hour < 12) {
    return TIME_THEMES.morning;
  } else if (hour >= 12 && hour < 18) {
    return TIME_THEMES.afternoon;
  } else if (hour >= 18 && hour < 22) {
    return TIME_THEMES.evening;
  } else {
    return TIME_THEMES.night;
  }
}

/**
 * Get theme by name
 */
export function getThemeByName(name: ThemeName): TimeTheme {
  return TIME_THEMES[name];
}

/**
 * Get all available themes
 */
export function getAllThemes(): TimeTheme[] {
  return Object.values(TIME_THEMES);
}

/**
 * Check if a given hour falls within a theme's time range
 */
export function isHourInTheme(hour: number, theme: TimeTheme): boolean {
  if (theme.startHour < theme.endHour) {
    // Normal range (e.g., morning: 6-12)
    return hour >= theme.startHour && hour < theme.endHour;
  } else {
    // Wraps around midnight (e.g., night: 22-6)
    return hour >= theme.startHour || hour < theme.endHour;
  }
}

/**
 * Get the next theme transition time
 */
export function getNextThemeTransition(): { theme: TimeTheme; time: Date } {
  const now = new Date();
  const currentHour = now.getHours();
  const currentTheme = getCurrentTheme();

  // Calculate when the current theme ends
  let nextHour = currentTheme.endHour;
  const nextDate = new Date(now);

  if (nextHour <= currentHour) {
    // Next theme starts tomorrow
    nextDate.setDate(nextDate.getDate() + 1);
  }

  nextDate.setHours(nextHour, 0, 0, 0);

  // Find which theme comes next
  const allThemes = getAllThemes();
  const nextTheme = allThemes.find(theme =>
    isHourInTheme(nextHour, theme)
  ) || currentTheme;

  return {
    theme: nextTheme,
    time: nextDate,
  };
}
