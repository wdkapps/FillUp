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

export interface VolvoWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * VolvoWordmarkDark icon component for React Native
 */
const VolvoWordmarkDark = ({ size, width, height, ...props }: VolvoWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M50 229.446v7.564h12.339l24.147 45.537H116.2l24.146-45.612 12.337-.078.027-7.411h-36.913v7.436h9.83l-17.051 32.374-18.44-32.261 13.45-.06-.024-7.489zM288.139 229.446v7.564h12.335l24.147 45.537h29.715l24.147-45.612 12.338-.078.023-7.411h-36.907v7.436h9.826l-17.05 32.374-18.443-32.261 13.454-.06-.025-7.489zM227.425 229.446v7.564h12.337l.021 37.177h-13.007v8.287l13.015.074h61.601V257.83h-8.025c-.439 13.087-11.729 16.375-16.485 16.375-4.357 0-12.8-.017-12.8-.017v-37.193l12.151-.061-.016-7.489zM185.346 275.747c-7.393 0-13.383-8.904-13.383-19.895 0-10.993 5.99-19.904 13.383-19.904 7.391 0 13.383 8.911 13.383 19.904 0 10.991-5.992 19.895-13.383 19.895m.544-47.827c-20.971 0-37.971 12.557-37.971 28.041S164.919 284 185.89 284c20.969 0 37.971-12.555 37.971-28.039s-17.002-28.041-37.971-28.041M423.486 275.606c-7.391 0-13.38-9.053-13.38-20.225 0-11.167 5.99-20.222 13.38-20.222s13.379 9.055 13.379 20.222c.001 11.172-5.988 20.225-13.379 20.225m.546-48.606c-20.975 0-37.97 12.761-37.97 28.497s16.994 28.495 37.97 28.495C445 283.992 462 271.233 462 255.497S445 227 424.032 227" />
    </Svg>
  );
};

VolvoWordmarkDark.displayName = 'VolvoWordmarkDark';

export default VolvoWordmarkDark;