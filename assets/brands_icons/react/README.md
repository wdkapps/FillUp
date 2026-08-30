# @cardog-icons/react

React components for car brand logos and icons.

## Features

- **380+ optimized SVG icons** for car brands
- **Two variants**: Color (default) and Mono (dark mode optimized)
- TypeScript support with full type definitions
- Tree-shakable, only import what you need
- Easy customization of size, color, and other SVG props
- Lightweight and fast

## Installation

```bash
npm install @cardog-icons/react
# or
yarn add @cardog-icons/react
# or
pnpm add @cardog-icons/react
```

## Usage

### Importing specific icons

```jsx
import {
  BMWLogo,
  BMWLogoDark,
  AudiIcon,
  TeslaWordmark,
} from "@cardog-icons/react";

function App() {
  return (
    <div>
      {/* Color variants (default) */}
      <BMWLogo size={48} />
      <AudiIcon size={32} />
      <TeslaWordmark height={24} width={120} />

      {/* Mono/Dark variants - great for dark mode */}
      <BMWLogoDark size={48} className="text-white" />
    </div>
  );
}
```

### Using the generic Icon component

```jsx
import { Icon } from "@cardog-icons/react";

function App() {
  return (
    <div>
      <Icon name="BMWLogo" size={48} />
      <Icon name="BMWLogoDark" size={48} />
      <Icon name="AudiIcon" size={32} />
    </div>
  );
}
```

### Using the useIcon hook

```jsx
import { useIcon } from "@cardog-icons/react";

function CustomIcon({ name, ...props }) {
  const icon = useIcon({ name, ...props });

  return <div className="custom-icon-wrapper">{icon}</div>;
}
```

## Icon Variants

Each brand comes in two variants:

| Variant | Suffix | Description                                  |
| ------- | ------ | -------------------------------------------- |
| Color   | (none) | Full-color brand logos for light backgrounds |
| Mono    | `Dark` | Single-color icons for dark mode UIs         |

## Available Icon Types

- **Icon**: Compact badge/emblem icon
- **Logo**: Full brand logo
- **LogoHorizontal**: Horizontal logo with text
- **Wordmark**: Text-only brand name

### Naming Examples

| Type       | Color               | Mono                    |
| ---------- | ------------------- | ----------------------- |
| Icon       | `BMWIcon`           | `BMWIconDark`           |
| Logo       | `BMWLogo`           | `BMWLogoDark`           |
| Horizontal | `BMWLogoHorizontal` | `BMWLogoHorizontalDark` |
| Wordmark   | `BMWWordmark`       | `BMWWordmarkDark`       |

## Available Brands

Acura, Alfa Romeo, Aston Martin, Audi, Bentley, BMW, Bugatti*, Buick*, BYD, Cadillac, Chevrolet, Chrysler, Dodge, Ferrari, Fiat, Ford, Genesis, GMC, Honda, Hummer, Hyundai, Infiniti, Jaguar, Jeep, Kia, Koenigsegg*, Lamborghini, Land Rover, Lexus, Lincoln, Lotus, Lucid, Maserati, Mazda, Mercedes-Benz, McLaren, Mini, Mitsubishi, Nissan, Pagani*, Polestar, Porsche, RAM, Rivian\*, Rolls-Royce, Subaru, Tesla, Toyota, VinFast, Volkswagen, Volvo

\*Mono variant only

## Props

All icon components accept the following props:

| Prop          | Type                            | Default | Description                    |
| ------------- | ------------------------------- | ------- | ------------------------------ |
| `size`        | `number \| string`              | `24`    | Size for both width and height |
| `width`       | `number \| string`              | -       | Override width                 |
| `height`      | `number \| string`              | -       | Override height                |
| `className`   | `string`                        | -       | CSS class name                 |
| `...svgProps` | `React.SVGProps<SVGSVGElement>` | -       | Any valid SVG prop             |

## License

MIT © Cardog
