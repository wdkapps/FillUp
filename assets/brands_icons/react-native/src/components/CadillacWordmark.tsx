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

export interface CadillacWordmarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * CadillacWordmark icon component for React Native
 */
const CadillacWordmark = ({ size, width, height, ...props }: CadillacWordmarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#000" d="M23.087 274.357q-6.85-2.754-10.468-7.639-3.62-4.886-3.619-11.163-.001-6.276 3.619-11.162 3.618-4.886 10.468-7.639T39.267 234q15.911 0 26.798 7.698v1.421l-2.87 3.494q-10.29-7.52-23.928-7.52-7.418 0-12.86 1.954-5.444 1.954-8.375 5.685t-2.93 8.823q0 5.094 2.93 8.824t8.375 5.685q5.442 1.954 12.86 1.954 6.819 0 12.532-1.895 5.712-1.894 11.336-5.744l2.93 3.494v1.421q-5.384 3.791-11.873 5.803-6.491 2.014-14.925 2.014-9.33 0-16.18-2.754M108.117 239.804l-13.459 20.844h28.354l-13.459-20.844zm-3.11-4.975h7.657l26.678 40.031v1.422h-6.221l-6.82-10.541H91.368l-6.819 10.541h-6.22v-1.422zM176.369 271.189q12.98 0 19.171-3.731t6.191-11.902q0-8.173-6.191-11.904-6.192-3.73-19.171-3.73h-16.151v31.267zm-22.133 5.093v-41.453h23.329q15.014 0 22.641 5.211t7.626 15.516q0 10.303-7.626 15.515-7.628 5.211-22.641 5.211zM230.861 276.282h-5.982v-41.453h5.982zM256.282 234.829v36.36h41.513l-2.033 5.093h-45.461v-41.453zM321.542 234.829v36.36h41.513l-2.034 5.093h-45.46v-41.453zM406.062 239.804l-13.459 20.844h28.354l-13.459-20.844zm-3.11-4.975h7.657l26.678 40.031v1.422h-6.221l-6.819-10.541h-34.934l-6.819 10.541h-6.221v-1.422zM460.289 274.357q-6.85-2.754-10.469-7.639-3.62-4.886-3.619-11.163 0-6.276 3.619-11.162 3.618-4.886 10.469-7.639 6.847-2.754 16.18-2.754 15.91 0 26.798 7.698v1.421l-2.872 3.494q-10.288-7.52-23.926-7.52-7.419 0-12.861 1.954-5.444 1.954-8.374 5.685-2.932 3.731-2.932 8.823 0 5.094 2.932 8.824 2.93 3.73 8.374 5.685 5.442 1.954 12.861 1.954 6.819 0 12.531-1.895 5.712-1.894 11.336-5.744l2.931 3.494v1.421q-5.384 3.791-11.874 5.803-6.49 2.014-14.924 2.014-9.333 0-16.18-2.754" />
    </Svg>
  );
};

CadillacWordmark.displayName = 'CadillacWordmark';

export default CadillacWordmark;