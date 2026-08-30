"use client";

import Link from "next/link";
import { Search, Menu, X } from "lucide-react";
import { ModeToggle } from "./mode-toggle";
import { useState } from "react";
import { cn } from "../lib/utils";
import { Logo, Logomark } from "./logo";

const navItems = [
  { name: "Home", href: "/" },
  { name: "Icons", href: "/icons" },
  { name: "Docs", href: "/docs" },
  { name: "Updates", href: "/updates" },
];

export function Navbar() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
      <div className="container flex h-16 items-center">
        <div className="mr-4 flex">
          <Link href="/" className="flex items-center space-x-2">
            <span className="font-bold text-xl">
              <Logomark className="h-8 w-auto" />
            </span>
            <X className="h-4 w-4" />
            <span className="text-xl font-normal">Icons</span>
          </Link>
        </div>
        <div className="flex flex-1 items-center justify-end space-x-2 md:justify-end">
          <nav className="hidden md:flex items-center space-x-6 text-sm font-medium">
            {navItems.map((item) => (
              <Link
                key={item.href}
                href={item.href}
                className="transition-colors hover:text-foreground/80 text-foreground/60"
              >
                {item.name}
              </Link>
            ))}
          </nav>
          <div className="flex items-center space-x-1">
            <Link
              href="/icons?searchFocus=true"
              className="group p-2 rounded-md hover:bg-accent hover:text-accent-foreground"
              aria-label="Search icons"
            >
              <Search className="h-5 w-5" />
              <span className="sr-only">Search icons</span>
            </Link>
            <ModeToggle />
            <button
              className="p-2 rounded-md hover:bg-accent hover:text-accent-foreground md:hidden"
              onClick={() => setIsMenuOpen(!isMenuOpen)}
            >
              <Menu className="h-5 w-5" />
              <span className="sr-only">Toggle menu</span>
            </button>
          </div>
        </div>
      </div>
      {/* Mobile menu */}
      <div
        className={cn(
          "md:hidden absolute w-full bg-background border-b",
          isMenuOpen ? "block" : "hidden"
        )}
      >
        <nav className="container py-4">
          <ul className="grid gap-3">
            {navItems.map((item) => (
              <li key={item.href}>
                <Link
                  href={item.href}
                  className="block px-2 py-1 text-lg font-medium"
                  onClick={() => setIsMenuOpen(false)}
                >
                  {item.name}
                </Link>
              </li>
            ))}
          </ul>
        </nav>
      </div>
    </header>
  );
}
