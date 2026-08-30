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

export interface KiaLogoProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * KiaLogo icon component for React Native
 */
const KiaLogo = ({ size, width, height, ...props }: KiaLogoProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#000" d="M288.344 292.485c0 .751.205 1.16.685 1.16.346-.02.679-.138.96-.341l123.673-80.095a11.94 11.94 0 0 1 7.129-2.185h27.216c4.182 0 6.993 2.8 6.993 6.965v51.689c0 6.214-1.371 9.833-6.993 13.179l-32.974 19.733a2.2 2.2 0 0 1-1.097.41c-.412 0-.754-.273-.754-1.434v-60.361c0-.683-.206-1.161-.686-1.161-.346.02-.679.139-.96.341l-90.423 58.518a11.83 11.83 0 0 1-6.924 2.117h-59.986c-4.181 0-6.992-2.8-6.992-6.965v-74.427c0-.547-.274-1.024-.686-1.024-.346.02-.679.138-.959.341l-59.643 35.711c-.617.342-.754.683-.754.956s.068.478.548.888l42.573 42.403c.548.546.96 1.024.96 1.434s-.617.751-1.372.751h-38.527c-3.017 0-5.348-.478-6.993-2.117l-25.845-25.742a1.06 1.06 0 0 0-.754-.41 2.3 2.3 0 0 0-.823.274l-43.189 25.878a12 12 0 0 1-6.993 2.049H64.993c-4.182 0-6.993-2.8-6.993-6.965v-50.733c0-6.282 1.371-9.833 6.993-13.179l33.18-19.87c.265-.174.574-.269.891-.273.48 0 .754.546.754 1.639v67.872c0 .683.206 1.024.686 1.024.348-.059.676-.2.96-.409l112.087-67.122a12.42 12.42 0 0 1 7.403-2.048h60.329c4.181 0 6.992 2.8 6.992 6.965z" />
    </Svg>
  );
};

KiaLogo.displayName = 'KiaLogo';

export default KiaLogo;