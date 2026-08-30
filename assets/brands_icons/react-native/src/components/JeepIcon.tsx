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

export interface JeepIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * JeepIcon icon component for React Native
 */
const JeepIcon = ({ size, width, height, ...props }: JeepIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#424D07" d="M120.957 174.203h33.495v87.879c0 15.131-6.489 46.824-52.947 46.824S50 279.371 50 262.809v-16.213h32.42v15.847c0 9.723 6.478 18.731 18.725 18.731 12.241 0 19.812-6.84 19.812-18.365zm85.34 36.735c-30.616 0-44.3 28.098-44.3 52.221 0 24.138 15.486 47.545 47.179 47.545 27.733.36 46.108-17.649 46.108-30.972h-30.617s-3.605 8.641-14.409 8.641-16.923-6.123-16.923-20.888h62.304c0-46.458-23.046-56.547-49.337-56.547m-12.967 37.821c0-9.723 3.955-17.654 15.125-17.654 11.531 0 16.568 8.652 16.568 17.654zm113.114-37.821c-30.611 0-44.305 28.098-44.305 52.221 0 24.138 15.491 47.545 47.184 47.545 27.738.36 46.103-17.649 46.103-30.972h-30.612s-3.605 8.641-14.409 8.641-16.928-6.123-16.928-20.888h62.31c0-46.458-23.047-56.547-49.343-56.547m-12.967 37.821c0-9.723 3.965-17.654 15.12-17.654 11.536 0 16.573 8.652 16.573 17.654zm101.532 90.038v-38.548c1.293 1.72 2.029 2.549 4.321 4.326 3.589 2.802 9.723 7.571 23.407 7.571 24.848 0 39.258-21.615 39.258-51.15 0-38.177-24.128-48.982-39.619-48.982-15.486 0-21.316 7.205-23.407 9.729-2.42 2.904-3.213 4.557-4.326 6.952v-14.162h-30.972v124.264zm-.721-76.72c.36-18.37 7.56-25.93 17.283-25.93 15.852 0 18.726 12.247 18.726 24.849 0 12.612-2.158 29.175-17.284 29.175s-19.086-9.724-18.725-28.094" />
    </Svg>
  );
};

JeepIcon.displayName = 'JeepIcon';

export default JeepIcon;