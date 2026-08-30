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

export interface PolestarIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * PolestarIcon icon component for React Native
 */
const PolestarIcon = ({ size, width, height, ...props }: PolestarIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#000" d="M254.66 260.73v195.91l-8 9.73-33.06-164.64zM257.92 251.67V55.73l8-9.73 33.06 164.61z" /><Path fill="#000" d="m213.6 301.73-164.6-33 9.72-8h195.94zM299.01 210.62l164.6 33.11-9.72 8H257.92z" />
    </Svg>
  );
};

PolestarIcon.displayName = 'PolestarIcon';

export default PolestarIcon;