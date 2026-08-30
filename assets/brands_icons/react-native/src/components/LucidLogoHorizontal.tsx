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

export interface LucidLogoHorizontalProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * LucidLogoHorizontal icon component for React Native
 */
const LucidLogoHorizontal = ({ size, width, height, ...props }: LucidLogoHorizontalProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#000" d="M123.479 262.858H66.273c-5.122 0-7.4-2.304-7.4-7.252v-11.043H50v11.043c0 7.147 6.194 11.084 12.106 11.084h61.373zm92.338-18.295v18.295H163.52c-5.121 0-7.399-2.304-7.399-7.252v-11.043h-8.876v11.043c0 7.147 6.194 11.084 12.108 11.084h65.341v-22.127zm109.329 18.295h-60.308c-5.121 0-7.399-2.304-7.399-7.252 0-4.987 2.278-7.212 7.399-7.212h60.308v-3.831h-64.475c-5.913 0-12.108 3.921-12.108 11.043 0 7.147 6.194 11.084 12.108 11.084h64.475zm124.747-18.295c5.91 0 12.107 3.921 12.107 11.043 0 7.147-6.196 11.084-12.107 11.084h-66.218v-22.127zm3.232 11.043c0-4.987-2.277-7.212-7.399-7.212H392.55v14.463h53.176c5.122 0 7.399-2.303 7.399-7.251m-103.041 11.685h8.64V244h-8.64z" />
    </Svg>
  );
};

LucidLogoHorizontal.displayName = 'LucidLogoHorizontal';

export default LucidLogoHorizontal;