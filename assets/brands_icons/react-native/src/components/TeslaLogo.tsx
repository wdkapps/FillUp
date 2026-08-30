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

export interface TeslaLogoProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * TeslaLogo icon component for React Native
 */
const TeslaLogo = ({ size, width, height, ...props }: TeslaLogoProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#E82127" d="M117 400.189c.812 3.167 3.554 6.404 7.316 7.215h11.37l.58.229v28.691h7.1v-28.691l.645-.229h11.38c3.804-.98 6.487-4.048 7.285-7.215v-.07H117zM187.271 436.405h27.011c3.758-.747 6.551-4.058 7.334-7.263h-41.679c.778 3.206 3.612 6.516 7.334 7.263M187.271 421.688h27.011c3.758-.741 6.551-4.053 7.334-7.262h-41.679c.778 3.21 3.612 6.521 7.334 7.262M187.271 407.366h27.011c3.758-.749 6.551-4.058 7.334-7.265h-41.679c.778 3.207 3.612 6.516 7.334 7.265M248.874 407.297h24.954c3.762-1.093 6.921-3.959 7.691-7.136h-39.64v21.415h32.444v7.515l-25.449.02c-3.988 1.112-7.37 3.79-9.057 7.327l2.062-.038h39.415v-21.944h-32.42zM333.795 436.409c3.543-1.502 5.449-4.1 6.179-7.14h-31.517l.02-29.118-7.065.02v36.238zM361.321 407.395h27.02c3.753-.746 6.544-4.058 7.331-7.262h-41.681c.779 3.205 3.611 6.516 7.33 7.262M355.077 414.483v21.912h7.027v-14.589h25.575v14.589h7.022v-21.874zM256.35 328.502l35.476-199.519c33.815 0 44.481 3.708 46.021 18.843 0 0 22.684-8.458 34.125-25.636-44.646-20.688-89.505-21.621-89.505-21.621l-26.176 31.882.059-.004-26.176-31.883s-44.86.934-89.5 21.622c11.431 17.178 34.124 25.636 34.124 25.636 1.549-15.136 12.202-18.844 45.79-18.868z" /><Path fill="#E82127" d="M256.336 91.36c36.09-.276 77.399 5.583 119.687 24.014 5.652-10.173 7.105-14.669 7.105-14.669C336.901 82.416 293.61 76.157 256.331 76c-37.277.157-80.566 6.417-126.787 24.705 0 0 2.062 5.538 7.1 14.669 42.28-18.431 83.596-24.29 119.687-24.014z" />
    </Svg>
  );
};

TeslaLogo.displayName = 'TeslaLogo';

export default TeslaLogo;