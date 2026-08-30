import fs from "fs";
import path from "path";
import {
  findSvgFiles,
  cleanDirectory,
  ensureDirectoryExists,
} from "../src/utils";
import { batchOptimizeSvgs } from "../src/optimize";

// Configuration
const SOURCE_DIR = process.argv[2] || path.resolve(__dirname, "../raw");
const OPTIMIZE_DIR = path.resolve(__dirname, "../optimized");
const BATCH_SIZE = 10;

/**
 * Main function to optimize SVG files
 */
async function main() {
  try {
    console.log(`Looking for SVG files in: ${SOURCE_DIR}`);

    // Ensure output directory exists and is clean
    ensureDirectoryExists(OPTIMIZE_DIR);
    cleanDirectory(OPTIMIZE_DIR);

    // Find all SVG files in the source directory
    const svgFiles = await findSvgFiles(SOURCE_DIR);
    console.log(`Found ${svgFiles.length} SVG files to process`);

    if (svgFiles.length === 0) {
      console.log("No SVG files found. Exiting.");
      return;
    }

    // Process SVG files in batches
    console.log("Optimizing SVG files...");
    console.time("Optimization completed in");

    await batchOptimizeSvgs(
      svgFiles,
      OPTIMIZE_DIR,
      {
        precision: 2,
        removeIds: true,
      },
      BATCH_SIZE
    );

    console.timeEnd("Optimization completed in");
    console.log(
      `✅ Optimized ${svgFiles.length} SVG files to: ${OPTIMIZE_DIR}`
    );
  } catch (error) {
    console.error("❌ Error optimizing SVG files:", error);
    process.exit(1);
  }
}

// Run the main function
main();
