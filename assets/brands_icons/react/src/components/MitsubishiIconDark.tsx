import * as React from 'react';
import { forwardRef } from 'react';

export interface MitsubishiIconDarkProps extends React.SVGProps<SVGSVGElement> {
  /** Size of the icon (sets both width and height) */
  size?: number | string;
}

/**
 * MitsubishiIconDark icon component
 */
const MitsubishiIconDark = forwardRef<SVGSVGElement, MitsubishiIconDarkProps>(({ size, ...props }, ref) => {
  const sizeProps = size !== undefined ? { width: size, height: size } : {};
  return (
    <svg width="1em" height="1em" viewBox="0 0 512 512" fill="none" xmlns="http://www.w3.org/2000/svg" ref={ref} {...sizeProps} {...props}><path d="M253.724 107.818L195.908 200.688L311.995 403.271L434 402.816L372.087 302.662H138.092L78 404.182H191.811L313.816 198.867L253.724 107.818Z" fill="white" /></svg>
  );
});

MitsubishiIconDark.displayName = 'MitsubishiIconDark';

export default MitsubishiIconDark;