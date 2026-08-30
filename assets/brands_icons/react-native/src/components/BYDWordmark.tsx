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

export interface BYDWordmarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * BYDWordmark icon component for React Native
 */
const BYDWordmark = ({ size, width, height, ...props }: BYDWordmarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Mask id="prefix__a" width={412} height={84} x={50} y={214} maskUnits="userSpaceOnUse" style={{
    maskType: "luminance"
  }}><Path fill="#fff" d="M50 214h412v83.192H50z" /></Mask><G mask="url(#prefix__a)"><Path fill="#D70C19" d="M142.938 215.494c-6.418-.119-34.268-.199-50.51-.199H50v15.252c34.149 0 74.675-.079 92.423.198 3.169.04 6.299.357 8.794 2.575 2.338 2.06 3.13 5.309 2.1 8.122-1.664 4.555-6.299 5.665-10.894 5.744-7.052.119-26.345.158-40.765.158-35.376.04-20.045 0-51.658 0v15.213c34.149 0 74.754-.08 92.423.198 5.506.079 11.33 1.98 11.33 8.16s-5.824 8.161-11.33 8.24c-17.629.278-58.274.198-92.423.198v15.252c34.267 0 79.112.119 92.938-.198 7.289-.158 18.104-2.02 24.363-11.528 5.903-8.913 4.477-20.52-3.288-27.929 7.765-7.447 9.191-19.055 3.288-27.928-6.299-9.508-17.074-11.33-24.363-11.528m272.237.229c-9.033-.198-22.7-.317-34.743-.356-29.395-.119-11.726-.079-39.734-.079v15.291c29.83 0 50.707-.238 73.724.396 6.774.198 14.024.911 20.56 5.428 6.18 4.278 9.865 11.131 9.865 18.5s-3.566 14.222-9.746 18.54c-6.536 4.516-13.786 5.229-20.56 5.427-23.017.634-43.934.396-73.724.396l-.119 15.292c29.989 0 51.539.119 74.477-.436 9.19-.198 20.481-1.268 30.939-8.755 9.904-7.091 15.886-18.223 15.886-30.504 0-12.28-5.982-23.412-15.886-30.504v.119c-10.419-7.487-21.749-8.557-30.939-8.755m-208.258 23.104c-.04-7.368 0-16.084 0-23.532h-17.629c0 7.527-.159 22.819.158 30.227.594 14.341 5.269 18.817 19.927 19.332 10.181.357 18.223.238 32.286.198v-15.37c-11.251 0-15.846 0-24.165-.119-8.002-.159-10.538-2.773-10.577-10.736m65.206 10.855c8.24 0 18.303-.04 22.106-.119 8.002-.159 10.538-2.694 10.577-10.459h.119v-23.809h17.589v23.136c-.039 2.694-.079 5.15-.158 7.091-.594 14.46-5.309 18.857-20.878 19.332-5.07.198-18.54.198-29.315.198h-2.1v29.553h-20.718v-44.923z" /></G>
    </Svg>
  );
};

BYDWordmark.displayName = 'BYDWordmark';

export default BYDWordmark;