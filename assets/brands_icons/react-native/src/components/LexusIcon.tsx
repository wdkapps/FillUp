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

export interface LexusIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * LexusIcon icon component for React Native
 */
const LexusIcon = ({ size, width, height, ...props }: LexusIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#000" d="M260.853 121.614c6.487.179 5.798 4.717 4.725 6.282-19.143 29.649-64.376 81.855-97.311 139.134-5.453 9.281-9.513 16.109-9.513 26.294 0 13.808 8.658 30.133 26.051 37.139 11.442 4.563 18.645 4.703 30.993 4.881 91.68 2.823 128.433.356 210.471-2.415 4.738-.013 9.143-3.191 10.727-5.111C452.857 311.352 462 281.753 462 255.637c0-58.168-42.078-110.564-107.719-135.764l-10.535 13.452c57.531 23.674 87.261 70.959 87.261 121.6 0 11.393-1.942 22.429-5.454 32.969-2.604 7.349-5.81 11.57-15.133 11.71-66.853 1.424-104.705 2.466-171.737.712-8.646-.178-11.442-3.318-12.847-10.134-1.073-4.043-.178-7.4 2.619-12.472 35.552-62.708 97.489-134.379 109.647-151.379 2.311-3.14 1.225-9.472-6.706-11.569-23.204-6.828-49.241-9.6-75.639-9.6C136.239 105.645 51.941 172.573 50 255.637c4.79 99.708 91.87 151.201 205.757 151.201 69.689 0 133.528-24.527 170.882-63.42l-34.506 1.386c-31.862 28.213-82.906 43.293-135.699 43.293-96.225 0-174.572-47.642-174.572-133.172 0-73.565 78.334-133.489 174.572-133.489z" />
    </Svg>
  );
};

LexusIcon.displayName = 'LexusIcon';

export default LexusIcon;