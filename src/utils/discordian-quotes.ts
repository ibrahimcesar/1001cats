/**
 * Discordian Quotes
 * Collection of quotes from the Principia Discordia and Discordian philosophy
 */

export interface DiscordianQuote {
  text: string;
  author: string;
  source?: string;
}

export const discordianQuotes: DiscordianQuote[] = [
  {
    text: 'All statements are true in some sense, false in some sense, meaningless in some sense, true and false in some sense, true and meaningless in some sense, false and meaningless in some sense, and true and false and meaningless in some sense.',
    author: 'Principia Discordia',
    source: 'Malaclypse the Younger',
  },
  {
    text: 'A Discordian is Prohibited of Believing what he reads.',
    author: 'Principia Discordia',
    source: 'The Fifth Commandment',
  },
  {
    text: 'It is my firm belief that it is a mistake to hold firm beliefs.',
    author: 'Principia Discordia',
  },
  {
    text: 'Convictions cause convicts.',
    author: 'Principia Discordia',
  },
  {
    text: 'The human race will begin solving its problems on the day that it ceases taking itself so seriously.',
    author: 'Principia Discordia',
    source: 'Malaclypse the Younger',
  },
  {
    text: 'We Discordians must stick apart.',
    author: 'Principia Discordia',
  },
  {
    text: 'Greater Popes have a purple crewcut.',
    author: 'Principia Discordia',
  },
  {
    text: 'If you can pick up a floor tile with your teeth, it is a sign of God.',
    author: 'Principia Discordia',
  },
  {
    text: 'Consult your pineal gland.',
    author: 'Principia Discordia',
    source: 'The Wholly Chao',
  },
  {
    text: 'The Goddess Eris is chief honcho up there, not the Dead Male God of Moses.',
    author: 'Principia Discordia',
  },
  {
    text: 'Nonsense is only nonsense because the perspective from which you view it doesn\'t allow it to make sense.',
    author: 'Discordian Saying',
  },
  {
    text: 'Every man, woman, and child on this Earth is a genuine and authorized Pope.',
    author: 'Principia Discordia',
    source: 'The Erisian Liberation Front',
  },
  {
    text: 'Everybody understands Mickey Mouse. Few understand Hermann Hesse. Hardly anybody understands Einstein. And nobody understands Emperor Norton.',
    author: 'Principia Discordia',
    source: 'Malaclypse the Younger',
  },
  {
    text: 'If you think the Principia is just a ha-ha, then go read it again.',
    author: 'Omar Khayyam Ravenhurst',
  },
  {
    text: 'Surrealism is a surreptitious religion of false belief, a belief in the omnipotence of man\'s dreams.',
    author: 'Principia Discordia',
  },
  {
    text: 'The world is a very narrow bridge. The important thing is not to be afraid.',
    author: 'Discordian Wisdom',
  },
  {
    text: 'To choose order over disorder, or disorder over order, is to accept a trip composed of both the creative and the destructive.',
    author: 'Principia Discordia',
  },
  {
    text: 'Reality is the original Rorschach.',
    author: 'Discordian Saying',
  },
  {
    text: 'Ain\'t no answer. Ain\'t gonna be any answer. Ain\'t ever been any answer. That\'s the answer.',
    author: 'Gertrude Stein',
    source: 'Quoted in Principia Discordia',
  },
  {
    text: 'Think for yourself, schmuck!',
    author: 'Principia Discordia',
  },
  {
    text: 'Hell, if you understand everything you say, you\'d be an asshole.',
    author: 'Robert Anton Wilson',
    source: 'Discordian Philosopher',
  },
  {
    text: 'The Law of Fives states that all things happen in fives, or are divisible by or are multiples of five, or are somehow directly or indirectly appropriate to 5.',
    author: 'Principia Discordia',
    source: 'The Law of Fives',
  },
  {
    text: 'Seek the Sacred Chao - therein you will find the foolishness of all order/disorder.',
    author: 'Principia Discordia',
  },
];

/**
 * Get a random Discordian quote
 */
export function getRandomQuote(): DiscordianQuote {
  const index = Math.floor(Math.random() * discordianQuotes.length);
  return discordianQuotes[index];
}

/**
 * Get multiple random quotes
 */
export function getRandomQuotes(count: number): DiscordianQuote[] {
  const shuffled = [...discordianQuotes].sort(() => Math.random() - 0.5);
  return shuffled.slice(0, count);
}

/**
 * Get a quote by searching for text (case-insensitive)
 */
export function findQuote(searchText: string): DiscordianQuote | undefined {
  const lowerSearch = searchText.toLowerCase();
  return discordianQuotes.find(
    (quote) =>
      quote.text.toLowerCase().includes(lowerSearch) ||
      quote.author.toLowerCase().includes(lowerSearch)
  );
}
