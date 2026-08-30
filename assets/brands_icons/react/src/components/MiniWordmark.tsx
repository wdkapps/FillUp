import * as React from 'react';
import { forwardRef } from 'react';

export interface MiniWordmarkProps extends React.SVGProps<SVGSVGElement> {
  /** Size of the icon (sets both width and height) */
  size?: number | string;
}

/**
 * MiniWordmark icon component
 */
const MiniWordmark = forwardRef<SVGSVGElement, MiniWordmarkProps>(({ size, ...props }, ref) => {
  const sizeProps = size !== undefined ? { width: size, height: size } : {};
  return (
    <svg width="1em" height="1em" viewBox="0 0 512 512" fill="none" xmlns="http://www.w3.org/2000/svg" ref={ref} {...sizeProps} {...props}><path d="M430.447 188.172V321.782H460.339V188.172H430.447Z" fill="#120A08" /><path d="M282.203 188.172V321.782H309.975V234.655L369.658 321.782H399.651V188.172H371.881V277.396L311.291 188.172H282.203Z" fill="#120A08" /><path d="M223.635 188.172V321.782H253.526V188.172H223.635Z" fill="#120A08" /><path d="M51.6621 188.172V321.782H79.4287V216.609L108.717 321.782H137.497L166.884 216.609V321.782H194.655V188.172H149.816L123.259 279.311L96.398 188.172H51.6621Z" fill="#120A08" /></svg>
  );
});

MiniWordmark.displayName = 'MiniWordmark';

export default MiniWordmark;