import { Metadata } from "next";

export const metadata: Metadata = {
  title: "Updates | Cardog Icons",
  description: "Latest updates and changes to Cardog Icons",
};

type UpdateCategory = "feature" | "improvement" | "fix" | "announcement";

interface Update {
  id: string;
  version?: string;
  title: string;
  description: string;
  date: string;
  category: UpdateCategory;
  highlights?: string[];
}

const categoryStyles = {
  feature: {
    badge: "bg-skyblue-100 text-skyblue-700 dark:bg-skyblue-950 dark:text-skyblue-300",
  },
  improvement: {
    badge: "bg-emerald-100 text-emerald-700 dark:bg-emerald-950 dark:text-emerald-300",
  },
  fix: {
    badge: "bg-pink-100 text-pink-700 dark:bg-pink-950 dark:text-pink-300",
  },
  announcement: {
    badge: "bg-fuchsia-100 text-fuchsia-700 dark:bg-fuchsia-950 dark:text-fuchsia-300",
  },
} as const;

const updates: Update[] = [
  {
    id: "v1.2.0",
    version: "1.2.0",
    title: "React 19 Support & Size Props",
    description:
      "Full React 19 compatibility, new size prop for easy icon scaling, and a completely redesigned icons browser with cleaner UI inspired by SVGL.",
    date: "Mar 14, 2026",
    category: "feature",
    highlights: [
      "React 19 peer dependency support",
      "New `size` prop on all icon components",
      "Redesigned icons page with sidebar filters",
      "Per-icon mono/color toggle",
      "Improved code examples with syntax highlighting",
    ],
  },
  {
    id: "v1.1.0",
    version: "1.1.0",
    title: "Mono/Dark Icon Variants",
    description:
      "Every icon now comes with a mono variant optimized for dark backgrounds. Perfect for dark mode themes and monochrome designs.",
    date: "Mar 10, 2026",
    category: "feature",
    highlights: [
      "408 mono/dark icon variants",
      "Automatic currentColor inheritance",
      "Consistent naming with 'Dark' suffix",
      "Works great on dark backgrounds",
    ],
  },
  {
    id: "v1.0.0",
    version: "1.0.0",
    title: "Initial Release",
    description:
      "The first release of Cardog Icons featuring 40+ car brand logos in multiple formats: icon, logo, horizontal logo, and wordmark.",
    date: "Mar 1, 2026",
    category: "announcement",
    highlights: [
      "40+ car brand logos",
      "4 variants per brand (Icon, Logo, Horizontal, Wordmark)",
      "React and React Native packages",
      "TypeScript support",
      "Tree-shakeable exports",
    ],
  },
];

export default function UpdatesPage() {
  const latestUpdate = updates[0];

  return (
    <div className="min-h-screen bg-background">
      <div className="container py-12 max-w-3xl">
        {/* Header */}
        <div className="mb-12">
          <h1 className="text-4xl font-bold tracking-tight mb-4">Updates</h1>
          <p className="text-lg text-muted-foreground">
            Latest changes and improvements to Cardog Icons.
          </p>
        </div>

        {/* Timeline */}
        <div className="space-y-12">
          {updates.map((update, index) => (
            <article key={update.id} className="relative">
              {/* Version badge */}
              {update.version && (
                <div className="flex items-center gap-3 mb-4">
                  <span className="inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold bg-primary text-primary-foreground">
                    v{update.version}
                  </span>
                  <span
                    className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium capitalize ${categoryStyles[update.category].badge}`}
                  >
                    {update.category}
                  </span>
                  {index === 0 && (
                    <span className="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-amber-100 text-amber-800 dark:bg-amber-950 dark:text-amber-300">
                      Latest
                    </span>
                  )}
                </div>
              )}

              {/* Date */}
              <time className="text-sm text-muted-foreground mb-2 block">
                {update.date}
              </time>

              {/* Content */}
              <h2 className="text-2xl font-semibold mb-3">{update.title}</h2>
              <p className="text-muted-foreground mb-4">{update.description}</p>

              {/* Highlights */}
              {update.highlights && update.highlights.length > 0 && (
                <ul className="space-y-2">
                  {update.highlights.map((highlight, idx) => (
                    <li
                      key={idx}
                      className="flex items-start gap-2 text-sm text-muted-foreground"
                    >
                      <span className="text-primary mt-0.5">-</span>
                      <span>{highlight}</span>
                    </li>
                  ))}
                </ul>
              )}

              {/* Separator */}
              {index < updates.length - 1 && (
                <div className="mt-12 border-t border-border" />
              )}
            </article>
          ))}
        </div>
      </div>
    </div>
  );
}
