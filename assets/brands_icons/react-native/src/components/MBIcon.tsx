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

export interface MBIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * MBIcon icon component for React Native
 */
const MBIcon = ({ size, width, height, ...props }: MBIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#000" d="M256 422c-91.678 0-166-74.324-166-166 0-91.678 74.322-166 166-166 91.68 0 166 74.322 166 166 0 91.676-74.32 166-166 166" /><Path fill="#fff" d="m256.049 281.076-134.774 55.783c28.396 47.714 79.855 76.828 135.348 76.541 55.351-.144 106.666-29.551 134.774-77.405zm-23.345-39.396L254.18 99.412c-55.351.72-106.377 30.558-134.052 78.557-27.818 47.999-28.107 107.097-.863 155.385zm45.974 1.887 114.734 88.79c26.668-48.287 26.09-106.953-1.726-154.664a157.07 157.07 0 0 0-133.478-78.27z" />
    </Svg>
  );
};

MBIcon.displayName = 'MBIcon';

export default MBIcon;