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

export interface VolkswagenIconDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * VolkswagenIconDark icon component for React Native
 */
const VolkswagenIconDark = ({ size, width, height, ...props }: VolkswagenIconDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M256.212 416.578c-88.197 0-160.455-72.612-160.455-160.809 0-19.836 3.542-38.609 10.272-56.319l93.865 188.792c1.062 2.479 2.833 4.604 5.667 4.604s4.604-2.125 5.667-4.604l43.213-96.698c.354-1.063 1.063-2.126 2.125-2.126s1.417 1.063 2.126 2.126l43.213 96.698c1.062 2.479 2.833 4.604 5.667 4.604s4.605-2.125 5.667-4.604l93.865-188.792c6.73 17.71 10.272 36.483 10.272 56.319-.709 88.197-72.967 160.809-161.164 160.809m0-197.292c-1.062 0-1.417-1.063-2.125-2.126L203.79 103.815c16.293-6.022 34.004-9.21 52.422-9.21 18.419 0 36.129 3.188 52.423 9.21L258.337 217.16c-.708 1.417-1.062 2.126-2.125 2.126m-51.36 116.533c-1.062 0-1.416-1.062-2.125-2.125L121.26 169.343c14.522-22.315 34.004-41.088 57.735-54.194l58.799 130.702c.708 2.125 2.479 2.834 4.25 2.834h28.336c2.126 0 3.543-.354 4.605-2.834l58.798-130.702c23.378 13.106 43.213 31.879 57.736 54.194l-82.176 164.351c-.354 1.063-1.063 2.125-2.125 2.125s-1.417-1.062-2.125-2.125l-30.816-70.133c-1.063-2.479-2.48-2.833-4.605-2.833h-28.336c-2.126 0-3.542.354-4.605 2.833l-29.753 70.133c-.355 1.063-1.063 2.125-2.126 2.125m51.36 97.053c98.115 0 177.103-78.988 177.103-177.103S354.327 78.666 256.212 78.666 79.109 157.654 79.109 255.769s78.988 177.103 177.103 177.103" />
    </Svg>
  );
};

VolkswagenIconDark.displayName = 'VolkswagenIconDark';

export default VolkswagenIconDark;