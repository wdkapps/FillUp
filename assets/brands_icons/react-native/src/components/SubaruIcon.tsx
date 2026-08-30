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

export interface SubaruIconProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * SubaruIcon icon component for React Native
 */
const SubaruIcon = ({ size, width, height, ...props }: SubaruIconProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#14478A" d="M256.005 152.816c44.551 0 92.314 9.045 130.327 33.075C411.018 201.626 434 225.468 434 256.542c0 36.284-31.109 62.668-60.911 78.111-35.461 18.288-77.366 25.53-117.094 25.53-44.541 0-92.209-8.94-130.233-33.064C101.076 311.384 78 287.542 78 256.542c0-36.451 31.026-62.742 60.911-78.195 35.566-18.278 77.376-25.531 117.094-25.531m-.376 11.025c-41.424 0-86.069 7.722-122.011 29.292-22.605 13.474-44.927 34.679-44.927 62.846 0 33.085 30.262 56.239 57.312 69.536 33.484 16.287 72.638 22.622 109.626 22.622 41.507 0 86.162-7.742 122.104-29.312 22.511-13.568 44.928-34.669 44.928-62.836 0-33.158-30.178-56.343-57.313-69.525-33.494-16.318-72.648-22.623-109.719-22.623M99.287 233.085l68.192-11.587 20.523-44.381 20.44 44.381 68.181 11.587-68.181 11.692-20.44 44.474-20.523-44.474zM249.195 266.9l30.074-5.263 8.986-20.07 8.985 20.07 30.084 5.263-30.084 5.178-8.985 20.081-8.986-20.081zm62.24-53.51 30.074-5.178 8.985-20.154 8.986 20.154 30.074 5.178-30.074 5.273-8.986 20.08-8.996-20.08zm-32.166 94.983 29.98-5.179 8.985-20.164 9.08 20.164 30.074 5.179-30.074 5.273-9.08 20.08-8.985-20.08zm-92.397 7.253 30.074-5.179 9.08-20.185 8.975 20.185 30.084 5.179-30.084 5.272-8.975 20.081-9.08-20.081zm151.237-49.55 29.98-5.283 8.985-20.07 9.08 20.07 30.074 5.283-30.074 5.179-9.09 20.049-8.986-20.059z" />
    </Svg>
  );
};

SubaruIcon.displayName = 'SubaruIcon';

export default SubaruIcon;