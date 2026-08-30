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

export interface RivianWordmarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * RivianWordmark icon component for React Native
 */
const RivianWordmark = ({ size, width, height, ...props }: RivianWordmarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#000" d="M469 227h-12.051v43.081L422.128 227h-14.292v57.995h12.051v-43.08l34.816 43.08H469zm-117.061 0h-13.297l-28.585 57.989h13.296l3.575-7.453c1.493-3.147 3.822-4.559 7.314-4.559h21.608l-2.577-5.467c-1.579-3.399-4.156-4.969-7.975-4.969h-11.05l11.05-22.865 21.936 45.314h13.299zm-69.151 0H270.32v57.989h12.468zm-39.961 0h-13.296l-21.108 44.904L187.312 227h-13.295l27.756 57.995h13.297zm-96.08 0h-12.468v57.989h12.468zm-44.821 19.308c0-9.774-6.649-19.302-20.945-19.302H44v57.989h12.468v-47.553h22.69c6.983 0 10.305 3.399 10.305 8.866 0 5.549-3.327 8.948-10.305 8.948h-9.652c-4.373 0-6.83 2.449-6.83 6.809v3.633H69.6c3.239 0 5.65 1.078 7.648 3.645L89.545 285h15.289l-17.117-21.705c9.14-2.08 14.209-8.045 14.209-16.987" />
    </Svg>
  );
};

RivianWordmark.displayName = 'RivianWordmark';

export default RivianWordmark;