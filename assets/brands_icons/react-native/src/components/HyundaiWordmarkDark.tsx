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

export interface HyundaiWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * HyundaiWordmarkDark icon component for React Native
 */
const HyundaiWordmarkDark = ({ size, width, height, ...props }: HyundaiWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M423.155 237.028h-24.317c-4.082.243-5.222 1.262-5.222 6.253v13.757h29.539zm12.948-11.017V286h-12.948v-17.244h-29.539V286h-12.948v-47.029c0-8.309 3.342-12.96 12.948-12.96zm-68.381 12.949v32.465c0 10.335-5.764 14.564-12.949 14.564h-40.84V226h40.84c11.029 0 12.949 7.063 12.949 12.96m-13.103 3.61c0-3.286-1.989-5.554-5.471-5.554h-22.266v37.483l22.266-.002c5.072-.259 5.471-3.322 5.471-5.752zM50 226h12.948v23.645h28.968V226h12.948v59.987H91.916v-24.48H62.948v24.48H50zm77.055 0 16.231 24.524L159.323 226h15.722l-25.291 38.352v21.637h-12.949v-21.64L111.338 226zm120.67 0h41.724c5.946 0 11.704.841 11.536 12.96v47.029h-12.948v-42.72c0-5.166-.615-6.253-4.639-6.253h-22.722v48.973h-12.951zm214.275.011V286h-12.951v-59.989zm-280.48 59.978h41.721c8.295 0 11.706-2.417 11.538-14.463V226h-12.948v42.824c0 5.134-.615 5.757-4.64 5.757H194.47L194.468 226H181.52z" />
    </Svg>
  );
};

HyundaiWordmarkDark.displayName = 'HyundaiWordmarkDark';

export default HyundaiWordmarkDark;