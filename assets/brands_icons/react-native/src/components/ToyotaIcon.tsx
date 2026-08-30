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

export interface ToyotaIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * ToyotaIcon icon component for React Native
 */
const ToyotaIcon = ({ size, width, height, ...props }: ToyotaIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#D71920" d="M244.847 360.114c-18.661-11.691-32.416-52.035-32.416-99.98 0-1.759.007-3.496.052-5.226l.014.022c-51.916-8.158-89.425-30.508-90.389-56.949l-.149.312c-12.701 15.789-19.953 34.042-19.953 53.49 0 57.231 62.821 104.123 142.507 108.272zM78 255.955C78 191.924 157.693 140 255.996 140 354.307 140 434 191.924 434 255.955c0 64.038-79.693 115.962-178.004 115.962C157.693 371.917 78 319.993 78 255.955m178.004-99.224c18.98 0 35.125 28.794 41.108 68.968l.015-.067c36.93-5.746 62.777-19.003 62.777-34.436 0-20.702-46.52-37.471-103.9-37.471-57.373 0-103.893 16.769-103.893 37.471 0 15.433 25.847 28.683 62.769 34.436l.023.067c5.982-40.174 22.128-68.968 41.101-68.968m11.491 203.317c79.685-4.15 142.514-51.041 142.514-108.272 0-19.449-7.26-37.702-19.953-53.491l-.156-.311c-.958 26.44-38.466 48.791-90.39 56.949l.022-.022c.037 1.729.052 3.466.052 5.226 0 47.945-13.762 88.289-32.416 99.98zm-11.491-131.373a282 282 0 0 0 24.681-1.054l-.007.008c-3.934-25.743-13.495-43.922-24.667-43.922-11.171 0-20.725 18.179-24.667 43.922l-.007-.008a284 284 0 0 0 24.667 1.054m0 95.356c14.289 0 25.951-29.736 26.567-67.022l.074.022a290.3 290.3 0 0 1-53.275 0l.074-.022c.616 37.286 12.27 67.022 26.56 67.022" />
    </Svg>
  );
};

ToyotaIcon.displayName = 'ToyotaIcon';

export default ToyotaIcon;