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

export interface FiatWordmarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * FiatWordmark icon component for React Native
 */
const FiatWordmark = ({ size, width, height, ...props }: FiatWordmarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <G clipPath="url(#prefix__a)"><Path fill="#000" d="M195.144 159h27.83v194h-27.83zm119.303 0v23.408h21.577V353h26.964V182.408h21.226V159zM128 353h26.965v-88.012h22.965v-23.087h-22.965v-59.493h29.959V159H128zm190.022-12.708q.009 6.377.007 12.708h-25.222q-.033-11.009-.05-22.126c-.02-7.401-.055-14.814-.135-22.202-.16-14.761-.498-29.464-1.27-43.684h-29.665V353h-24.218V159h56.905a145 145 0 0 1 8.741 20.731 204 204 0 0 1 6.086 22.461c1.653 7.723 2.967 15.686 4.024 23.789 1.057 8.101 1.86 16.388 2.481 24.75.621 8.358 1.063 16.86 1.384 25.371.322 8.502.527 17.125.661 25.683.135 8.537.202 17.211.237 25.716q.027 6.411.034 12.791m-28.388-98.391c-2.167-22.182-5.885-42.713-12.322-59.493h-15.625v59.493z" /></G><Defs><ClipPath id="prefix__a"><Path fill="#fff" d="M128 159h256.214v194H128z" /></ClipPath></Defs>
    </Svg>
  );
};

FiatWordmark.displayName = 'FiatWordmark';

export default FiatWordmark;