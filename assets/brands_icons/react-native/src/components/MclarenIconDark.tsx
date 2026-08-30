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

export interface MclarenIconDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * MclarenIconDark icon component for React Native
 */
const MclarenIconDark = ({ size, width, height, ...props }: MclarenIconDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M334.697 149.165c18.049-3.178 36.389-3.644 54.613-3.936 18.194-.146 37.147 1.808 53.388 10.759 14.87 6.065 23.063 24.26 17.582 39.597-7.115 23.501-23.968 42.308-41.113 59.161-43.387 44.757-97.212 76.889-148.938 110.887 8.66-12.596 15.774-26.388 21.081-40.646 4.082-11.226 8.048-22.889 8.485-35.048.612-12.45-1.983-25.775-10.001-35.63-8.048-9.098-19.565-14.55-31.082-17.758-16.679-4.723-34.29-5.19-51.58-5.19-39.276.292-78.26 6.677-116.632 14.55-13.5 2.449-26.708 6.531-40.5 7.144 11.692-3.791 21.985-10.614 33.065-16.066 51.726-26.242 105.26-48.985 160.63-66.276 29.712-9.418 60.211-16.241 91.002-21.548" />
    </Svg>
  );
};

MclarenIconDark.displayName = 'MclarenIconDark';

export default MclarenIconDark;