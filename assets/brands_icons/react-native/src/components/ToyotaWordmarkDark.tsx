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

export interface ToyotaWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * ToyotaWordmarkDark icon component for React Native
 */
const ToyotaWordmarkDark = ({ size, width, height, ...props }: ToyotaWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M255.689 256.5c0-20.156 16.325-36.5 36.459-36.5 20.143 0 36.466 16.344 36.466 36.5 0 20.162-16.326 36.5-36.466 36.5-20.134 0-36.459-16.338-36.459-36.5m36.459 23.116c11.245 0 20.363-10.352 20.363-23.119 0-12.764-9.118-23.116-20.363-23.116s-20.357 10.352-20.357 23.116c0 12.77 9.116 23.119 20.357 23.119m77.84-44.409v56.136h-15.367v-56.136h.055-21.484v-12.691h58.225v12.691zm40.014 40.651-.012.016-5.894 15.472h-17.947l28.367-68.83h19.123L462 291.346h-17.941l-5.894-15.472-.019-.016zm14.075-11.617h9.669l-.006.003-9.598-25.191h-.132l-9.598 25.191-.006-.003zM86.796 235.207v56.136H71.432v-56.136h.055H50v-12.691h58.228v12.691zm25.362 21.293c0-20.156 16.326-36.5 36.466-36.5 20.137 0 36.463 16.344 36.463 36.5 0 20.162-16.326 36.5-36.463 36.5-20.14 0-36.466-16.338-36.466-36.5m36.466 23.116c11.241 0 20.36-10.352 20.36-23.119 0-12.764-9.119-23.116-20.36-23.116-11.244 0-20.36 10.352-20.36 23.116 0 12.77 9.116 23.119 20.36 23.119m71.759 11.727h7.79V265.21l26.804-42.694h-17.941l-16.653 28.93-16.646-28.93h-17.942l26.801 42.694v26.133z" />
    </Svg>
  );
};

ToyotaWordmarkDark.displayName = 'ToyotaWordmarkDark';

export default ToyotaWordmarkDark;