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

export interface MclarenLogoHorizontalDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * MclarenLogoHorizontalDark icon component for React Native
 */
const MclarenLogoHorizontalDark = ({ size, width, height, ...props }: MclarenLogoHorizontalDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M374.258 251.154c55.906-36.189 131.066-37.348 43.379 21.109l1.392-1.855c24.821-34.101-25.749-26.446-43.611-19.718zm-204.603 25.749h23.661v9.279h-27.373c-11.599 0-16.702-3.48-16.702-12.759v-2.087c0-7.888 4.639-12.991 16.238-12.991h27.837v9.279h-23.661a4.176 4.176 0 0 0-4.176 4.176v1.159a4.173 4.173 0 0 0 4.176 3.944m44.539-23.198v23.198h13.919v9.279h-32.477v-32.477zm-87.919 4.176a18.8 18.8 0 0 1 11.367-4.176h9.279v32.477h-18.558v-16.238l-17.862 16.238H93.567v-16.238L72.92 286.182H51.81l36.884-27.837c3.48-2.552 5.8-4.64 11.831-4.64h11.599v16.239zm157.512 3.48a5.3 5.3 0 0 1 .446-2.155 5.337 5.337 0 0 1 5.353-3.181h22.038v9.279h-11.599v20.878h-16.238zm108.797-5.336c13.918 0 18.79 3.016 18.79 13.223v16.934h-16.239v-11.599a6.96 6.96 0 0 0-6.959-6.959h-6.959v18.558h-16.238v-30.157zm-126.659 0c10.671 0 15.542 4.408 15.542 11.831v6.959c0 8.583-4.871 11.367-16.702 11.367h-18.326c-6.727 0-11.599-.696-14.151-3.016a8.35 8.35 0 0 1-1.855-5.335v-1.16c0-4.639 2.783-9.047 11.598-9.047h20.878c0-2.088.232-2.32-2.32-2.32h-27.837v-9.279zm-3.016 19.718v-1.16H250.15a1.16 1.16 0 0 0 0 2.32h11.599c.308 0 .603-.122.82-.34.218-.217.34-.512.34-.82m84.903-19.718c12.295 0 14.847 3.712 14.847 8.815V266c0 5.568-4.408 8.583-11.599 8.583h-20.878c0 2.088 2.088 2.32 4.64 2.32h25.517v9.279h-31.781c-9.975 0-14.614-4.176-14.614-11.831v-5.335c0-8.815 4.871-12.991 16.006-12.991zm-2.551 11.599a1.16 1.16 0 0 0 0-2.32h-13.919c-.308 0-.603.122-.82.34-.218.217-.34.512-.34.82v1.16z" />
    </Svg>
  );
};

MclarenLogoHorizontalDark.displayName = 'MclarenLogoHorizontalDark';

export default MclarenLogoHorizontalDark;