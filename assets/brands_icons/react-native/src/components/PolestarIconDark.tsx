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

export interface PolestarIconDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * PolestarIconDark icon component for React Native
 */
const PolestarIconDark = ({ size, width, height, ...props }: PolestarIconDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M254.66 260.73v195.91l-8 9.73-33.06-164.64zM257.92 251.67V55.73l8-9.73 33.06 164.61z" /><Path fill="#fff" d="m213.6 301.73-164.6-33 9.72-8h195.94zM299.01 210.62l164.6 33.11-9.72 8H257.92z" />
    </Svg>
  );
};

PolestarIconDark.displayName = 'PolestarIconDark';

export default PolestarIconDark;