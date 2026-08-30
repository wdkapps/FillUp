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

export interface MclarenIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * MclarenIcon icon component for React Native
 */
const MclarenIcon = ({ size, width, height, ...props }: MclarenIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#F30" d="M334.697 149.166c18.049-3.179 36.389-3.645 54.613-3.937 18.194-.145 37.147 1.808 53.388 10.76 14.87 6.064 23.063 24.259 17.582 39.596-7.115 23.501-23.968 42.308-41.113 59.161-43.387 44.757-97.212 76.889-148.938 110.887 8.66-12.596 15.774-26.388 21.081-40.646 4.082-11.225 8.048-22.889 8.485-35.047.612-12.451-1.983-25.776-10.001-35.631-8.048-9.097-19.565-14.55-31.082-17.757-16.679-4.724-34.29-5.19-51.58-5.19-39.276.291-78.26 6.677-116.632 14.549-13.5 2.45-26.708 6.532-40.5 7.144 11.692-3.791 21.985-10.613 33.065-16.066 51.726-26.242 105.26-48.985 160.63-66.276 29.712-9.418 60.211-16.241 91.002-21.547" />
    </Svg>
  );
};

MclarenIcon.displayName = 'MclarenIcon';

export default MclarenIcon;