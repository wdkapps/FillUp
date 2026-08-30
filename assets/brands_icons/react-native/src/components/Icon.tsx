import * as React from "react";
import { IconProps } from "../types";
import { useIcon } from "../hooks/useIcon";

/**
 * Icon component that renders an SVG icon by name in React Native
 */
export const Icon: React.FC<IconProps> = (props) => {
  return useIcon(props);
};

Icon.displayName = "Icon";

export default Icon;
