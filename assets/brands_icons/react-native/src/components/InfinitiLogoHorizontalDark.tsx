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

export interface InfinitiLogoHorizontalDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * InfinitiLogoHorizontalDark icon component for React Native
 */
const InfinitiLogoHorizontalDark = ({ size, width, height, ...props }: InfinitiLogoHorizontalDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M136.317 265.934 118 241.298l-18.317 24.636c-6.186-.601-16.816-4.627-16.816-11.777 0-9.013 15.615-17.425 35.193-17.425 20.599 0 35.193 8.412 35.193 17.425 0 7.21-10.69 11.236-16.816 11.717M118 234.088c-25.344 0-43 9.914-43 22.713 0 6.008 3.844 12.738 12.011 16.824 7.627 3.786 18.317 5.108 19.819 5.288L118 246.286l11.17 32.627a69 69 0 0 0 19.819-5.288c8.167-4.086 12.011-10.816 12.011-16.824-.06-12.859-17.656-22.713-43-22.713M232.45 242.086v23.766l-8.061-22.908c-.172-.601-.6-.858-1.458-.858h-7.461V271h5.146v-23.509l7.975 22.565c.171.601.686.858 1.286.858h7.718V242h-5.145zm26.584 0V271h6.002v-12.355h10.72v-5.32h-10.72v-6.005h10.891V242h-16.893zm137.464 0v5.577h6.603V271h6.003v-23.423h6.603V242h-19.295zM296.766 271h6.431v-28.914h-6.431zm72.891 0h6.431v-28.914h-6.431zm66.459 0h6.346v-28.914h-6.346zM187 271h6.432v-28.914H187zm160.618-28.914h-5.145v23.766l-8.061-22.908c-.172-.601-.601-.858-1.372-.858h-7.547V271h5.145v-23.509l7.976 22.565c.171.601.686.858 1.286.858h7.718V242z" />
    </Svg>
  );
};

InfinitiLogoHorizontalDark.displayName = 'InfinitiLogoHorizontalDark';

export default InfinitiLogoHorizontalDark;