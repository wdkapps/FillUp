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

export interface BYDLogoProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * BYDLogo icon component for React Native
 */
const BYDLogo = ({ size, width, height, ...props }: BYDLogoProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#D9261C" d="M256.165 129C142.467 129 50 185.961 50 256.327c0 69.826 92.467 126.998 206.165 126.998C370.496 383.325 462 326.153 462 256.327 462 185.961 370.496 129 256.165 129m0 24.41c106.322 0 192.311 45.693 192.311 102.917 0 56.697-85.989 102.588-192.311 102.588-105.609 0-191.651-45.891-191.651-102.588 0-57.224 86.042-102.917 191.651-102.917m-147.449 55.417v94.671h24.41v-39.914h41.233v16.824h-35.955v23.09h46.18l13.855-9.566v-31.667l-6.268-5.938 6.268-5.607v-27.049l-12.535-14.844zm99.619 0v46.511l10.225 9.896 22.761-.33v-22.43l-4.288-3.959v-29.687zm69.931 0v29.688l-4.288 3.958h-27.379v61.025h28.368v-38.594l21.441.329 10.226-9.566v-46.84zm38.264 0v94.671h25.729v-70.921h28.039l7.587 8.577v38.924h-30.348v23.42h55.747V225.65L389.1 208.827zm-183.404 23.091h40.903v16.823h-40.903z" />
    </Svg>
  );
};

BYDLogo.displayName = 'BYDLogo';

export default BYDLogo;