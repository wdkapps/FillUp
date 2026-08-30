# @cardog-icons/react-native

React Native components for car brand logos and icons.

## Features

- **380+ optimized SVG icons** for car brands
- **Two variants**: Color (default) and Mono (dark mode optimized)
- TypeScript support with full type definitions
- Works with react-native-svg
- Tree-shakable, only import what you need
- Easy customization of size, color, and other SVG props

## Installation

```bash
npm install @cardog-icons/react-native react-native-svg
# or
yarn add @cardog-icons/react-native react-native-svg
# or
pnpm add @cardog-icons/react-native react-native-svg
```

For Expo projects:

```bash
npx expo install @cardog-icons/react-native react-native-svg
```

## Usage

### Importing specific icons

```jsx
import {
  BMWLogo,
  BMWLogoDark,
  AudiIcon,
  TeslaWordmark,
} from "@cardog-icons/react-native";

function MyScreen() {
  return (
    <View style={{ padding: 20 }}>
      {/* Color variants (default) */}
      <BMWLogo width={48} height={48} />
      <AudiIcon width={32} height={32} />
      <TeslaWordmark width={120} height={24} />

      {/* Mono/Dark variants - great for dark mode */}
      <BMWLogoDark width={48} height={48} fill="white" />
    </View>
  );
}
```

### Using the generic Icon component

```jsx
import { Icon } from "@cardog-icons/react-native";

function MyScreen() {
  return (
    <View>
      <Icon name="BMWLogo" width={48} height={48} />
      <Icon name="BMWLogoDark" width={48} height={48} fill="white" />
      <Icon name="AudiIcon" width={32} height={32} />
    </View>
  );
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

| Prop          | Type               | Default | Description               |
| ------------- | ------------------ | ------- | ------------------------- |
| `width`       | `number \| string` | `24`    | Width of the icon         |
| `height`      | `number \| string` | `24`    | Height of the icon        |
| `fill`        | `string`           | -       | Fill color for mono icons |
| `...svgProps` | `SvgProps`         | -       | Any valid SVG prop        |

## License

MIT © Cardog
