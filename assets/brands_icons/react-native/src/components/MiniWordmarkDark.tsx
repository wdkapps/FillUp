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

export interface MiniWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * MiniWordmarkDark icon component for React Native
 */
const MiniWordmarkDark = ({ size, width, height, ...props }: MiniWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M430.447 188.172v133.61h29.892v-133.61zM282.203 188.172v133.61h27.772v-87.127l59.683 87.127h29.993v-133.61h-27.77v89.224l-60.59-89.224zM223.635 188.172v133.61h29.891v-133.61zM51.662 188.172v133.61H79.43V216.609l29.288 105.173h28.78l29.387-105.173v105.173h27.771v-133.61h-44.839l-26.557 91.139-26.861-91.139z" />
    </Svg>
  );
};

MiniWordmarkDark.displayName = 'MiniWordmarkDark';

export default MiniWordmarkDark;