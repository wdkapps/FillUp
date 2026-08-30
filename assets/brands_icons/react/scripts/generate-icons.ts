import fs from "fs";
import path from "path";
import { transform } from "@svgr/core";
import * as core from "@cardog-icons/core";
import { componentTemplate } from "./templates/component";

// Configuration
const OPTIMIZED_DIR = path.resolve(__dirname, "../../core/optimized");
const OUTPUT_COMPONENTS_DIR = path.resolve(__dirname, "../src/components");
const OUTPUT_INDEX_PATH = path.resolve(OUTPUT_COMPONENTS_DIR, "index.ts");
const OUTPUT_TYPES_PATH = path.resolve(__dirname, "../src/types.ts");

/**
 * Transforms an SVG file to a React component
 *
 * @param svgContent - The SVG content to transform
 * @param componentName - The name of the component
 * @returns The React component code
 */
async function transformSvgToReactComponent(
  svgContent: string,
  componentName: string
): Promise<string> {
  const jsCode = await transform(
    svgContent,
    {
      plugins: ["@svgr/plugin-svgo", "@svgr/plugin-jsx"],
      icon: true,
      ref: true,
      typescript: true,
      memo: false,
      titleProp: false,
      descProp: false,
      svgoConfig: {
        plugins: [
          {
            name: "prefixIds",
            params: {
              prefix: componentName.toLowerCase(),
            },
          },
        ],
      },
    },
    { componentName }
  );

  // Replace the transformed component with our custom template
  const svgContentMatch = jsCode.match(/<svg[^>]*>([\s\S]*?)<\/svg>/);

  if (!svgContentMatch) {
    throw new Error(`Could not extract SVG content for ${componentName}`);
  }

  // Extract the SVG content (without the outer <svg> tag)
  let svgInnerContent = svgContentMatch[0];

  // Inject sizeProps spread before props spread for size prop support
  svgInnerContent = svgInnerContent.replace(
    /(\{\.\.\.props\})/,
    '{...sizeProps} $1'
  );

  // Replace the template variables
  return componentTemplate
    .replace(/\{\{componentName\}\}/g, componentName)
    .replace(/\{\{svgContent\}\}/g, svgInnerContent);
}

/**
 * Writes the index file that exports all components
 *
 * @param componentNames - Array of component names to export
 */
function writeIndexFile(componentNames: string[]): void {
  // Create the exports
  const exports = componentNames
    .map((name) => `export { default as ${name} } from './${name}';`)
    .join("\n");

  // Create the index file content
  const content = `// This file is auto-generated. Do not edit manually.
// Generated on ${new Date().toISOString()}

// Icon components
${exports}

// Export the main Icon component
export { default as Icon } from './Icon';
`;

  // Write the index file
  fs.writeFileSync(OUTPUT_INDEX_PATH, content);
  console.log(
    `✓ Generated index file with ${componentNames.length} icon exports`
  );
}

/**
 * Writes the types file with the IconName type
 *
 * @param componentNames - Array of component names
 */
function writeTypesFile(componentNames: string[]): void {
  // Create the IconName type as a union of string literals
  const iconNameType =
    componentNames.length > 0
      ? componentNames.map((name) => `  | '${name}'`).join("\n")
      : "  | string";

  // Get the current content of the types file
  const existingContent = fs.readFileSync(OUTPUT_TYPES_PATH, "utf8");

  // Replace the IconName type definition while preserving other types
  const updatedContent = existingContent.replace(
    /export type IconName = [^;]*;/,
    `export type IconName =\n${iconNameType};`
  );

  // Write the updated types file
  fs.writeFileSync(OUTPUT_TYPES_PATH, updatedContent);
  console.log(
    `✓ Updated IconName type with ${componentNames.length} icon names`
  );
}

/**
 * Main function to generate React components from SVG files
 */
async function generateReactComponents(): Promise<void> {
  try {
    // Create the output directories if they don't exist
    core.ensureDirectoryExists(OUTPUT_COMPONENTS_DIR);

    // Read the optimized SVG files
    console.log(`Looking for SVG files in ${OPTIMIZED_DIR}...`);
    if (!fs.existsSync(OPTIMIZED_DIR)) {
      console.error(`❌ Optimized directory does not exist: ${OPTIMIZED_DIR}`);
      return;
    }

    const svgFiles = fs
      .readdirSync(OPTIMIZED_DIR)
      .filter((file) => file.endsWith(".svg"))
      .map((file) => path.join(OPTIMIZED_DIR, file));

    console.log(`Found ${svgFiles.length} SVG files to process`);

    // Process each SVG file
    const componentNames: string[] = [];

    for (const svgFile of svgFiles) {
      // Generate component name from filename
      const basename = core.getBasename(svgFile);
      const componentName = core.toPascalCase(basename);
      componentNames.push(componentName);

      // Read SVG content
      const svgContent = fs.readFileSync(svgFile, "utf8");

      // Transform to React component
      const componentCode = await transformSvgToReactComponent(
        svgContent,
        componentName
      );

      // Write the component file
      const outputPath = path.join(
        OUTPUT_COMPONENTS_DIR,
        `${componentName}.tsx`
      );
      fs.writeFileSync(outputPath, componentCode);

      console.log(`✓ Generated component: ${componentName}`);
    }

    // Generate the index file
    writeIndexFile(componentNames);

    // Update the types file
    writeTypesFile(componentNames);

    console.log("✅ All React components generated successfully!");
  } catch (error) {
    console.error("❌ Error generating React components:", error);
  }
}

// Run the generation function
generateReactComponents();
