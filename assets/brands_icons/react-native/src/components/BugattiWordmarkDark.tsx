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

export interface BugattiWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * BugattiWordmarkDark icon component for React Native
 */
const BugattiWordmarkDark = ({ size, width, height, ...props }: BugattiWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <G clipPath="url(#prefix__a)"><Path fill="#fff" d="M72.887 254.071c5.484-5.044 8.747-12.165 8.747-20.473 0-17.061-12.452-29.522-29.65-29.522H21v103.848h33.208c17.642 0 30.539-12.758 30.539-30.412 0-9.94-4.447-18.248-11.86-23.439zm-35.283-33.972h13.787c8.153 0 13.64 5.489 13.64 13.501s-5.485 13.501-13.64 13.501H37.604zm16.01 71.802h-16.01V263.12h16.01c8.599 0 14.529 5.785 14.529 14.39s-5.93 14.391-14.529 14.391m90.876-12.461c0 8.456-6.078 14.539-14.529 14.539-8.45 0-14.528-6.083-14.528-14.539v-75.364H98.829v74.177c0 18.395 13.046 31.747 31.132 31.747s31.133-13.352 31.133-31.747v-74.177H144.49zM210.042 202c-18.087 0-31.133 13.352-31.133 31.747v44.504c0 18.395 13.046 31.747 31.133 31.747s31.133-13.352 31.133-31.747v-30.262h-31.133v16.022h14.529v15.429c0 8.456-6.078 14.539-14.529 14.539-8.45 0-14.529-6.083-14.529-14.539v-46.88c0-8.456 6.079-14.539 14.529-14.539 8.451 0 14.529 6.083 14.529 14.539v2.671h16.604v-1.484c0-18.395-13.046-31.747-31.133-31.747m66.833 2.076-23.869 103.846h16.456l4.744-20.769h28.167l4.744 20.769h16.455l-23.866-103.846zm1.037 67.054 10.377-45.544 10.377 45.544zm48.478-51.031h22.831l.148 87.825h16.307l.149-87.825h22.829v-16.023H326.39zm70.891 0h22.831l.149 87.825h16.307l.148-87.825h22.829v-16.023h-62.264zm77.115-16.023H491v103.846h-16.604z" /></G><Defs><ClipPath id="prefix__a"><Path fill="#fff" d="M21 202h470v108H21z" /></ClipPath></Defs>
    </Svg>
  );
};

BugattiWordmarkDark.displayName = 'BugattiWordmarkDark';

export default BugattiWordmarkDark;