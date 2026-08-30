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

export interface MitsubishiIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * MitsubishiIcon icon component for React Native
 */
const MitsubishiIcon = ({ size, width, height, ...props }: MitsubishiIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#EE1D23" d="m253.724 107.818-57.816 92.87 116.087 202.583L434 402.816l-61.913-100.154H138.092L78 404.182h113.811l122.005-205.315z" />
    </Svg>
  );
};

MitsubishiIcon.displayName = 'MitsubishiIcon';

export default MitsubishiIcon;