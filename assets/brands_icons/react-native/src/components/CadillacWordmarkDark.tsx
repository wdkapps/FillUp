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

export interface CadillacWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * CadillacWordmarkDark icon component for React Native
 */
const CadillacWordmarkDark = ({ size, width, height, ...props }: CadillacWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M23.087 274.358q-6.85-2.755-10.468-7.64-3.62-4.885-3.619-11.162-.001-6.278 3.619-11.163 3.618-4.885 10.468-7.639T39.267 234q15.911 0 26.798 7.698v1.422l-2.87 3.494q-10.29-7.52-23.928-7.521-7.418 0-12.86 1.954-5.445 1.954-8.375 5.685t-2.93 8.824q0 5.093 2.93 8.824t8.375 5.684q5.442 1.955 12.86 1.955 6.819 0 12.532-1.896 5.712-1.893 11.336-5.743l2.93 3.493v1.421q-5.384 3.79-11.873 5.804-6.491 2.012-14.925 2.013-9.33 0-16.18-2.753M108.117 239.804l-13.459 20.845h28.354l-13.459-20.845zm-3.11-4.975h7.657l26.678 40.032v1.421h-6.221l-6.82-10.54H91.368l-6.819 10.54h-6.22v-1.421zM176.369 271.189q12.98 0 19.171-3.73t6.191-11.903-6.191-11.903q-6.192-3.73-19.171-3.731h-16.151v31.267zm-22.133 5.093v-41.453h23.329q15.014 0 22.641 5.211t7.626 15.516q0 10.304-7.626 15.515-7.628 5.212-22.641 5.211zM230.861 276.282h-5.982v-41.453h5.982zM256.282 234.829v36.36h41.513l-2.033 5.093h-45.461v-41.453zM321.542 234.829v36.36h41.513l-2.034 5.093h-45.46v-41.453zM406.062 239.804l-13.459 20.845h28.354l-13.459-20.845zm-3.11-4.975h7.657l26.678 40.032v1.421h-6.221l-6.819-10.54h-34.934l-6.819 10.54h-6.221v-1.421zM460.289 274.358q-6.85-2.755-10.469-7.64-3.62-4.885-3.619-11.162t3.619-11.163q3.618-4.885 10.469-7.639 6.847-2.754 16.18-2.754 15.91 0 26.798 7.698v1.422l-2.872 3.494q-10.288-7.52-23.926-7.521-7.419 0-12.861 1.954-5.444 1.954-8.374 5.685-2.932 3.731-2.932 8.824t2.932 8.824q2.93 3.73 8.374 5.684 5.442 1.955 12.861 1.955 6.819 0 12.531-1.896 5.712-1.893 11.336-5.743l2.931 3.493v1.421q-5.384 3.79-11.874 5.804-6.49 2.012-14.924 2.013-9.333 0-16.18-2.753" />
    </Svg>
  );
};

CadillacWordmarkDark.displayName = 'CadillacWordmarkDark';

export default CadillacWordmarkDark;