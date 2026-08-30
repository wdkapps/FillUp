"use client";

import React, { useState, useMemo } from "react";
import { Search, Copy, Download, Check, Moon, Sun } from "lucide-react";
import * as Icons from "@cardog-icons/react";
import { cn } from "../../lib/utils";
import {
  allIcons,
  allBrands,
  filterIcons,
  iconCounts,
  IconCategory,
  IconInfo,
} from "../../lib/icons";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "../../components/ui/popover";
import { saveAs } from "file-saver";

// Categories with counts
const categories: { id: IconCategory | "All"; label: string }[] = [
  { id: "All", label: "All" },
  { id: "Icon", label: "Icons" },
  { id: "Logo", label: "Logos" },
  { id: "LogoHorizontal", label: "Horizontal" },
  { id: "Wordmark", label: "Wordmarks" },
];

export default function IconsPage() {
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedBrand, setSelectedBrand] = useState<string | "All">("All");
  const [selectedCategory, setSelectedCategory] = useState<IconCategory | "All">("All");

  // Only show color variants in grid, mono available via toggle in card
  const filteredIcons = useMemo(() => {
    const colorOnly = allIcons.filter((icon) => icon.variant === "Default");
    return filterIcons(colorOnly, selectedBrand, selectedCategory, "Default", searchQuery);
  }, [searchQuery, selectedBrand, selectedCategory]);

  // Group brands with counts
  const brandCounts = useMemo(() => {
    const counts: Record<string, number> = {};
    allIcons
      .filter((icon) => icon.variant === "Default")
      .forEach((icon) => {
        counts[icon.brand] = (counts[icon.brand] || 0) + 1;
      });
    return counts;
  }, []);

  return (
    <div className="min-h-screen bg-background">
      {/* Search Header */}
      <div className="border-b border-border sticky top-16 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60 z-40">
        <div className="container py-4">
          <div className="relative max-w-xl">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
            <input
              type="text"
              placeholder="Search..."
              className="pl-10 h-10 w-full rounded-lg border border-input bg-background px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-ring"
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
            <kbd className="absolute right-3 top-1/2 -translate-y-1/2 pointer-events-none hidden sm:inline-flex h-5 select-none items-center gap-1 rounded border bg-muted px-1.5 font-mono text-[10px] font-medium text-muted-foreground">
              <span className="text-xs">⌘</span>K
            </kbd>
          </div>
        </div>
      </div>

      <div className="container py-6">
        <div className="flex gap-8">
          {/* Sidebar */}
          <aside className="hidden lg:block w-52 flex-shrink-0">
            <div className="sticky top-36 max-h-[calc(100vh-10rem)] overflow-y-auto pb-8 pr-2">
              {/* Type Filter */}
              <div className="mb-6">
                <h3 className="text-sm font-medium mb-3 text-muted-foreground">Type</h3>
                <div className="space-y-1">
                  {categories.map((cat) => (
                    <button
                      key={cat.id}
                      onClick={() => setSelectedCategory(cat.id)}
                      className={cn(
                        "w-full flex items-center justify-between px-3 py-2 text-sm rounded-lg transition-colors",
                        selectedCategory === cat.id
                          ? "bg-primary text-primary-foreground"
                          : "hover:bg-muted"
                      )}
                    >
                      <span>{cat.label}</span>
                    </button>
                  ))}
                </div>
              </div>

              {/* Brand Filter */}
              <div>
                <h3 className="text-sm font-medium mb-3 text-muted-foreground">Brand</h3>
                <div className="space-y-1">
                  <button
                    onClick={() => setSelectedBrand("All")}
                    className={cn(
                      "w-full flex items-center justify-between px-3 py-2 text-sm rounded-lg transition-colors",
                      selectedBrand === "All"
                        ? "bg-primary text-primary-foreground"
                        : "hover:bg-muted"
                    )}
                  >
                    <span>All Brands</span>
                    <span className={cn(
                      "text-xs",
                      selectedBrand === "All" ? "text-primary-foreground/70" : "text-muted-foreground"
                    )}>
                      {iconCounts.default}
                    </span>
                  </button>
                  {allBrands.map((brand) => (
                    <button
                      key={brand}
                      onClick={() => setSelectedBrand(brand)}
                      className={cn(
                        "w-full flex items-center justify-between px-3 py-2 text-sm rounded-lg transition-colors",
                        selectedBrand === brand
                          ? "bg-primary text-primary-foreground"
                          : "hover:bg-muted"
                      )}
                    >
                      <span>{brand}</span>
                      <span className={cn(
                        "text-xs",
                        selectedBrand === brand ? "text-primary-foreground/70" : "text-muted-foreground"
                      )}>
                        {brandCounts[brand] || 0}
                      </span>
                    </button>
                  ))}
                </div>
              </div>
            </div>
          </aside>

          {/* Main Content */}
          <main className="flex-1 min-w-0">
            {/* Results Header */}
            <div className="flex items-center justify-between mb-6">
              <div className="flex items-center gap-2 text-sm text-muted-foreground">
                <Copy className="h-4 w-4" />
                <span>{filteredIcons.length} logos</span>
              </div>
            </div>

            {/* Icons Grid */}
            {filteredIcons.length > 0 ? (
              <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
                {filteredIcons.map((icon) => (
                  <IconCard key={icon.id} icon={icon} />
                ))}
              </div>
            ) : (
              <div className="flex flex-col items-center justify-center py-20 text-center">
                <p className="text-muted-foreground mb-4">No icons found</p>
                <button
                  onClick={() => {
                    setSearchQuery("");
                    setSelectedBrand("All");
                    setSelectedCategory("All");
                  }}
                  className="text-sm text-primary hover:underline"
                >
                  Clear filters
                </button>
              </div>
            )}
          </main>
        </div>
      </div>
    </div>
  );
}

function IconCard({ icon }: { icon: IconInfo }) {
  const [showMono, setShowMono] = useState(false);
  const [copied, setCopied] = useState<string | null>(null);
  const svgRef = React.useRef<SVGSVGElement>(null);

  // Get both color and mono versions
  const colorName = icon.componentName;
  const monoName = icon.componentName + "Dark";

  const ColorIcon = Icons[colorName as keyof typeof Icons] as React.ComponentType<any>;
  const MonoIcon = Icons[monoName as keyof typeof Icons] as React.ComponentType<any>;

  const CurrentIcon = showMono && MonoIcon ? MonoIcon : ColorIcon;
  const currentName = showMono && MonoIcon ? monoName : colorName;

  const handleCopy = (type: string, content: string) => {
    navigator.clipboard.writeText(content);
    setCopied(type);
    setTimeout(() => setCopied(null), 2000);
  };

  const handleDownloadSVG = () => {
    if (!svgRef.current) return;
    const blob = new Blob([svgRef.current.outerHTML], { type: "image/svg+xml" });
    saveAs(blob, `${currentName}.svg`);
  };

  const importStatement = `import { ${currentName} } from '@cardog-icons/react';`;
  const reactUsage = `<${currentName} size={24} />`;

  return (
    <div className="group relative flex flex-col rounded-xl border border-border bg-card hover:border-primary/30 hover:shadow-sm transition-all">
      {/* Mono Toggle */}
      {MonoIcon && (
        <button
          onClick={() => setShowMono(!showMono)}
          className={cn(
            "absolute top-2 right-2 p-1.5 rounded-md transition-colors z-10",
            showMono
              ? "bg-charcoal-700 text-white"
              : "bg-muted text-muted-foreground hover:bg-muted/80"
          )}
          title={showMono ? "Show color" : "Show mono"}
        >
          {showMono ? <Sun className="h-3 w-3" /> : <Moon className="h-3 w-3" />}
        </button>
      )}

      {/* Icon Preview */}
      <div className={cn(
        "flex items-center justify-center p-8 rounded-t-xl transition-colors",
        showMono ? "bg-charcoal-900" : "bg-muted/30"
      )}>
        {CurrentIcon && <CurrentIcon width={56} height={56} ref={svgRef} />}
      </div>

      {/* Info */}
      <div className="p-4 pt-3">
        <h3 className="font-medium text-sm truncate">{icon.brand}</h3>
        <p className="text-xs text-muted-foreground mt-0.5">{icon.category}</p>
      </div>

      {/* Actions */}
      <div className="flex items-center gap-1 px-4 pb-4">
        <Popover>
          <PopoverTrigger asChild>
            <button
              className="p-2 rounded-md hover:bg-muted transition-colors"
              title="Copy"
            >
              {copied ? (
                <Check className="h-4 w-4 text-green-500" />
              ) : (
                <Copy className="h-4 w-4 text-muted-foreground" />
              )}
            </button>
          </PopoverTrigger>
          <PopoverContent className="w-80 p-3" align="start">
            <div className="space-y-3">
              <div className="flex items-center gap-2 text-xs text-muted-foreground">
                <span>Copy as</span>
              </div>
              <button
                onClick={() => {
                  if (svgRef.current) handleCopy("svg", svgRef.current.outerHTML);
                }}
                className="w-full flex items-center gap-2 px-3 py-2 text-sm rounded-md border border-border hover:bg-muted transition-colors"
              >
                <Copy className="h-4 w-4" />
                <span>Copy SVG</span>
                {copied === "svg" && <Check className="h-4 w-4 text-green-500 ml-auto" />}
              </button>
              <div className="space-y-2">
                <code className="block text-xs bg-muted p-2 rounded-md font-mono truncate">
                  {importStatement}
                </code>
                <button
                  onClick={() => handleCopy("import", importStatement)}
                  className="w-full text-xs text-primary hover:underline text-left"
                >
                  {copied === "import" ? "Copied!" : "Copy import"}
                </button>
              </div>
              <div className="space-y-2">
                <code className="block text-xs bg-muted p-2 rounded-md font-mono">
                  {reactUsage}
                </code>
                <button
                  onClick={() => handleCopy("react", reactUsage)}
                  className="w-full text-xs text-primary hover:underline text-left"
                >
                  {copied === "react" ? "Copied!" : "Copy usage"}
                </button>
              </div>
            </div>
          </PopoverContent>
        </Popover>

        <button
          onClick={handleDownloadSVG}
          className="p-2 rounded-md hover:bg-muted transition-colors"
          title="Download SVG"
        >
          <Download className="h-4 w-4 text-muted-foreground" />
        </button>
      </div>
    </div>
  );
}
