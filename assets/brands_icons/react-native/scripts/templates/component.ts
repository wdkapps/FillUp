/**
 * Template for React Native SVG icon components
 */
export const componentTemplate = `import * as React from 'react';
import Svg, {
  Path,
  G,
  Circle,
  Rect,
  Ellipse,
  Line,
  Polygon,
  Polyline,
  Defs,
  ClipPath,
  LinearGradient,
  RadialGradient,
  Stop,
  Use,
  Symbol,
  Mask,
  Pattern,
  Image,
  ForeignObject,
  TSpan,
  TextPath,
  Text,
  SvgProps
} from 'react-native-svg';

export interface {{componentName}}Props extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * {{componentName}} icon component for React Native
 */
const {{componentName}} = ({ size, width, height, ...props }: {{componentName}}Props) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      {{svgContent}}
    </Svg>
  );
};

{{componentName}}.displayName = '{{componentName}}';

export default {{componentName}};`;
