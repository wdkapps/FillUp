import React from "react";
import { LogoGrid } from "../components/logo-grid";
import { PackageShowcase } from "../components/package-showcase";
import { iconCounts } from "../lib/icons";

export default function Home() {
  return (
    <div className="flex flex-col">
      {/* Hero — fully flat, immersive infinite logo grid */}
      <section className="relative h-[calc(100svh-4rem)] min-h-[520px] w-full overflow-hidden bg-background">
        {/* Draggable grid fills the entire viewport, edge to edge */}
        <LogoGrid gridSize={160} />

        {/* Minimal flat corner caption — no shadow, no blur, just a label */}
        <div className="pointer-events-none absolute inset-x-0 bottom-0 z-10 flex justify-start p-5 md:p-8">
          <div className="pointer-events-auto max-w-sm rounded-2xl bg-background/95 p-5 md:p-6">
            <h1 className="text-2xl font-semibold tracking-tight md:text-3xl">
              Car logos, simplified
            </h1>
            <p className="mt-2 text-sm text-muted-foreground">
              Every car brand, standardized · {iconCounts.brands} brands ·
              mono &amp; dark. Drag anywhere to explore.
            </p>
            <div className="mt-4 flex items-center gap-5 text-sm">
              <a
                href="/icons"
                className="inline-flex items-center gap-1.5 font-medium text-foreground underline-offset-4 hover:underline"
              >
                Browse {iconCounts.total} icons
                <ArrowRightIcon className="h-3.5 w-3.5" />
              </a>
              <a
                href="/docs"
                className="text-muted-foreground transition-colors hover:text-foreground"
              >
                Docs
              </a>
            </div>
          </div>
        </div>
      </section>

      {/* Installation */}
      <section className="border-t border-border py-20 md:py-28">
        <div className="container">
          <div className="mx-auto max-w-2xl text-center">
            <span className="text-sm font-medium text-muted-foreground">
              Installation
            </span>
            <h2 className="mt-3 text-3xl font-semibold tracking-tight md:text-4xl">
              Drop it into any stack
            </h2>
            <p className="mt-4 text-base text-muted-foreground">
              One source of truth for every car brand mark — shipped for React,
              React Native, and plain SVG. Fully typed, fully tree-shakeable.
            </p>
          </div>

          <div className="mt-14">
            <PackageShowcase />
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="border-t border-border py-20 md:py-28">
        <div className="container">
          <div className="mx-auto flex max-w-3xl flex-col items-center rounded-3xl border border-border bg-card px-6 py-14 text-center md:px-12">
            <h2 className="text-3xl font-semibold tracking-tight md:text-4xl">
              Ready to get started?
            </h2>
            <p className="mt-4 max-w-xl text-base text-muted-foreground md:text-lg">
              Read the docs to wire Cardog Icons into your project in a couple of
              lines — or jump straight into the full collection.
            </p>
            <div className="mt-8 flex flex-wrap items-center justify-center gap-3">
              <a
                href="/docs"
                className="inline-flex items-center gap-2 rounded-full bg-primary px-6 py-3 text-sm font-medium text-primary-foreground transition-colors hover:bg-primary/90"
              >
                View documentation
                <ArrowRightIcon className="h-4 w-4" />
              </a>
              <a
                href="/icons"
                className="rounded-full border border-input bg-background px-6 py-3 text-sm font-medium transition-colors hover:bg-accent hover:text-accent-foreground"
              >
                Browse all icons
              </a>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}

function ArrowRightIcon({ className = "h-4 w-4" }: { className?: string }) {
  return (
    <svg
      className={className}
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
    >
      <path d="M5 12h14" />
      <path d="m12 5 7 7-7 7" />
    </svg>
  );
}
