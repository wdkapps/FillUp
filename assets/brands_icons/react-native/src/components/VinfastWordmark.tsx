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

export interface VinfastWordmarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * VinfastWordmark icon component for React Native
 */
const VinfastWordmark = ({ size, width, height, ...props }: VinfastWordmarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#3C3C3C" d="M186.152 251.597c-6.6-7.45-16.05-10.4-17.45-21h-13.15v53.4h12.95v-32.4c0 2 9.3 7.35 12.95 12.85a21.6 21.6 0 0 1 4.6 10.55c.359 3.003.476 6.029.35 9.05h12.65v-53.4h-12.9zM331.302 230.604h-13.1c-4.05 13.45-8.95 29.1-13.1 42.5-1.1 3.65-2.1 7.05-3.3 10.9h10c3.65 0 3.65 0 5-3.65s1.35-4.3 6.1-4.3 6.8.55 8.8-3.05l1.7-3.25c1.1 4.7 2.25 9.45 3.4 14.3h15.8c-.35-1.2-10-33.1-15-49.15a5.85 5.85 0 0 0-6.3-4.3m-6.95 33.8c-.95 0-2.9.45-3.3 1.75l.55-1.75 5-16.95c.35 1.1 3.35 11.35 5 16.95zM412.198 254.648c-7.1-3.35-12.8-3.649-12.8-8.099 0-2.85 2.2-4.701 5.9-4.701 4.45 0 8.7 1.9 8.7 5a6.345 6.345 0 0 0 5.95-4.149 8 8 0 0 0-3-8.301 25.31 25.31 0 0 0-23.2-1.699 13.445 13.445 0 0 0-8.8 13.299c0 7.45 7.9 11.75 10.8 13.35s6.95 3.401 9.2 4.601 3.95 3.599 3.55 5.399-3.35 2.85-5 2.8a20 20 0 0 1-9.1-2.599 34.4 34.4 0 0 1-9.45-6.85v9.5c0 3.75 3.35 6.3 6.35 8.25a24.25 24.25 0 0 0 13.05 3.549 19.1 19.1 0 0 0 13.9-5 15.24 15.24 0 0 0 4.35-10.449c0-6.1-2.75-10.001-10.6-13.901M50.2 230.754c1.1 12.35-5.9 22.65-8.65 33.9-2.4-6.5-7.5-22.5-9.6-28.9-.8-2.45-1.8-5-5-5H15v.65c6.15 17.2 12.65 35.55 18.85 52.75h10.7a6.354 6.354 0 0 0 5-4.2c1.8-5.25 10-27.5 12.4-35a34.4 34.4 0 0 0 2.05-14.05zM239.951 284.047h14.55v-20.85h7.7c5 0 7.45-2.65 7.45-6.8v-5h-15v-8.7h16.85v-12.1h-31.55zM475.251 230.6h-20.9v11.25h12.6v42.2h14.6v-42.2c8.6 0 9.5.3 12.4-2.05s2.3-3.45 2.3-11.8c-3.9 3-14.2 2.6-21.05 2.6M109.452 230.597h-8.9v53.45h14.4v-48.2a4.7 4.7 0 0 0-3.276-4.83 4.7 4.7 0 0 0-2.074-.17" />
    </Svg>
  );
};

VinfastWordmark.displayName = 'VinfastWordmark';

export default VinfastWordmark;