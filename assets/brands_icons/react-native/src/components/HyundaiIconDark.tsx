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

export interface HyundaiIconDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * HyundaiIconDark icon component for React Native
 */
const HyundaiIconDark = ({ size, width, height, ...props }: HyundaiIconDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M255.983 358.916c110.45 0 200.017-45.85 200.017-102.4 0-56.583-89.567-102.433-200.017-102.433C145.567 154.083 56 199.933 56 256.516c0 56.55 89.567 102.4 199.983 102.4m37.667-50.25c-3.333 7.734-9.083 24.234-22.267 30.834-4 1.983-8.95 2.9-13.333 3.083H256c-36.9 0-71.267-5.167-100.033-13.9l-1.1-.417c-2.667-.883-4-2.116-4-3.633 0-1.317.716-2.333 1.65-3.25l1.816-1.617c6.667-5.533 26.634-20 64.3-34.45 13.217-5.016 29.767-11.316 47.084-15 10.133-2.1 47.816-7.883 27.933 38.35m101.017-103.233c.716-1.233 1.666-2.283 3.383-2.367.933-.1 2.2.117 4.133 1.334 23.484 14.45 37.417 32.533 37.417 52.083 0 35.3-45.4 65.667-110.333 78.917-4.134.833-6.934.8-7.85-.25-.667-.634-.834-1.767 0-3.167a13.5 13.5 0 0 1 1.733-2.417c35.333-41.666 62.267-103.15 69.917-120.883.583-1.233 1.133-2.45 1.6-3.25m-175.717-1.317c3.333-7.716 9.083-24.233 22.25-30.766 4-2 8.95-2.967 13.333-3.084 1.017-.033 1.734 0 2 0 36.95 0 71.267 5.1 100.067 13.884.217.1.883.333 1.1.416 2.667.9 4 2.117 4 3.634 0 1.316-.7 2.283-1.633 3.216a31 31 0 0 1-1.834 1.6c-6.616 5.584-26.633 20.017-64.3 34.467-13.25 5.067-29.766 11.317-47.033 14.983-10.167 2.167-47.833 7.884-27.95-38.35m-36.283-26.55c4.166-.8 6.916-.8 7.933.25.583.667.75 1.767-.033 3.167a15 15 0 0 1-1.734 2.367C153.5 225.066 126.55 286.5 118.867 304.283a39 39 0 0 1-1.6 3.25c-.667 1.217-1.65 2.267-3.334 2.367-.933.083-2.25-.184-4.183-1.35-23.467-14.45-37.417-32.517-37.417-52.067 0-35.3 45.4-65.667 110.334-78.917" />
    </Svg>
  );
};

HyundaiIconDark.displayName = 'HyundaiIconDark';

export default HyundaiIconDark;