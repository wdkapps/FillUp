# @cardog-icons/core

Core functionality for SVG optimization and processing in the Cardog Icons library.

## Features

- SVG optimization using SVGO
- Utilities for batch processing SVG files
- Handling of brand names and acronyms
- PascalCase conversion for component names

## Installation

```bash
npm install @cardog-icons/core
# or
yarn add @cardog-icons/core
# or
pnpm add @cardog-icons/core
```

## Usage

### Optimizing SVGs

```typescript
import { optimizeSvg, batchOptimizeSvgs } from "@cardog-icons/core";
import path from "path";

// Optimize a single SVG
await optimizeSvg("./path/to/input.svg", "./path/to/output.svg", {
  precision: 2,
  removeIds: true,
});

// Batch optimize multiple SVGs
const svgFiles = ["file1.svg", "file2.svg", "file3.svg"].map((file) =>
  path.resolve("./path/to/svgs", file)
);

await batchOptimizeSvgs(
  svgFiles,
  "./path/to/output",
  { precision: 2 },
  10 // batch size
);
```

### Utility Functions

```typescript
import {
  toPascalCase,
  processBrandName,
  findSvgFiles,
  ensureDirectoryExists,
} from "@cardog-icons/core";

// Convert a filename to PascalCase
const componentName = toPascalCase("bmw_logo");
// Result: "BMWLogo"

// Process a brand name (preserving acronyms)
const brandName = processBrandName("BMW Group");
// Result: "BMWGroup"

// Find all SVG files in a directory
const svgFiles = await findSvgFiles("./path/to/svgs");

// Ensure a directory exists
ensureDirectoryExists("./path/to/output");
```

## License

MIT © Cardog
