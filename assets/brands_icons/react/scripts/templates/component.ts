/**
 * Template for React SVG icon components
 */
export const componentTemplate = `import * as React from 'react';
import { forwardRef } from 'react';

export interface {{componentName}}Props extends React.SVGProps<SVGSVGElement> {
  /** Size of the icon (sets both width and height) */
  size?: number | string;
}

/**
 * {{componentName}} icon component
 */
const {{componentName}} = forwardRef<SVGSVGElement, {{componentName}}Props>(({ size, ...props }, ref) => {
  const sizeProps = size !== undefined ? { width: size, height: size } : {};
  return (
    {{svgContent}}
  );
});

{{componentName}}.displayName = '{{componentName}}';

export default {{componentName}};`;
