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

export interface AcuraIconDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * AcuraIconDark icon component for React Native
 */
const AcuraIconDark = ({ size, width, height, ...props }: AcuraIconDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M411.7 241.559c-2.793-52.951-20.315-91.746-44.185-112.979-25.902-22.805-74.151-31.718-111.48-31.455-37.329-.263-85.577 8.65-111.48 31.455-23.87 21.233-41.392 60.029-44.185 112.979-2.54 49.804 7.872 104.066 35.297 134.735 26.409 30.145 79.229 39.582 120.113 39.582 40.884.262 93.703-9.437 120.113-39.582 27.426-30.932 38.091-85.193 35.807-134.735M247.146 110.493c5.079-.262 6.348-.262 8.634-.262s3.301 0 8.634.262l.254 115.862h-17.775s0-115.862.253-115.862M120.939 290.314c-1.524-19.922-7.364-92.532 20.569-133.949 11.935-18.087 29.457-30.145 47.233-36.436 24.632-8.912 54.089-9.437 54.089-9.437-11.428 29.097-35.044 91.484-39.615 105.377-5.586 17.038-10.411 26.737-15.236 57.406-3.048 25.165-8.38 87.814-9.904 115.076-33.012-16.251-52.819-47.183-57.136-98.037m134.588 112.193c-23.109-.262-51.55-2.621-74.15-12.582 7.618-20.971 43.931-111.144 63.992-146.269h20.569c19.807 35.125 56.375 125.298 63.993 146.269-22.855 10.222-51.042 12.32-74.404 12.582m134.841-112.453c-4.316 51.116-24.124 81.784-57.136 98.299-1.523-27.262-6.856-89.911-9.903-115.076-4.825-30.932-9.65-40.368-15.237-57.407-4.57-13.893-28.187-76.28-39.614-105.376 0 0 29.457.524 54.089 9.436 17.775 6.291 35.297 18.611 47.232 36.436 27.933 41.417 22.093 114.027 20.569 133.688" />
    </Svg>
  );
};

AcuraIconDark.displayName = 'AcuraIconDark';

export default AcuraIconDark;