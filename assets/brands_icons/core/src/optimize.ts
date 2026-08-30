import fs from "fs";
import path from "path";
import { optimize as svgoOptimize, Config as SvgoConfig, Config } from "svgo";
import { OptimizeOptions } from "./types";
import { ensureDirectoryExists } from "./utils";

/**
 * Default optimization options
 */
const defaultOptions: Config = {
  floatPrecision: 2,
  plugins: ["preset-default"],
  multipass: true,
};

/**
 * Optimizes an SVG file and saves the result to the output directory
 *
 * @param inputPath - Path to the input SVG file
 * @param outputPath - Path to save the optimized SVG
 * @param options - Optimization options
 * @returns The optimized SVG string
 */
export async function optimizeSvg(
  inputPath: string,
  outputPath: string,
  options: OptimizeOptions = {}
): Promise<string> {
  // Merge with default options
  const mergedOptions = { ...defaultOptions, ...options };

  // Create the output directory if it doesn't exist
  ensureDirectoryExists(path.dirname(outputPath));

  // Read the SVG file
  const svgContent = fs.readFileSync(inputPath, "utf8");

  // Only optimize if enabled
  if (!mergedOptions.optimize) {
    fs.writeFileSync(outputPath, svgContent);
    return svgContent;
  }

  try {
    // Simplest SVGO configuration
    const svgoConfig: SvgoConfig = {
      multipass: true,
      plugins: ["preset-default", "removeDimensions"],
    };

    // Optimize the SVG
    const result = svgoOptimize(svgContent, svgoConfig);

    // Write the optimized SVG to the output path
    fs.writeFileSync(outputPath, result.data);

    return result.data;
  } catch (error) {
    console.error(`Error optimizing SVG ${inputPath}:`, error);
    // Fallback to using the original content
    fs.writeFileSync(outputPath, svgContent);
    return svgContent;
  }
}

/**
 * Optimizes all SVG files in a directory and saves the results to an output directory
 *
 * @param inputDir - Directory containing SVG files
 * @param outputDir - Directory to save optimized SVGs
 * @param options - Optimization options
 * @returns A promise that resolves when all files are optimized
 */
export async function optimizeDirectory(
  inputDir: string,
  outputDir: string,
  options: OptimizeOptions = {}
): Promise<void> {
  // Create the output directory if it doesn't exist
  ensureDirectoryExists(outputDir);

  // Get all SVG files in the input directory
  const files = fs.readdirSync(inputDir);

  // Process each SVG file
  for (const file of files) {
    if (file.endsWith(".svg")) {
      const inputPath = path.join(inputDir, file);
      const outputPath = path.join(outputDir, file);

      // Optimize the SVG
      await optimizeSvg(inputPath, outputPath, options);
    }
  }
}

/**
 * Batch optimizes SVG files in parallel
 *
 * @param filePaths - Array of file paths to optimize
 * @param outputDir - Directory to save optimized SVGs
 * @param options - Optimization options
 * @param batchSize - Number of files to process in parallel (default: 10)
 * @returns A promise that resolves when all files are optimized
 */
export async function batchOptimizeSvgs(
  filePaths: string[],
  outputDir: string,
  options: OptimizeOptions = {},
  batchSize: number = 10
): Promise<void> {
  // Create the output directory if it doesn't exist
  ensureDirectoryExists(outputDir);

  console.log(
    `Processing ${filePaths.length} SVG files in batches of ${batchSize}...`
  );

  // Process files in batches
  for (let i = 0; i < filePaths.length; i += batchSize) {
    const batch = filePaths.slice(i, i + batchSize);
    console.log(
      `Processing batch ${Math.floor(i / batchSize) + 1}/${Math.ceil(filePaths.length / batchSize)}...`
    );

    // Process batch in parallel
    await Promise.all(
      batch.map(async (filePath) => {
        const fileName = path.basename(filePath);
        const outputPath = path.join(outputDir, fileName);

        await optimizeSvg(filePath, outputPath, options);
        console.log(`Optimized: ${fileName}`);
      })
    );
  }
}
