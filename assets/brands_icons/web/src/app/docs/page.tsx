import Link from "next/link";
import { ChevronRight, Moon, Sun } from "lucide-react";

export default function DocsPage() {
  return (
    <div className="container py-8 md:py-12">
      <h1 className="text-3xl font-bold mb-4">Documentation</h1>
      <p className="text-lg text-muted-foreground mb-8 max-w-3xl">
        Get started with Cardog Icons, a beautiful and consistent icon library
        for your web and mobile applications. Now with{" "}
        <span className="font-semibold text-foreground">mono/dark</span>{" "}
        variants for dark mode UIs.
      </p>

      <div className="space-y-10">
        {/* What's New */}
        <div className="p-6 rounded-xl bg-gradient-to-br from-bernese-400/20 to-bernese-300/5 border border-bernese-400/30">
          <h2 className="text-xl font-bold mb-3 flex items-center gap-2">
            <span className="text-2xl">✨</span> What's New in v1.1.0
          </h2>
          <ul className="space-y-2 text-muted-foreground">
            <li className="flex items-center gap-2">
              <Moon className="w-4 h-4" />
              <span>
                <strong className="text-foreground">Mono/Dark variants</strong>{" "}
                - Single-color icons perfect for dark mode
              </span>
            </li>
            <li className="flex items-center gap-2">
              <span className="w-4 h-4 flex items-center justify-center">🚗</span>
              <span>
                New brands: Bugatti, Buick, Koenigsegg, Pagani, Rivian
              </span>
            </li>
            <li className="flex items-center gap-2">
              <span className="w-4 h-4 flex items-center justify-center">📦</span>
              <span>380+ total icons across 51 brands</span>
            </li>
          </ul>
        </div>

        {/* Quick Start */}
        <div>
          <h2 className="text-2xl font-bold mb-4">Quick Start</h2>
          <div className="prose prose-stone dark:prose-invert max-w-none">
            <p>
              Install the package with your preferred package manager:
            </p>
            <div className="my-4 overflow-x-auto rounded-lg border bg-muted p-4">
              <pre className="text-sm">
                <code>
                  {`# npm
npm install @cardog-icons/react

# pnpm
pnpm add @cardog-icons/react

# yarn
yarn add @cardog-icons/react`}
                </code>
              </pre>
            </div>
            <p>
              Import and use icons as React components:
            </p>
            <div className="my-4 overflow-x-auto rounded-lg border bg-muted p-4">
              <pre className="text-sm">
                <code>{`import { BMWLogo, BMWLogoDark, AudiIcon } from '@cardog-icons/react';

function MyComponent() {
  return (
    <div>
      {/* Color variant (default) */}
      <BMWLogo size={48} />
      <AudiIcon size={32} />
      
      {/* Mono/Dark variant - great for dark backgrounds */}
      <BMWLogoDark size={48} className="text-white" />
    </div>
  );
}`}</code>
              </pre>
            </div>
          </div>
        </div>

        {/* Icon Variants */}
        <div>
          <h2 className="text-2xl font-bold mb-4">Icon Variants</h2>
          <div className="grid md:grid-cols-2 gap-4">
            <div className="p-4 rounded-lg border bg-background">
              <div className="flex items-center gap-2 mb-2">
                <Sun className="w-5 h-5 text-amber-500" />
                <h3 className="font-semibold">Color (Default)</h3>
              </div>
              <p className="text-sm text-muted-foreground mb-3">
                Full-color brand logos. Use these on light backgrounds or when
                brand colors are important.
              </p>
              <code className="text-xs bg-muted px-2 py-1 rounded">
                BMWLogo, AudiIcon, TeslaWordmark
              </code>
            </div>
            <div className="p-4 rounded-lg border bg-charcoal-900 text-white">
              <div className="flex items-center gap-2 mb-2">
                <Moon className="w-5 h-5 text-blue-400" />
                <h3 className="font-semibold">Mono (Dark)</h3>
              </div>
              <p className="text-sm text-charcoal-300 mb-3">
                Single-color icons optimized for dark mode. Inherits
                currentColor for easy styling.
              </p>
              <code className="text-xs bg-charcoal-700 px-2 py-1 rounded">
                BMWLogoDark, AudiIconDark, TeslaWordmarkDark
              </code>
            </div>
          </div>
        </div>

        {/* Naming Convention */}
        <div>
          <h2 className="text-2xl font-bold mb-4">Naming Convention</h2>
          <div className="prose prose-stone dark:prose-invert max-w-none">
            <p>Icons follow a consistent naming pattern:</p>
            <div className="my-4 overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b">
                    <th className="text-left py-2 pr-4">Type</th>
                    <th className="text-left py-2 pr-4">Color</th>
                    <th className="text-left py-2">Mono</th>
                  </tr>
                </thead>
                <tbody>
                  <tr className="border-b">
                    <td className="py-2 pr-4 text-muted-foreground">Icon (badge)</td>
                    <td className="py-2 pr-4"><code>BMWIcon</code></td>
                    <td className="py-2"><code>BMWIconDark</code></td>
                  </tr>
                  <tr className="border-b">
                    <td className="py-2 pr-4 text-muted-foreground">Logo</td>
                    <td className="py-2 pr-4"><code>BMWLogo</code></td>
                    <td className="py-2"><code>BMWLogoDark</code></td>
                  </tr>
                  <tr className="border-b">
                    <td className="py-2 pr-4 text-muted-foreground">Horizontal Logo</td>
                    <td className="py-2 pr-4"><code>BMWLogoHorizontal</code></td>
                    <td className="py-2"><code>BMWLogoHorizontalDark</code></td>
                  </tr>
                  <tr>
                    <td className="py-2 pr-4 text-muted-foreground">Wordmark</td>
                    <td className="py-2 pr-4"><code>BMWWordmark</code></td>
                    <td className="py-2"><code>BMWWordmarkDark</code></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        {/* React Native */}
        <div>
          <h2 className="text-2xl font-bold mb-4">Usage with React Native</h2>
          <div className="prose prose-stone dark:prose-invert max-w-none">
            <p>
              For React Native applications, install the dedicated package:
            </p>
            <div className="my-4 overflow-x-auto rounded-lg border bg-muted p-4">
              <pre className="text-sm">
                <code>
                  {`# npm
npm install @cardog-icons/react-native react-native-svg

# yarn
yarn add @cardog-icons/react-native react-native-svg

# pnpm
pnpm add @cardog-icons/react-native react-native-svg`}
                </code>
              </pre>
            </div>
            <p>
              Then import and use the icons in your React Native components:
            </p>
            <div className="my-4 overflow-x-auto rounded-lg border bg-muted p-4">
              <pre className="text-sm">
                <code>{`import { BMWLogo, BMWLogoDark, AudiIcon } from '@cardog-icons/react-native';

function MyScreen() {
  return (
    <View style={{ padding: 20 }}>
      {/* Color variant */}
      <BMWLogo width={48} height={48} />
      <AudiIcon width={32} height={32} />
      
      {/* Mono/Dark variant */}
      <BMWLogoDark width={48} height={48} fill="white" />
    </View>
  );
}`}</code>
              </pre>
            </div>
          </div>
        </div>

        {/* Props */}
        <div>
          <h2 className="text-2xl font-bold mb-4">Props</h2>
          <div className="prose prose-stone dark:prose-invert max-w-none">
            <p>All icon components accept standard SVG props:</p>
            <div className="my-4 overflow-x-auto">
              <table className="w-full text-sm">
                <thead>
                  <tr className="border-b">
                    <th className="text-left py-2 pr-4">Prop</th>
                    <th className="text-left py-2 pr-4">Type</th>
                    <th className="text-left py-2">Description</th>
                  </tr>
                </thead>
                <tbody>
                  <tr className="border-b">
                    <td className="py-2 pr-4"><code>size</code></td>
                    <td className="py-2 pr-4 text-muted-foreground">number | string</td>
                    <td className="py-2">Width and height</td>
                  </tr>
                  <tr className="border-b">
                    <td className="py-2 pr-4"><code>width</code></td>
                    <td className="py-2 pr-4 text-muted-foreground">number | string</td>
                    <td className="py-2">Override width</td>
                  </tr>
                  <tr className="border-b">
                    <td className="py-2 pr-4"><code>height</code></td>
                    <td className="py-2 pr-4 text-muted-foreground">number | string</td>
                    <td className="py-2">Override height</td>
                  </tr>
                  <tr className="border-b">
                    <td className="py-2 pr-4"><code>className</code></td>
                    <td className="py-2 pr-4 text-muted-foreground">string</td>
                    <td className="py-2">CSS class name</td>
                  </tr>
                  <tr>
                    <td className="py-2 pr-4"><code>...svgProps</code></td>
                    <td className="py-2 pr-4 text-muted-foreground">SVGProps</td>
                    <td className="py-2">Any valid SVG attribute</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        {/* Browse Icons CTA */}
        <div className="flex justify-center pt-4">
          <Link
            href="/icons"
            className="inline-flex items-center gap-2 px-6 py-3 bg-primary text-primary-foreground rounded-lg hover:bg-primary/90 transition-colors font-medium"
          >
            Browse All Icons
            <ChevronRight className="w-4 h-4" />
          </Link>
        </div>
      </div>
    </div>
  );
}
