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

export interface SubaruWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * SubaruWordmarkDark icon component for React Native
 */
const SubaruWordmarkDark = ({ size, width, height, ...props }: SubaruWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M120.03 230.003h14.669v35.239c0 3.24 1.862 4.55 5.004 4.55h24.986c3.137 0 5.004-1.31 5.004-4.55v-35.239h14.661v37.552c0 7.97-6.833 14.008-14.665 14.008h-34.994c-7.798 0-14.669-6.073-14.669-14.008v-37.552zM50.489 265.658h14.596c.24 2.935 1.965 4.138 4.866 4.138H96.77c2.485 0 3.863-2.134 3.863-4.451 0-3.103-2.275-4.729-5.21-4.729H66.188c-9.63 0-16.188-4.695-16.188-14.84 0-5.279 2.073-10.871 6.767-13.703 2.932-1.798 6.52-2.073 9.905-2.073h34.441c7.458 0 13.459 5.279 13.39 12.871v2.725H99.426c-.138-2.347-1.52-3.863-4-3.863H69.99c-2.588 0-4.764 1.31-4.764 4.176 0 2.832 2.21 3.901 4.73 3.901h31.165c10.076 0 15.29 6.733 15.29 16.535 0 9.386-4.351 15.215-14.084 15.215H65.089c-8.493 0-14.497-3.413-14.566-12.455zM397.642 230.003h14.703v35.239c0 3.24 1.867 4.55 5.004 4.55h24.982c3.138 0 5.005-1.31 5.005-4.55v-35.239H462v37.552c0 7.931-6.866 14.008-14.664 14.008h-34.998c-7.833 0-14.703-6.038-14.703-14.008zM273.915 271.383l-5.764 10.176h-16.287l27.99-51.556h19.154l27.993 51.556h-16.294l-5.764-10.176zm15.497-28.333-9.249 17.188h18.535zM189.953 230.003h45.212c9.695 0 16.875 3.382 16.875 14.253 0 4.695-1.859 8.802-6 11.115 4.549 2.416 7.141 6.897 7.141 12.073 0 7.283-4.664 14.115-12.493 14.115h-50.735zm15.012 39.789h27.887c2.722 0 5.245-1.481 5.245-4.451 0-2.935-2.554-4.451-5.245-4.451h-27.887zm0-19.562h27.887c2.515 0 4.107-1.76 4.107-4.211 0-2.45-1.553-4.275-4.107-4.275h-27.887zM329.791 230.003h49.144c9.805 0 14.535 8.008 14.535 16.948 0 5.794-2.104 11.214-7.421 13.981 5.18 2.516 7.558 6.485 7.558 12.287v8.348h-14.672v-8.344c0-4.901-2.722-6.661-7.455-6.661h-26.566v15.005h-15.119zm15.119 24.815h27.505c3.55 0 5.936-3.176 5.936-6.524 0-4.278-3.176-6.557-7.283-6.557H344.91z" />
    </Svg>
  );
};

SubaruWordmarkDark.displayName = 'SubaruWordmarkDark';

export default SubaruWordmarkDark;