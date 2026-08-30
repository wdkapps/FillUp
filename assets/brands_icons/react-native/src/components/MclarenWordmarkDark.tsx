import * as React from 'react';
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

export interface MclarenWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * MclarenWordmarkDark icon component for React Native
 */
const MclarenWordmarkDark = ({ size, width, height, ...props }: MclarenWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M376.157 251.154c56.234-36.189 131.835-37.348 43.634 21.109l1.4-1.855c24.967-34.101-25.9-26.446-43.867-19.718zm-205.801 25.749h23.8v9.279h-27.534c-11.667 0-16.8-3.48-16.8-12.759v-2.087c0-7.888 4.667-12.991 16.334-12.991h28v9.279h-23.8c-1.114 0-2.183.44-2.97 1.223a4.16 4.16 0 0 0-1.23 2.953v1.159a4.16 4.16 0 0 0 1.309 2.804 4.2 4.2 0 0 0 2.891 1.14m44.8-23.198v23.198h14v9.279h-32.667v-32.477zm-88.434 4.176a18.97 18.97 0 0 1 11.433-4.176h9.334v32.477h-18.667v-16.238l-17.967 16.238H93.822v-16.238l-20.767 16.238H51.82l37.1-27.837c3.5-2.552 5.834-4.64 11.901-4.64h11.666v16.239zm158.434 3.48a5.325 5.325 0 0 1 1.734-3.947 5.4 5.4 0 0 1 1.903-1.124 5.4 5.4 0 0 1 2.197-.265h22.167v9.279H301.49v20.878h-16.334zm109.435-5.336c14 0 18.9 3.016 18.9 13.223v16.934h-16.334v-11.599a6.94 6.94 0 0 0-2.05-4.921 7.02 7.02 0 0 0-4.95-2.038h-7v18.558h-16.333v-30.157zm-127.401 0c10.733 0 15.633 4.408 15.633 11.831v6.959c0 8.583-4.9 11.367-16.8 11.367H247.59c-6.767 0-11.667-.696-14.234-3.016a8.32 8.32 0 0 1-1.867-5.335v-1.16c0-4.639 2.8-9.047 11.667-9.047h21c0-2.088.234-2.32-2.333-2.32h-28v-9.279zm-3.034 19.718v-1.16h-12.833a1.17 1.17 0 0 0-1.167 1.16 1.168 1.168 0 0 0 1.167 1.16h11.667c.309 0 .606-.122.825-.34.218-.217.341-.512.341-.82m85.401-19.718c12.367 0 14.933 3.712 14.933 8.815V266c0 5.568-4.433 8.583-11.666 8.583h-21c0 2.088 2.1 2.32 4.666 2.32h25.667v9.279H330.19c-10.033 0-14.7-4.176-14.7-11.831v-5.335c0-8.815 4.9-12.991 16.1-12.991zm-2.567 11.599a1.17 1.17 0 0 0 1.167-1.16 1.168 1.168 0 0 0-1.167-1.16h-14a1.17 1.17 0 0 0-.825.34 1.15 1.15 0 0 0-.341.82v1.16z" />
    </Svg>
  );
};

MclarenWordmarkDark.displayName = 'MclarenWordmarkDark';

export default MclarenWordmarkDark;