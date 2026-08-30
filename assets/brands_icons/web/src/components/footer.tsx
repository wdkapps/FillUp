"use client";

import Link from "next/link";
import { Github } from "lucide-react";

export function Footer() {
  return (
    <footer className="w-full border-t bg-background py-6">
      <div className="container flex flex-col items-center justify-between gap-4 md:flex-row">
        <p className="text-sm text-muted-foreground">
          &copy; {new Date().getFullYear()} Cardog Icons. All rights belong to
          their respective owners.
        </p>
        <div className="flex items-center gap-4">
          <Link
            href="https://github.com/cardog-ai/icons"
            target="_blank"
            rel="noopener noreferrer"
            className="text-muted-foreground hover:text-foreground"
          >
            <Github size={20} />
            <span className="sr-only">GitHub</span>
          </Link>
          <nav className="flex gap-4 text-sm">
            <Link
              href="/docs"
              className="text-muted-foreground hover:text-foreground"
            >
              Documentation
            </Link>
            <Link
              href="https://github.com/cardog-ai/icons/blob/master/core/LICENSE"
              className="text-muted-foreground hover:text-foreground"
            >
              License
            </Link>
            <Link
              href="/packages"
              className="text-muted-foreground hover:text-foreground"
            >
              Packages
            </Link>
            <Link
              href="https://github.com/cardog-ai/icons/issues"
              className="text-muted-foreground hover:text-foreground"
            >
              Issues
            </Link>
          </nav>
        </div>
      </div>
    </footer>
  );
}
