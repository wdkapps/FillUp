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

export interface LexusWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * LexusWordmarkDark icon component for React Native
 */
const LexusWordmarkDark = ({ size, width, height, ...props }: LexusWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="m213.096 271.417 20.688-13.526-31.314-23.224v5.686h-46.321c-6.043 0-11.016 4.28-11.917 9.852l53.7-.057v10.136l-41.056.056c-6.486 0-11.799 4.906-12.084 11.077zm196.71-31.234h47.486v-9.965h-47.753c-17.859 0-32.451 13.586-33.182 30.623l57.564-.06c3.738 0 6.758 2.453 6.758 5.407 0 3.006-3.024 5.403-6.758 5.403l-63.376-.004v-41.369h-18.797v41.098H314c-5.54-.897-7.277-4.902-7.277-12.701l.004-28.397h-30.312l-27.252 17.591-23.712-17.591h-72.938c-16.167 0-29.643 11.077-32.61 25.83h14.653c-5.528 3.734-9.782 9.028-12.132 15.272l-46.377-.004c-5.467-.897-7.261-4.902-7.261-12.701l.004-28.397H50.045v26.501c-.787 17.551 8.776 23.839 19.686 24.837l145.711-.004 26.85-17.264 23.44 17.494h28.68l-36.514-27.342 30.028-19.377.057 21.656c-.771 17.551 9.733 23.839 20.647 24.837l136.359-.004c9.396 0 17.011-6.842 17.011-15.364 0-8.471-7.619-15.312-17.011-15.312h-47.095c.442-5.961 5.597-10.693 11.912-10.693" />
    </Svg>
  );
};

LexusWordmarkDark.displayName = 'LexusWordmarkDark';

export default LexusWordmarkDark;