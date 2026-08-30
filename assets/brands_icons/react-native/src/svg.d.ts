declare module "react-native-svg" {
  import React from "react";
  import { ViewProps } from "react-native";

  export interface SvgProps extends ViewProps {
    width?: number | string;
    height?: number | string;
    viewBox?: string;
    preserveAspectRatio?: string;
    color?: string;
    title?: string;
    opacity?: number | string;
    style?: any;
  }

  export interface PathProps {
    d?: string;
    fill?: string;
    fillOpacity?: number | string;
    fillRule?: "nonzero" | "evenodd";
    stroke?: string;
    strokeWidth?: number | string;
    strokeOpacity?: number | string;
    strokeLinecap?: "butt" | "round" | "square";
    strokeLinejoin?: "miter" | "round" | "bevel";
    strokeMiterlimit?: number | string;
    strokeDasharray?: string | number[];
    strokeDashoffset?: number | string;
    opacity?: number | string;
    style?: any;
    transform?: string;
    clipPath?: string;
    clipRule?: "nonzero" | "evenodd";
  }

  // Using React.ComponentClass to ensure compatibility with JSX
  export const Svg: React.ComponentClass<SvgProps>;
  export const Path: React.ComponentClass<PathProps>;
  export const G: React.ComponentClass<any>;
  export const Circle: React.ComponentClass<any>;
  export const Rect: React.ComponentClass<any>;
  export const Ellipse: React.ComponentClass<any>;
  export const Line: React.ComponentClass<any>;
  export const Polygon: React.ComponentClass<any>;
  export const Polyline: React.ComponentClass<any>;
  export const Defs: React.ComponentClass<any>;
  export const ClipPath: React.ComponentClass<any>;
  export const LinearGradient: React.ComponentClass<any>;
  export const RadialGradient: React.ComponentClass<any>;
  export const Stop: React.ComponentClass<any>;
  export const Use: React.ComponentClass<any>;
  export const Symbol: React.ComponentClass<any>;
  export const Mask: React.ComponentClass<any>;
  export const Pattern: React.ComponentClass<any>;
  export const Image: React.ComponentClass<any>;
  export const ForeignObject: React.ComponentClass<any>;
  export const TSpan: React.ComponentClass<any>;
  export const TextPath: React.ComponentClass<any>;
  export const Text: React.ComponentClass<any>;

  export default Svg;
}
