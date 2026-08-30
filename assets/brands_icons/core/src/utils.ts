import { KNOWN_ACRONYMS } from "./types";
import fs from "fs";
import path from "path";
import { glob } from "glob";

/**
 * Converts a filename or string to PascalCase while preserving specified acronyms
 *
 * @param input - The input string to convert
 * @returns The converted PascalCase string
 */
export function toPascalCase(input: string): string {
  // Replace non-alphanumeric characters with spaces
  const spaceSeparated = input.replace(/[^a-zA-Z0-9]/g, " ").trim();

  // Split by spaces
  const parts = spaceSeparated.split(" ").filter((part) => part.length > 0);

  // Process each part
  return parts
    .map((part) => {
      // Check if this part contains a known acronym
      for (const acronym of KNOWN_ACRONYMS) {
        if (part.toUpperCase() === acronym) {
          return acronym;
        }

        // Check if part contains the acronym as a substring at the start
        const upperPart = part.toUpperCase();
        if (upperPart.startsWith(acronym)) {
          const index = upperPart.indexOf(acronym);
          const before = index > 0 ? capitalize(part.substring(0, index)) : "";
          const after =
            index + acronym.length < part.length
              ? capitalize(part.substring(index + acronym.length))
              : "";

          return before + acronym + after;
        }
      }

      // If no acronym, capitalize normally
      return capitalize(part);
    })
    .join("");
}

/**
 * Capitalizes the first letter of a string
 *
 * @param input - The input string
 * @returns The capitalized string
 */
export function capitalize(input: string): string {
  if (!input || input.length === 0) return input;
  return input.charAt(0).toUpperCase() + input.slice(1).toLowerCase();
}

/**
 * Ensures a directory exists, creating it recursively if needed
 *
 * @param dirPath - The directory path to ensure
 */
export function ensureDirectoryExists(dirPath: string): void {
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true });
  }
}

/**
 * Finds all SVG files in a directory and its subdirectories
 *
 * @param directory - The directory to search in
 * @returns An array of file paths
 */
export async function findSvgFiles(directory: string): Promise<string[]> {
  return glob(`${directory}/**/*.svg`);
}

/**
 * Cleans a directory by removing all files with specified extensions
 *
 * @param directory - The directory to clean
 * @param extensions - File extensions to remove (defaults to ['.svg'])
 */
export function cleanDirectory(
  directory: string,
  extensions: string[] = [".svg"]
): void {
  if (!fs.existsSync(directory)) {
    return;
  }

  const files = fs.readdirSync(directory);

  for (const file of files) {
    const filePath = path.join(directory, file);
    const stat = fs.statSync(filePath);

    if (stat.isDirectory()) {
      cleanDirectory(filePath, extensions);
    } else if (extensions.some((ext) => file.endsWith(ext))) {
      fs.unlinkSync(filePath);
    }
  }
}

/**
 * Extracts the basename without extension from a file path
 *
 * @param filePath - The file path
 * @returns The basename without extension
 */
export function getBasename(filePath: string): string {
  const basename = path.basename(filePath);
  const extname = path.extname(basename);
  return basename.substring(0, basename.length - extname.length);
}

/**
 * Processes a brand name while preserving specified acronyms
 *
 * @param brandName - The raw brand name
 * @returns The processed brand name
 */
export function processBrandName(brandName: string): string {
  const nameParts = brandName.split(" ");
  let processedName = "";

  for (const part of nameParts) {
    let isAcronym = false;

    // Check if this part is a known acronym
    for (const acronym of KNOWN_ACRONYMS) {
      if (part.toUpperCase() === acronym) {
        processedName += acronym;
        isAcronym = true;
        break;
      }
    }

    // If not an acronym, normalize case
    if (!isAcronym) {
      processedName += capitalize(part);
    }
  }

  return processedName;
}
