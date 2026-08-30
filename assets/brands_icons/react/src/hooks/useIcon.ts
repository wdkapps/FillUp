import * as React from "react";
import { IconProps } from "../types";

// This is a dynamic import that will be replaced during the build process
// with actual icon components
// @ts-ignore - This is intentional as the file will be generated
import * as Icons from "../components";

/**
 * Hook to render an icon component based on its name
 *
 * @param props - Icon props including name, size, color, and any SVG props
 * @returns The React element for the icon, or null if not found
 */
export const useIcon = ({
  name,
  size = 24,
  color = "currentColor",
  ...restProps
}: IconProps): React.ReactElement | null => {
  // Get the icon component from the dynamically imported icons
  const IconComponent = (Icons as any)[name];

  if (!IconComponent) {
    console.warn(`Icon "${name}" not found`);
    return null;
  }

  // Return the icon component with size and color props
  return React.createElement(IconComponent, {
    width: size,
    height: size,
    color,
    ...restProps,
  });
};
