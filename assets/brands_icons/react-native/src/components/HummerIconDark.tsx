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

export interface HummerIconDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * HummerIconDark icon component for React Native
 */
const HummerIconDark = ({ size, width, height, ...props }: HummerIconDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="m225.545 215.007-8.529 36.819-8.525-36.819h-29.279v79.294h23.082v-40.325l8.601 40.325h12.251l8.601-40.325v40.325h23.071v-79.294zM306.107 215.007l-8.528 36.819-8.528-36.819h-29.275v79.294h23.077v-40.325l8.601 40.325h12.253l8.606-40.325v40.325h23.071v-79.294zM85.969 215.007v29.106h-11.51v-29.106H50v79.294h24.458v-29.98h11.51v29.98h24.461v-79.294zM392.919 234.091v-19.084H340.46v79.294l52.459-.006v-19.084h-27.993v-11.859h27.993v-17.371h-27.993v-11.89zM139.332 215.03l-.003 53.197c.047 6.848 2.358 8.556 5.508 8.556 3.077 0 5.422-1.819 5.422-8.705V215.03h24.392v53.363c0 23.529-8.8 28.613-29.814 28.607-21.042-.007-29.903-4.993-29.903-28.613V215.03zM429.087 251.208c4.568 0 6.749-3.231 6.749-9.796 0-8.235-2.755-10.442-6.775-10.442h-7.151v20.238zm6.806 43.069-13.97-28.425v28.449h-24.465v-79.295L436.75 215c8.248 0 21.898-.438 21.169 26.018-.342 12.371-6.977 21.396-12.248 23.616L462 294.277z" />
    </Svg>
  );
};

HummerIconDark.displayName = 'HummerIconDark';

export default HummerIconDark;