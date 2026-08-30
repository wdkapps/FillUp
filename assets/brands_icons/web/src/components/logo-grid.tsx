"use client";

import React from "react";
import { motion } from "framer-motion";
import { useTheme } from "next-themes";
import * as Icons from "@cardog-icons/react";
import { allIcons, IconInfo } from "../lib/icons";
import {
  GridItemConfig,
  InfiniteGrid,
  InfiniteGridProps,
} from "./infinite-grid";

type IconComponent = React.ComponentType<{ width?: number; height?: number }>;

// One representative logo per brand, ordered deterministically so the spiral
// tiling looks intentional (no two identical brands clustered at the centre).
const categoryPriority: Record<string, number> = {
  Logo: 1,
  Icon: 2,
  LogoHorizontal: 3,
  Wordmark: 4,
};

function getBrandLogos(): IconInfo[] {
  const brandLogos = new Map<string, IconInfo>();

  allIcons
    .filter((icon) => icon.variant === "Default")
    .forEach((icon) => {
      const existing = brandLogos.get(icon.brand);
      if (
        !existing ||
        categoryPriority[icon.category] < categoryPriority[existing.category]
      ) {
        brandLogos.set(icon.brand, icon);
      }
    });

  // Deterministic shuffle (stable across renders / SSR) keyed on brand name.
  return Array.from(brandLogos.values()).sort((a, b) => {
    const hashA = a.brand
      .split("")
      .reduce((acc, char) => acc + char.charCodeAt(0), 0);
    const hashB = b.brand
      .split("")
      .reduce((acc, char) => acc + char.charCodeAt(0), 0);
    return ((hashA * 7) % 101) - ((hashB * 7) % 101);
  });
}

const BRAND_LOGOS = getBrandLogos();

function resolveComponent(logo: IconInfo, isDark: boolean): IconComponent | null {
  const darkName = `${logo.componentName}Dark`;
  const name = isDark && darkName in Icons ? darkName : logo.componentName;
  return (Icons[name as keyof typeof Icons] as IconComponent) ?? null;
}

interface LogoGridProps {
  /** Edge length of each grid cell in px. */
  gridSize?: number;
  className?: string;
  enableWheel?: InfiniteGridProps["enableWheel"];
}

export function LogoGrid({
  gridSize = 160,
  className,
  enableWheel = false,
}: LogoGridProps) {
  const { resolvedTheme } = useTheme();
  const isDark = resolvedTheme === "dark";
  // Avoid a hydration mismatch: render a stable (light) pass on the server and
  // first client paint, then swap in theme-correct variants once mounted.
  const [mounted, setMounted] = React.useState(false);
  React.useEffect(() => setMounted(true), []);

  // Generous whitespace per cell — flat, no borders or shadows on items.
  const logoSize = Math.round(gridSize * 0.4);

  const renderItem = React.useCallback(
    ({ gridIndex }: GridItemConfig) => {
      const logo = BRAND_LOGOS[gridIndex % BRAND_LOGOS.length];
      const Component = resolveComponent(logo, mounted && isDark);
      if (!Component) return null;

      return (
        <motion.div
          className="group absolute inset-0 flex items-center justify-center"
          initial={{ opacity: 0, scale: 0.5 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{
            duration: 0.4,
            scale: { type: "spring", visualDuration: 0.4, bounce: 0.4 },
          }}
        >
          <span
            title={logo.brand}
            className="pointer-events-none flex items-center justify-center opacity-65 transition-[opacity,transform] duration-300 group-hover:scale-110 group-hover:opacity-100"
          >
            <Component width={logoSize} height={logoSize} />
          </span>
        </motion.div>
      );
    },
    [isDark, mounted, logoSize],
  );

  return (
    <InfiniteGrid
      // Remount on theme flip so animated cells re-resolve cleanly.
      key={mounted && isDark ? "dark" : "light"}
      gridSize={gridSize}
      enableWheel={enableWheel}
      renderItem={renderItem}
      className={className}
    />
  );
}
