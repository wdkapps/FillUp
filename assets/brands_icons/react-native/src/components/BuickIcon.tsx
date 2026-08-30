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

export interface BuickIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * BuickIcon icon component for React Native
 */
const BuickIcon = ({ size, width, height, ...props }: BuickIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#000" d="M255.69 38C135.371 38 38 135.456 38 256.5S135.371 475 256.31 475 474 376.923 474 256.5C474 135.456 376.009 38 255.69 38m0 413.412c-107.295 0-194.743-87.524-194.743-194.912S147.775 60.967 255.69 60.967s194.742 87.525 194.742 194.912c.621 108.009-86.827 195.533-194.742 195.533" /><Path fill="#000" d="M291.679 156.396h-84.84v29.776H122v109.179c0 62.653 48.303 125.927 50.161 129.649 2.477-3.722 35.917-47.766 47.064-99.253 9.908 24.193 22.293 47.765 37.775 69.477 2.477-3.722 35.917-47.765 47.064-99.253 9.908 24.193 22.913 47.766 37.775 69.477C344.317 361.106 392 298.452 392 235.799V126H291.679zm-84.84 140.195c0 47.766-32.201 91.189-34.059 94.911-1.858-3.102-34.679-47.145-34.679-94.911v-94.29h68.738zm84.84-29.776c0 47.766-32.202 91.189-34.06 94.911-1.858-3.102-34.679-47.145-34.679-94.911v-94.91h68.739zm16.101-124.686h68.738v94.91c0 47.766-32.201 91.189-34.679 94.911-1.857-3.101-34.678-46.525-34.678-94.911z" /><Path fill="#000" d="M373 221.345V145h-62l60.76 108c.62-4.966 1.24-14.897 1.24-31.655M364 283.271 311 191v48.303c0 30.344 16.212 64.403 31.176 86.697 9.353-13.624 16.212-27.867 21.824-42.729M288 251.724V176h-62l60.76 108c.62-5.586 1.24-15.517 1.24-32.276M279 312.954 226 220v48.661c0 30.568 16.212 64.88 31.176 87.339 8.73-13.725 15.589-28.073 21.824-43.046M204 281.345V205h-63l61.74 108c.63-4.966 1.26-14.897 1.26-31.655M194 342.89 141 250v48.303c0 30.344 16.212 64.403 31.176 86.697 8.73-13.005 16.212-27.248 21.824-42.11" />
    </Svg>
  );
};

BuickIcon.displayName = 'BuickIcon';

export default BuickIcon;