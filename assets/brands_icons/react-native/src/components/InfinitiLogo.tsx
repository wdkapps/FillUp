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

export interface InfinitiLogoProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * InfinitiLogo icon component for React Native
 */
const InfinitiLogo = ({ size, width, height, ...props }: InfinitiLogoProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#231F20" d="M124.16 307.183v38.061l-12.91-36.687c-.274-.962-.961-1.374-2.334-1.374H96.968v46.306h8.24V315.84l12.772 36.137c.274.962 1.098 1.374 2.06 1.374h12.36v-46.305h-8.24zm42.573 0v46.306h9.613v-19.787h17.167v-8.519h-17.167v-9.618h17.442v-8.519h-27.055zm220.145 0v8.931h10.575v37.375h9.613v-37.512h10.575v-8.931h-30.9zM227.16 353.489h10.3v-46.306h-10.3zm116.733 0h10.3v-46.306h-10.3zm106.433 0h10.163v-46.306h-10.163zm-398.953 0h10.3v-46.306h-10.3zm257.225-46.306h-8.24v38.061l-12.909-36.687c-.275-.962-.961-1.374-2.197-1.374h-12.086v46.306h8.24V315.84l12.772 36.137c.275.962 1.099 1.374 2.06 1.374h12.36v-46.305zm-10.712-75.985L256 174.863l-41.887 56.335c-14.145-1.374-38.453-10.58-38.453-26.931 0-20.611 35.706-39.847 80.477-39.847 47.105 0 80.477 19.236 80.477 39.847 0 16.489-24.445 25.695-38.453 26.794M256 158.374c-57.955 0-98.331 22.672-98.331 51.939 0 13.74 8.789 29.13 27.467 38.473 17.441 8.657 41.886 11.68 45.32 12.092L256 186.267l25.544 74.611a157.9 157.9 0 0 0 45.32-12.092c18.677-9.343 27.466-24.733 27.466-38.473-.137-29.405-40.376-51.939-98.33-51.939" />
    </Svg>
  );
};

InfinitiLogo.displayName = 'InfinitiLogo';

export default InfinitiLogo;