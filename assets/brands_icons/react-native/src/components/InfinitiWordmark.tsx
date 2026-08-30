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

export interface InfinitiWordmarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * InfinitiWordmark icon component for React Native
 */
const InfinitiWordmark = ({ size, width, height, ...props }: InfinitiWordmarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#231F20" d="M123.787 233.137v38.061l-12.91-36.687c-.274-.961-.961-1.374-2.334-1.374H96.595v46.306h8.24v-37.649l12.772 36.137c.274.962 1.098 1.374 2.06 1.374h12.36V233h-8.24zm42.573 0v46.306h9.613v-19.787h17.167v-8.519h-17.167v-9.618h17.442V233H166.36zm220.145 0v8.932h10.575v37.374h9.613v-37.512h10.575V233h-30.9zm-159.718 46.306h10.3v-46.306h-10.3zm116.733 0h10.3v-46.306h-10.3zm106.433 0h10.163v-46.306h-10.163zm-398.953 0h10.3v-46.306H51zm257.225-46.306h-8.24v38.061l-12.909-36.687c-.275-.961-.961-1.374-2.197-1.374h-12.086v46.306h8.24v-37.649l12.772 36.137c.275.962 1.099 1.374 2.06 1.374h12.36V233z" />
    </Svg>
  );
};

InfinitiWordmark.displayName = 'InfinitiWordmark';

export default InfinitiWordmark;