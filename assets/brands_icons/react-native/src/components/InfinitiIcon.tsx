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

export interface InfinitiIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * InfinitiIcon icon component for React Native
 */
const InfinitiIcon = ({ size, width, height, ...props }: InfinitiIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#231F20" d="M343.751 301.694 256 183.672l-87.751 118.022c-29.634-2.879-80.56-22.165-80.56-56.421 0-43.178 74.805-83.479 168.599-83.479 98.684 0 168.597 40.301 168.597 83.479 0 34.544-51.212 53.83-80.558 56.133M256 149.129c-121.413 0-206 47.496-206 108.81 0 28.786 18.413 61.026 57.542 80.601 36.539 18.135 87.751 24.468 94.944 25.331L256 207.564l53.514 156.307a330.7 330.7 0 0 0 94.944-25.331C443.587 318.965 462 286.725 462 257.939c-.288-61.602-84.587-108.81-206-108.81" />
    </Svg>
  );
};

InfinitiIcon.displayName = 'InfinitiIcon';

export default InfinitiIcon;