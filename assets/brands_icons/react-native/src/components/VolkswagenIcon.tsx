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

export interface VolkswagenIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * VolkswagenIcon icon component for React Native
 */
const VolkswagenIcon = ({ size, width, height, ...props }: VolkswagenIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#001E50" d="M256.212 416.579c-88.197 0-160.455-72.612-160.455-160.81 0-19.835 3.542-38.608 10.272-56.318l93.865 188.791c1.062 2.48 2.833 4.605 5.667 4.605s4.604-2.125 5.667-4.605l43.213-96.698c.354-1.063 1.063-2.125 2.125-2.125s1.417 1.062 2.126 2.125l43.213 96.698c1.062 2.48 2.833 4.605 5.667 4.605s4.605-2.125 5.667-4.605l93.865-188.791c6.73 17.71 10.272 36.483 10.272 56.318-.709 88.198-72.967 160.81-161.164 160.81m0-197.293c-1.062 0-1.417-1.062-2.125-2.125L203.79 103.815c16.293-6.021 34.004-9.21 52.422-9.21 18.419 0 36.129 3.189 52.423 9.21l-50.298 113.346c-.708 1.417-1.062 2.125-2.125 2.125m-51.36 116.534c-1.062 0-1.416-1.063-2.125-2.125L121.26 169.343c14.522-22.315 34.004-41.088 57.735-54.193l58.799 130.702c.708 2.125 2.479 2.833 4.25 2.833h28.336c2.126 0 3.543-.354 4.605-2.833l58.798-130.702c23.378 13.105 43.213 31.878 57.736 54.193l-82.176 164.352c-.354 1.062-1.063 2.125-2.125 2.125s-1.417-1.063-2.125-2.125l-30.816-70.133c-1.063-2.48-2.48-2.834-4.605-2.834h-28.336c-2.126 0-3.542.354-4.605 2.834l-29.753 70.133c-.355 1.062-1.063 2.125-2.126 2.125m51.36 97.052c98.115 0 177.103-78.988 177.103-177.103S354.327 78.666 256.212 78.666 79.109 157.654 79.109 255.77s78.988 177.103 177.103 177.103" />
    </Svg>
  );
};

VolkswagenIcon.displayName = 'VolkswagenIcon';

export default VolkswagenIcon;