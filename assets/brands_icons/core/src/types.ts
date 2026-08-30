/**
 * Configuration for optimizing SVG files
 */
export interface OptimizeOptions {
  /** Precision for coordinate values */
  precision?: number;
  /** Whether to remove IDs from elements */
  removeIds?: boolean;
  /** Whether to optimize the SVG for smaller size */
  optimize?: boolean;
  /** Percentage values for width and height (e.g., "100%") */
  dimensionValues?: string;
  /** Whether to remove viewBox attribute */
  removeViewBox?: boolean;
}

/**
 * Icon metadata for processing
 */
export interface IconMetadata {
  /** Original name of the icon file */
  originalName: string;
  /** Processed component name in PascalCase */
  componentName: string;
  /** Path to the source file */
  sourcePath: string;
  /** Additional category or group */
  category?: string;
  /** Tags to help with searching */
  tags?: string[];
  /** Brand name if applicable */
  brand?: string;
  /** Type of logo (e.g., 'Logo', 'Icon', 'Wordmark') */
  logoType?: string;
}

/**
 * Known acronyms that should remain uppercase
 */
export const KNOWN_ACRONYMS = [
  "BMW",
  "RAM",
  "MB",
  "BYD",
  "GMC",
  "US",
  "UK",
  "EU",
];
