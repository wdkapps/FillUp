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

export interface ChevroletIconDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * ChevroletIconDark icon component for React Native
 */
const ChevroletIconDark = ({ size, width, height, ...props }: ChevroletIconDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M78.133 279.103 101.7 233.79h98.875v-31.478H311.18v31.612h122.742l-23.567 45.312H311.18v31.586H200.575v-31.719zM329.863 184H181.782v31.612H70.632L28 297.495h153.782V329h148.081v-31.505h111.505L484 215.692H329.918z" />
    </Svg>
  );
};

ChevroletIconDark.displayName = 'ChevroletIconDark';

export default ChevroletIconDark;