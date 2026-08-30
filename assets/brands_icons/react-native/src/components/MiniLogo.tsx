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

export interface MiniLogoProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * MiniLogo icon component for React Native
 */
const MiniLogo = ({ size, width, height, ...props }: MiniLogoProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#120A08" d="M320.359 231.063v49.122h11.028v-49.122zM265.667 231.063v49.122h10.246v-32.032l22.019 32.032h11.065v-49.122h-10.245v32.803l-22.354-32.803zM244.06 231.063v49.122h11.027v-49.122zM180.613 231.063v49.122h10.244v-38.667l10.806 38.667h10.617l10.842-38.667v38.667h10.246v-49.122h-16.542l-9.798 33.507-9.91-33.507z" /><Path fill="#120A08" d="M256 146a109.62 109.62 0 0 0-92.393 50.652H6l15.69 15.69h133.73a109.6 109.6 0 0 0-6.02 18.281H39.969l15.5 15.498h91.394q-.45 4.742-.486 9.504c.028 2.93.174 5.859.437 8.777H73.75L89.248 279.9h59.951a109.7 109.7 0 0 0 5.781 18.28h-47.453l15.69 15.691h40.068A109.63 109.63 0 0 0 256 365.248a109.63 109.63 0 0 0 92.715-51.377h40.066l15.692-15.691H357.02a109.7 109.7 0 0 0 5.781-18.28h59.951l15.498-15.498h-73.065c.264-2.918.41-5.847.438-8.777a110 110 0 0 0-.484-9.504h91.392l15.5-15.498H362.6a109.6 109.6 0 0 0-6.02-18.281h133.73l15.69-15.69H348.393A109.64 109.64 0 0 0 256 146m0 14.859a94.766 94.766 0 1 1-67.01 161.776 94.77 94.77 0 0 1 0-134.02A94.77 94.77 0 0 1 256 160.859" />
    </Svg>
  );
};

MiniLogo.displayName = 'MiniLogo';

export default MiniLogo;