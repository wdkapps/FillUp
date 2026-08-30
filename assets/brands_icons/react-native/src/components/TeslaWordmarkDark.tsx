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

export interface TeslaWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * TeslaWordmarkDark icon component for React Native
 */
const TeslaWordmarkDark = ({ size, width, height, ...props }: TeslaWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M50 229.13c1.2 4.683 5.254 9.468 10.816 10.667h16.81l.858.339v42.418H88.98v-42.418l.953-.339h16.825c5.624-1.449 9.59-5.984 10.77-10.667v-.103H50zM153.891 282.673h39.934c5.556-1.104 9.685-5.999 10.843-10.737h-61.62c1.15 4.739 5.34 9.633 10.843 10.737M153.891 260.915h39.934c5.556-1.095 9.685-5.992 10.843-10.736h-61.62c1.15 4.745 5.34 9.641 10.843 10.736M153.891 239.741h39.934c5.556-1.108 9.685-6 10.843-10.741h-61.62c1.15 4.741 5.34 9.633 10.843 10.741M244.968 239.639h36.893c5.562-1.616 10.233-5.853 11.371-10.55h-58.605v31.661h47.966v11.11l-37.625.03c-5.896 1.644-10.896 5.603-13.39 10.832l3.049-.056h58.272v-32.443h-47.931zM370.518 282.679c5.238-2.22 8.056-6.061 9.135-10.556h-46.596l.03-43.049-10.445.03v53.575zM411.214 239.784h39.947c5.549-1.103 9.675-6 10.839-10.737h-61.623c1.152 4.739 5.339 9.634 10.837 10.737M401.982 250.263v32.396h10.389V261.09h37.811v21.569h10.382v-32.34z" />
    </Svg>
  );
};

TeslaWordmarkDark.displayName = 'TeslaWordmarkDark';

export default TeslaWordmarkDark;