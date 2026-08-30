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

export interface PorscheWordmarkDarkProps extends SvgProps {
  /** Size of the icon (sets both width and height) */
  size?: number;
}

/**
 * PorscheWordmarkDark icon component for React Native
 */
const PorscheWordmarkDark = ({ size, width, height, ...props }: PorscheWordmarkDarkProps) => {
  const computedWidth = size ?? width ?? 24;
  const computedHeight = size ?? height ?? 24;
  return (
    <Svg
      viewBox="0 0 512 512"
      width={computedWidth}
      height={computedHeight}
      {...props}
    >
      <Path fill="#fff" d="M120.611 269.612h43.285c1.96 0 3.547-1.583 3.547-3.522v-19.178c0-1.937-1.587-3.522-3.547-3.522h-43.285c-1.96 0-3.548 1.585-3.548 3.522v19.178c.002 1.939 1.588 3.522 3.548 3.522m2.752-21.134h37.979c.651 0 1.182.529 1.182 1.174v13.7c0 .645-.531 1.174-1.182 1.174h-37.979a1.18 1.18 0 0 1-1.182-1.174v-13.7a1.18 1.18 0 0 1 1.182-1.174M59.8 269.612h5.115v-6.26h41.523c2.056 0 3.74-1.674 3.74-3.718v-12.526c0-2.045-1.684-3.718-3.74-3.718H59.8v26.222m5.115-11.35v-9.784h38.568999999999996c.865 0 1.574.703 1.574 1.566v6.654c0 .86-.707 1.566-1.574 1.566h-37.190000000000005zM174.133 269.612h5.117v-6.26h36.884l3.232 6.26h5.531l-3.283-6.356c1.654-.382 2.895-1.866 2.895-3.624v-12.526c0-2.044-1.682-3.718-3.738-3.718h-46.638v26.224m5.117-11.35v-9.784h38.567c.867 0 1.576.703 1.576 1.566v6.654c0 .86-.707 1.566-1.576 1.566h-37.191zM345.339 269.612h5.117v-10.568h37.585v10.568h5.118v-26.224h-5.118v10.57h-37.585v-10.57h-5.117zM293.785 269.612h43.88v-5.154a1.2 1.2 0 0 1-.394.066h-40.734a1.184 1.184 0 0 1-1.182-1.174v-13.7c0-.645.533-1.174 1.182-1.174h40.734q.208.002.394.068v-5.156h-43.88c-1.958 0-3.546 1.585-3.546 3.522v19.178c0 1.941 1.588 3.524 3.546 3.524M401.03 269.612h50.77v-5.088h-45.652v-5.48H451.8v-5.086h-45.652v-5.48H451.8v-5.09h-50.77zM238.681 250.826v-1.176a1.18 1.18 0 0 1 1.18-1.174h40.737q.207.002.392.068v-5.156h-43.881c-1.96 0-3.547 1.585-3.547 3.522v8.61c0 1.937 1.587 3.522 3.547 3.522h3.736v.067a1.2 1.2 0 0 1 .392-.067h33.453c.651 0 1.182.529 1.182 1.176v3.1319999999999997c0 .645-.531 1.174-1.182 1.174h-40.735q-.207 0-.393-.066v5.154h43.88c1.96 0 3.548-1.585 3.548-3.522v-8.61c0-1.938-1.588-3.524-3.548-3.524h-3.732v-.067a1.2 1.2 0 0 1-.396.067h-33.455c-.649 0-1.18-.529-1.18-1.176z" />
    </Svg>
  );
};

PorscheWordmarkDark.displayName = 'PorscheWordmarkDark';

export default PorscheWordmarkDark;