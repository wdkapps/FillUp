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

// Define types for SVGR template parameters
interface SvgrTemplateParams {
  imports: string[];
  interfaces: string[];
  componentName: string;
  props: string[];
  jsx: {
    type: string;
    props: Record<string, any>;
    children: string;
  };
  exports: string[];
}

interface SvgrTemplateContext {
  tpl: (strings: TemplateStringsArray, ...values: any[]) => string;
}

/**
 * Custom SVGR template for React Native
 */
const svgrNativeTemplate = (
  {
    imports,
    interfaces,
    componentName,
    props,
    jsx,
    exports,
  }: SvgrTemplateParams,
  { tpl }: SvgrTemplateContext
) => {
  // Extract just the SVG content for our template
  const svgContent = jsx.children;

  // Return the component code
  return componentTemplate
    .replace(/\{\{componentName\}\}/g, componentName)
    .replace(/\{\{svgContent\}\}/g, svgContent);
};

/**
 * Fix React Native SVG compatibility issues in SVG content
 *
 * @param svgContent - The SVG content to transform
 * @returns The fixed SVG content
 */
function fixReactNativeSvgContent(svgContent: string): string {
  // Replace HTML pattern attributes that conflict with React Native
  let fixed = svgContent
    // Fix case-sensitive attributes
    .replace(/fill-rule/g, "fillRule")
    .replace(/clip-rule/g, "clipRule")
    .replace(/stroke-width/g, "strokeWidth")
    .replace(/stroke-linecap/g, "strokeLinecap")
    .replace(/stroke-linejoin/g, "strokeLinejoin")
    .replace(/stroke-dasharray/g, "strokeDasharray")
    .replace(/stroke-dashoffset/g, "strokeDashoffset")
    .replace(/stop-color/g, "stopColor")
    .replace(/stop-opacity/g, "stopOpacity")
    .replace(/xlink:href/g, "href")
    .replace(/xml:space/g, "xmlSpace")

    // Fix HTML img vs. React Native SVG Image component
    .replace(/<img(\s+[^>]*>)/g, "<Image$1")
    .replace(/<\/img>/g, "</Image>")

    // Fix Pattern content to use Rect instead of image when appropriate
    .replace(/<Pattern\b([^>]*)>(\s*)<image\b/gi, "<Pattern$1>$2<Image")

    // Handle special HTML attributes in a React Native-friendly way
    .replace(/patternUnits="userSpaceOnUse"/g, 'patternUnits="userSpaceOnUse"')
    .replace(/preserveAspectRatio="none"/g, 'preserveAspectRatio="none"');

  // Return the fixed content
  return fixed;
}

/**
 * Transforms an SVG file to a React Native component
 *
 * @param svgContent - The SVG content to transform
 * @param componentName - The name of the component
 * @returns The React Native component code
 */
async function transformSvgToReactNativeComponent(
  svgContent: string,
  componentName: string
): Promise<string> {
  // First, we need to pre-process the SVG for React Native
  const processedSvg = fixReactNativeSvgContent(svgContent);

  try {
    // Transform the SVG to a React Native component
    const jsCode = await transform(
      processedSvg,
      {
        plugins: ["@svgr/plugin-svgo", "@svgr/plugin-jsx"],
        icon: true,
        native: true,
        typescript: true,
        memo: false,
        titleProp: false,
        descProp: false,
        svgProps: {
          viewBox: "0 0 24 24",
        },
      },
      { componentName }
    );

    // Extract SVG content (just the children of the SVG element)
    const svgMatch = jsCode.match(/<Svg[^>]*>([\s\S]*?)<\/Svg>/);
    let svgChildren = "";

    if (svgMatch && svgMatch[1]) {
      svgChildren = svgMatch[1].trim();

      // Fix any remaining compatibility issues in the transformed code
      svgChildren = fixReactNativeSvgContent(svgChildren);
    } else {
      // Fallback - try to extract just Path elements
      const pathMatches = jsCode.match(/<Path[^>]*\/?>/g);
      if (pathMatches) {
        svgChildren = pathMatches.join("\n      ");
      }
    }

    // Replace the template variables
    return componentTemplate
      .replace(/\{\{componentName\}\}/g, componentName)
      .replace(/\{\{svgContent\}\}/g, svgChildren);
  } catch (error) {
    console.error(`Error transforming ${componentName}:`, error);

    // Fallback with a simple component if transformation fails
    return componentTemplate
      .replace(/\{\{componentName\}\}/g, componentName)
      .replace(
        /\{\{svgContent\}\}/g,
        '<Path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8z" fill="currentColor" />'
      );
  }
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
 * Main function to generate React Native components from SVG files
 */
async function generateReactNativeComponents(): Promise<void> {
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

      // Transform to React Native component
      const componentCode = await transformSvgToReactNativeComponent(
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

    console.log("✅ All React Native components generated successfully!");
  } catch (error) {
    console.error("❌ Error generating React Native components:", error);
  }
}

// Run the generation function
generateReactNativeComponents();
