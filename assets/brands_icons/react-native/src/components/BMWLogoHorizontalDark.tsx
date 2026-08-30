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

export interface BMWLogoHorizontalDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * BMWLogoHorizontalDark icon component for React Native
 */
const BMWLogoHorizontalDark = ({ size, width, height, ...props }: BMWLogoHorizontalDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="url(#prefix__a)" d="M256.014 78.297c-98.179 0-177.776 79.589-177.776 177.771S157.835 433.84 256.014 433.84c98.186 0 177.774-79.591 177.774-177.772.001-98.182-79.588-177.771-177.774-177.771m0 346.653c-93.275 0-168.88-75.61-168.88-168.882 0-93.271 75.605-168.885 168.88-168.885s168.884 75.614 168.884 168.885c0 93.272-75.61 168.882-168.884 168.882" /><Path fill="#fff" d="M426.172 256.069c0 93.968-76.19 170.155-170.158 170.155-93.97 0-170.152-76.187-170.152-170.155 0-93.973 76.182-170.155 170.152-170.155 93.968 0 170.158 76.182 170.158 170.155" /><Path fill="url(#prefix__b)" d="M424.898 256.069c0 93.272-75.61 168.882-168.884 168.882-93.275 0-168.88-75.61-168.88-168.882 0-93.271 75.605-168.885 168.88-168.885s168.884 75.614 168.884 168.885" /><Path fill="url(#prefix__c)" d="M369.238 256.068c0 62.53-50.692 113.219-113.224 113.219s-113.225-50.689-113.225-113.219c0-62.533 50.692-113.224 113.225-113.224s113.224 50.691 113.224 113.224" /><Path fill="#fff" d="m260.549 139.785 11.762-31.172v31.172h8.932V95.141h-13.424l-12.21 31.965h.116l-12.21-31.965H230.09v44.644h8.933v-31.172l11.761 31.172zM383.141 159.803l-15.263 22.253 23.973-11.79 6.502 7.798-37.729 18.944-7.624-9.23 14.625-22.051-.086-.108-24.326 10.412-7.711-9.168 25.44-33.686 6.503 7.801-15.929 21.451 24.652-10.995zM176.946 151.275c-3.596-3.49-9.144-4.543-14.359-1.309.998-2.583.593-5.212.065-6.67-2.25-4.09-3.038-4.607-4.875-6.159-5.996-5.024-12.305-.734-16.811 4.636l-21.786 25.965 34.25 28.734 22.973-27.374c5.251-6.257 6.062-12.459.543-17.823m-44.306 12.521 13.086-15.595c1.519-1.805 4.948-1.733 7.147.12 2.423 2.032 2.43 4.911.803 6.853l-12.941 15.415zm36.103 2.593-13.642 16.258-8.543-7.18 13.744-16.383c1.555-1.852 5.02-2.391 7.356-.431 2.633 2.214 2.893 5.581 1.085 7.736" /><Path fill="url(#prefix__d)" d="m260.644 138.06 11.761-31.172v31.172h8.933V93.415h-13.426l-12.209 31.964h.115l-12.209-31.964h-13.426v44.645h8.933v-31.172l11.762 31.172z" /><Path fill="url(#prefix__e)" d="m383.228 156.808-15.255 22.254 23.971-11.794 6.496 7.801-37.723 18.944-7.623-9.233 14.625-22.048-.085-.112-24.335 10.416-7.702-9.172 25.439-33.682 6.503 7.798-15.928 21.45 24.644-10.991z" /><Path fill="url(#prefix__f)" d="M175.346 150.395c-3.588-3.49-9.143-4.543-14.35-1.312.99-2.583.585-5.212.058-6.663-2.25-4.097-3.031-4.608-4.884-6.163-5.996-5.027-12.296-.734-16.795 4.641l-21.795 25.96 34.251 28.735 22.973-27.378c5.244-6.257 6.061-12.456.542-17.82m-44.304 12.521 13.085-15.591c1.513-1.808 4.941-1.736 7.147.112 2.423 2.036 2.43 4.918.795 6.853l-12.933 15.418zm36.109 2.593-13.642 16.258-8.557-7.18 13.751-16.387c1.555-1.848 5.013-2.387 7.349-.426 2.647 2.216 2.908 5.576 1.099 7.735" /><Path fill="url(#prefix__g)" d="M146.559 256.07c0-60.453 49.006-109.46 109.456-109.46 60.456 0 109.456 49.007 109.456 109.46 0 60.45-49 109.455-109.456 109.455-60.45 0-109.456-49.005-109.456-109.455" /><Path fill="url(#prefix__h)" d="M149.705 256.07c0-58.713 47.596-106.313 106.31-106.313 58.713 0 106.316 47.599 106.316 106.313s-47.603 106.314-106.316 106.314-106.31-47.6-106.31-106.314" /><Path fill="#000" d="M149.538 256.069h106.476V149.594c-58.808 0-106.476 47.668-106.476 106.475M256.014 256.07v106.477c58.807 0 106.476-47.677 106.476-106.477z" /><Path fill="url(#prefix__i)" d="M363.371 254.178h-105.47v-105.47h-3.776v105.47h-105.47v3.776h105.47v105.474h3.776V257.954h105.47z" /><Path fill="url(#prefix__j)" d="M257.902 151.696c56.167.999 101.492 46.319 102.497 102.483h1.88c-1.004-57.206-47.168-103.376-104.378-104.374z" /><Path fill="#C2D7E8" d="M151.448 254.164c.997-56.24 46.387-101.625 102.627-102.628v-1.888c-57.288 1.002-103.51 47.234-104.515 104.516z" /><Path fill="url(#prefix__k)" d="M254.126 360.443c-56.167-.998-101.491-46.322-102.49-102.489h-1.887c1.005 57.208 47.169 103.38 104.377 104.378z" /><Path fill="#12404F" d="M360.399 257.954c-1.005 56.167-46.329 101.491-102.497 102.489v1.889c57.209-.998 103.38-47.169 104.378-104.378z" /><Path fill="url(#prefix__l)" d="M252.109 149.648v102.458H149.654v2.022h104.472v-104.48z" /><Path fill="url(#prefix__m)" d="M251.935 361.342V260.117H150.501v-1.996h103.43v103.221z" /><Path fill="url(#prefix__n)" d="M260.065 361.342V260.117h101.224v-1.996H258.075v103.221z" /><Path fill="url(#prefix__o)" d="M260.065 150.553v101.224h101.224v1.993H258.075V150.553z" /><Defs><LinearGradient id="prefix__a" x1={52.215} x2={429.416} y1={59.13} y2={423.63} gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.098} /><Stop offset={0.268} /><Stop offset={0.488} /><Stop offset={0.747} /><Stop offset={1} /></LinearGradient><LinearGradient id="prefix__c" x1={385.813} x2={145.576} y1={381.496} y2={149.347} gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.086} /><Stop offset={0.233} /><Stop offset={0.424} /><Stop offset={0.652} /><Stop offset={0.907} /><Stop offset={1} /></LinearGradient><LinearGradient id="prefix__j" x1={234.961} x2={391.537} y1={110.445} y2={261.749} gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.109} /><Stop offset={0.247} /><Stop offset={0.403} /><Stop offset={0.57} /><Stop offset={0.747} /><Stop offset={0.929} /><Stop offset={1} /></LinearGradient><LinearGradient id="prefix__k" x1={107.872} x2={264.451} y1={238.188} y2={389.495} gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.109} /><Stop offset={0.247} /><Stop offset={0.403} /><Stop offset={0.57} /><Stop offset={0.747} /><Stop offset={0.929} /><Stop offset={1} /></LinearGradient><LinearGradient id="prefix__l" x1={183.622} x2={264.814} y1={184.235} y2={262.693} gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.134} /><Stop offset={0.343} /><Stop offset={0.6} /><Stop offset={0.894} /><Stop offset={1} /></LinearGradient><LinearGradient id="prefix__m" x1={142.958} x2={297.962} y1={203.46} y2={353.244} gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.097} /><Stop offset={0.257} /><Stop offset={0.459} /><Stop offset={0.695} /><Stop offset={0.958} /><Stop offset={1} /></LinearGradient><LinearGradient id="prefix__n" x1={257.205} x2={311.576} y1={259.021} y2={311.562} gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.123} /><Stop offset={0.263} /><Stop offset={0.411} /><Stop offset={0.566} /><Stop offset={0.725} /><Stop offset={0.885} /><Stop offset={0.972} /></LinearGradient><LinearGradient id="prefix__o" x1={201.585} x2={356.421} y1={146.612} y2={296.234} gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.109} /><Stop offset={0.247} /><Stop offset={0.403} /><Stop offset={0.57} /><Stop offset={0.747} /><Stop offset={0.929} /><Stop offset={1} /></LinearGradient><RadialGradient id="prefix__b" cx={0} cy={0} r={1} gradientTransform="translate(76.022 90.055)scale(252.57)" gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.306} /><Stop offset={0.646} /><Stop offset={0.885} /><Stop offset={1} /></RadialGradient><RadialGradient id="prefix__d" cx={0} cy={0} r={1} gradientTransform="translate(30.662 64.334)scale(606.888)" gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.31} /><Stop offset={0.451} /><Stop offset={0.557} /><Stop offset={0.646} /><Stop offset={0.724} /><Stop offset={0.794} /><Stop offset={0.859} /><Stop offset={0.92} /><Stop offset={0.975} /><Stop offset={1} /></RadialGradient><RadialGradient id="prefix__e" cx={0} cy={0} r={1} gradientTransform="translate(30.635 64.333)scale(606.94)" gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.31} /><Stop offset={0.451} /><Stop offset={0.557} /><Stop offset={0.646} /><Stop offset={0.724} /><Stop offset={0.794} /><Stop offset={0.859} /><Stop offset={0.92} /><Stop offset={0.975} /><Stop offset={1} /></RadialGradient><RadialGradient id="prefix__f" cx={0} cy={0} r={1} gradientTransform="translate(30.602 64.155)scale(607.405)" gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.31} /><Stop offset={0.451} /><Stop offset={0.557} /><Stop offset={0.646} /><Stop offset={0.724} /><Stop offset={0.794} /><Stop offset={0.859} /><Stop offset={0.92} /><Stop offset={0.975} /><Stop offset={1} /></RadialGradient><RadialGradient id="prefix__g" cx={0} cy={0} r={1} gradientTransform="translate(139.356 148.471)scale(163.696)" gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.104} /><Stop offset={0.307} /><Stop offset={0.588} /><Stop offset={0.933} /><Stop offset={1} /></RadialGradient><RadialGradient id="prefix__h" cx={0} cy={0} r={1} gradientTransform="translate(184.129 170.488)scale(238.061)" gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.344} /><Stop offset={0.481} /><Stop offset={0.582} /><Stop offset={0.665} /><Stop offset={0.737} /><Stop offset={0.802} /><Stop offset={0.86} /><Stop offset={0.913} /><Stop offset={0.949} /><Stop offset={0.957} /><Stop offset={1} /></RadialGradient><RadialGradient id="prefix__i" cx={0} cy={0} r={1} gradientTransform="translate(141.591 150.533)scale(160.559)" gradientUnits="userSpaceOnUse"><Stop /><Stop offset={0.104} /><Stop offset={0.307} /><Stop offset={0.588} /><Stop offset={0.933} /><Stop offset={1} /></RadialGradient></Defs>
    </Svg>
  );
};

BMWLogoHorizontalDark.displayName = 'BMWLogoHorizontalDark';

export default BMWLogoHorizontalDark;