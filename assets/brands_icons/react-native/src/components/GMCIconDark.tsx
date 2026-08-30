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

export interface GMCIconDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * GMCIconDark icon component for React Native
 */
const GMCIconDark = ({ size, width, height, ...props }: GMCIconDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M50 236.924c0-13.679 8.504-22.908 24.588-22.908h104.384v19.397H77.719c-2.834 0-5.356 1.451-5.356 5.735v32.334c0 3.922 1.648 6.46 6.823 6.46h71.309c3.757 0 6.658-1.334 6.658-6.278v-7.565h-41.744v-18.474h63.563v29.714c0 14.222-10.349 22-26.598 22H74.753c-15.705 0-24.753-8.503-24.753-22.742zm222.084 60.415 35.663-63.2v63.2h22.347v-83.323h-34.377l-33.998 59.839L227.72 214h-34.36v83.323h22.346v-63.184l35.663 63.2zm189.916 0h-93.475c-15.738 0-24.753-8.503-24.753-22.726v-37.689c0-13.679 8.471-22.908 24.556-22.908H462v20.947h-90.525c-2.834 0-5.372 1.433-5.372 5.718v29.252c0 3.939 1.664 6.46 6.839 6.46H462z" />
    </Svg>
  );
};

GMCIconDark.displayName = 'GMCIconDark';

export default GMCIconDark;