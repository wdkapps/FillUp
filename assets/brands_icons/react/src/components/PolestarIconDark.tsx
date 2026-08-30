import * as React from 'react';
import { forwardRef } from 'react';

export interface PolestarIconDarkProps extends React.SVGProps<SVGSVGElement> {
  /** Size of the icon (sets both width and height) */
  size?: number | string;
}

/**
 * PolestarIconDark icon component
 */
const PolestarIconDark = forwardRef<SVGSVGElement, PolestarIconDarkProps>(({ size, ...props }, ref) => {
  const sizeProps = size !== undefined ? { width: size, height: size } : {};
  return (
    <svg width="1em" height="1em" viewBox="0 0 512 512" fill="none" xmlns="http://www.w3.org/2000/svg" ref={ref} {...sizeProps} {...props}><path fillRule="evenodd" clipRule="evenodd" d="M254.66 260.73V456.64L246.66 466.37L213.6 301.73L254.66 260.73Z" fill="white" /><path fillRule="evenodd" clipRule="evenodd" d="M257.92 251.67V55.73L265.92 46L298.98 210.61L257.92 251.67Z" fill="white" /><path fillRule="evenodd" clipRule="evenodd" d="M213.6 301.73L49 268.73L58.72 260.73H254.66L213.6 301.73Z" fill="white" /><path fillRule="evenodd" clipRule="evenodd" d="M299.01 210.62L463.61 243.73L453.89 251.73H257.92L299.01 210.62Z" fill="white" /></svg>
  );
});

PolestarIconDark.displayName = 'PolestarIconDark';

export default PolestarIconDark;