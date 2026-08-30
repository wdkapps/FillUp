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

export interface VolvoLogoDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * VolvoLogoDark icon component for React Native
 */
const VolvoLogoDark = ({ size, width, height, ...props }: VolvoLogoDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M238.627 269.528h43.147v-14.382h-4.699c0 5.554-3.987 9.541-10.253 9.541h-6.55v-21.503h7.12v-4.841h-28.765v4.841h7.262v21.503h-7.262zM302.565 269.528h16.803l14.382-26.344h7.12v-4.841h-21.502v4.841h6.266l-10.538 19.224-10.395-19.224h7.547v-4.841H280.92v4.841h7.12zM152.618 238.343h-31.186v4.841h7.12l14.525 26.344h16.803l14.24-26.344h7.12v-4.841h-21.502v4.841h6.265l-10.395 19.224-10.537-19.224h7.547zM185.512 254.006c0 9.114 7.405 16.519 22.215 16.519s22.072-7.263 22.072-16.519c0-9.113-7.69-16.233-22.215-16.233-14.382-.143-22.072 7.12-22.072 16.233m29.762 0c-.143 5.696-2.421 11.535-7.832 11.392-5.269-.142-7.547-5.981-7.547-11.677.142-5.98 2.99-11.249 7.974-11.107 4.984 0 7.547 5.411 7.405 11.392M345 254.006c0 9.114 7.405 16.519 22.214 16.519 14.81 0 22.072-7.263 22.072-16.519 0-9.113-7.689-16.233-22.214-16.233-14.382-.143-22.072 7.12-22.072 16.233m22.357-11.392c4.984.143 7.547 5.411 7.405 11.392-.143 5.696-2.421 11.535-7.832 11.392-5.269-.142-7.548-5.981-7.548-11.677.143-5.98 2.991-11.249 7.975-11.107" /><Path fill="#fff" d="m402.53 154.896-18.085 18.085c15.521 23.923 24.493 52.403 24.493 83.019 0 84.443-68.495 152.938-152.938 152.938S103.062 340.443 103.062 256 171.557 103.062 256 103.062c30.758 0 59.238 9.114 83.162 24.636l18.084-18.085C328.624 89.677 293.594 78 256 78c-98.256 0-178 79.744-178 178s79.744 178 178 178 178-79.744 178-178c0-37.594-11.677-72.482-31.47-101.104" /><Path fill="#fff" d="M345.569 84.978v4.984c10.823 5.838 20.933 12.816 30.332 20.505l-25.348 25.347c9.541 7.548 18.228 16.092 25.775 25.632l25.347-25.347c7.832 9.399 14.667 19.651 20.506 30.189h4.841v-81.31z" />
    </Svg>
  );
};

VolvoLogoDark.displayName = 'VolvoLogoDark';

export default VolvoLogoDark;