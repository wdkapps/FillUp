"use client";

import React from "react";

type Pkg = {
  badge: string;
  name: string;
  description: string;
  install: string;
  lang: string;
  code: string;
  href: string;
};

const PACKAGES: Pkg[] = [
  {
    badge: "React 19+",
    name: "@cardog-icons/react",
    description: "Tree-shakeable React components with full TypeScript support.",
    install: "npm i @cardog-icons/react",
    lang: "tsx",
    code: `import { BMWLogo, TeslaIcon } from '@cardog-icons/react';

<BMWLogo size={48} />
<TeslaIcon className="text-red-500" />`,
    href: "https://www.npmjs.com/package/@cardog-icons/react",
  },
  {
    badge: "Expo · RN 0.60+",
    name: "@cardog-icons/react-native",
    description: "Native SVG components powered by react-native-svg.",
    install: "npm i @cardog-icons/react-native",
    lang: "tsx",
    code: `import { AudiLogo } from '@cardog-icons/react-native';

<AudiLogo width={64} height={64} />`,
    href: "https://www.npmjs.com/package/@cardog-icons/react-native",
  },
  {
    badge: "Raw SVGs",
    name: "@cardog-icons/core",
    description: "Optimized SVG files for any framework or vanilla project.",
    install: "npm i @cardog-icons/core",
    lang: "ts",
    code: `import { icons } from '@cardog-icons/core';

const svg = icons['bmw-logo'];
document.body.innerHTML = svg;`,
    href: "https://www.npmjs.com/package/@cardog-icons/core",
  },
];

// Minimal, correctness-first tokenizer. Only colours things it can match
// unambiguously — strings, line comments and a small keyword set — and leaves
// everything else untouched, so snippets are never mangled.
const TOKEN =
  /(\/\/[^\n]*)|('[^']*'|"[^"]*"|`[^`]*`)|\b(import|from|const|let|export|default|return)\b/g;

function highlight(code: string): React.ReactNode[] {
  const nodes: React.ReactNode[] = [];
  let last = 0;
  let match: RegExpExecArray | null;
  let key = 0;

  TOKEN.lastIndex = 0;
  while ((match = TOKEN.exec(code)) !== null) {
    if (match.index > last) {
      nodes.push(code.slice(last, match.index));
    }
    const [text, comment, str, keyword] = match;
    if (comment) {
      nodes.push(
        <span key={key++} className="text-charcoal-400">
          {comment}
        </span>,
      );
    } else if (str) {
      nodes.push(
        <span key={key++} className="text-emerald-300">
          {str}
        </span>,
      );
    } else if (keyword) {
      nodes.push(
        <span key={key++} className="text-violet-300">
          {keyword}
        </span>,
      );
    } else {
      nodes.push(text);
    }
    last = match.index + text.length;
  }
  if (last < code.length) nodes.push(code.slice(last));
  return nodes;
}

function CopyButton({ value, label }: { value: string; label: string }) {
  const [copied, setCopied] = React.useState(false);

  const onCopy = React.useCallback(async () => {
    try {
      await navigator.clipboard.writeText(value);
      setCopied(true);
      window.setTimeout(() => setCopied(false), 1600);
    } catch {
      /* clipboard unavailable — no-op */
    }
  }, [value]);

  return (
    <button
      type="button"
      onClick={onCopy}
      aria-label={label}
      className="flex h-7 w-7 shrink-0 items-center justify-center rounded-md text-charcoal-400 transition-colors hover:bg-white/10 hover:text-taupe-100"
    >
      {copied ? <CheckIcon /> : <CopyIcon />}
    </button>
  );
}

function PackageCard({ pkg }: { pkg: Pkg }) {
  return (
    <div className="flex h-full flex-col rounded-2xl border border-border bg-card p-6 transition-colors hover:border-foreground/20">
      <div className="flex items-center justify-between">
        <span className="rounded-full border border-border bg-background px-2.5 py-0.5 text-xs font-medium text-muted-foreground">
          {pkg.badge}
        </span>
        <a
          href={pkg.href}
          target="_blank"
          rel="noreferrer noopener"
          className="inline-flex items-center gap-1 text-xs font-medium text-muted-foreground transition-colors hover:text-foreground"
        >
          npm
          <ArrowUpRightIcon />
        </a>
      </div>

      <h3 className="mt-4 font-mono text-[15px] font-semibold text-foreground">
        {pkg.name}
      </h3>
      <p className="mt-2 text-sm leading-relaxed text-muted-foreground">
        {pkg.description}
      </p>

      {/* Install command */}
      <div className="mt-5 flex items-center gap-2 rounded-lg border border-border bg-charcoal-900 py-1.5 pl-3 pr-1.5 font-mono text-xs">
        <span className="select-none text-emerald-400">$</span>
        <span className="flex-1 overflow-x-auto whitespace-nowrap text-taupe-200 [scrollbar-width:none] [&::-webkit-scrollbar]:hidden">
          {pkg.install}
        </span>
        <CopyButton value={pkg.install} label={`Copy install command for ${pkg.name}`} />
      </div>

      {/* Code window */}
      <div className="mt-3 flex flex-1 flex-col overflow-hidden rounded-lg border border-border bg-charcoal-900">
        <div className="flex items-center justify-between border-b border-white/5 px-3 py-1.5">
          <span className="font-mono text-[11px] uppercase tracking-wider text-charcoal-400">
            {pkg.lang}
          </span>
          <CopyButton value={pkg.code} label={`Copy example for ${pkg.name}`} />
        </div>
        <div className="relative flex-1">
          <pre className="h-full overflow-x-auto p-3 pr-8 font-mono text-xs leading-relaxed text-taupe-200 [scrollbar-width:none] [&::-webkit-scrollbar]:hidden">
            <code>{highlight(pkg.code)}</code>
          </pre>
          {/* Fade long lines into the edge so horizontal scroll reads cleanly */}
          <div className="pointer-events-none absolute inset-y-0 right-0 w-8 bg-gradient-to-l from-charcoal-900 to-transparent" />
        </div>
      </div>
    </div>
  );
}

export function PackageShowcase() {
  return (
    <div className="grid grid-cols-1 items-stretch gap-6 md:grid-cols-3">
      {PACKAGES.map((pkg) => (
        <PackageCard key={pkg.name} pkg={pkg} />
      ))}
    </div>
  );
}

function CopyIcon() {
  return (
    <svg
      className="h-3.5 w-3.5"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <rect width="14" height="14" x="8" y="8" rx="2" ry="2" />
      <path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2" />
    </svg>
  );
}

function CheckIcon() {
  return (
    <svg
      className="h-3.5 w-3.5 text-emerald-400"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2.5"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M20 6 9 17l-5-5" />
    </svg>
  );
}

function ArrowUpRightIcon() {
  return (
    <svg
      className="h-3 w-3"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M7 7h10v10" />
      <path d="M7 17 17 7" />
    </svg>
  );
}
