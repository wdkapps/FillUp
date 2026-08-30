import Link from "next/link";
import { PackageIcon, ExternalLink } from "lucide-react";

const packages = [
  {
    name: "@cardog-icons/react",
    description: "React components for Cardog Icons",
    npm: "https://www.npmjs.com/package/@cardog-icons/react",
    docs: "/docs/react",
  },
  {
    name: "@cardog-icons/react-native",
    description: "React Native components for Cardog Icons",
    npm: "https://www.npmjs.com/package/@cardog-icons/react-native",
    docs: "/docs/react-native",
  },
  {
    name: "@cardog-icons/core",
    description: "Core SVG files and utilities",
    npm: "https://www.npmjs.com/package/@cardog-icons/core",
    docs: "/docs/core",
  },
];

export default function PackagesPage() {
  return (
    <div className="container py-8 md:py-12">
      <h1 className="text-3xl font-bold mb-4">Packages</h1>
      <p className="text-lg text-muted-foreground mb-8 max-w-3xl">
        Cardog Icons is available in various packages for different platforms
        and frameworks.
      </p>

      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {packages.map((pkg) => (
          <div key={pkg.name} className="border rounded-lg p-6">
            <div className="flex items-center gap-2 mb-4">
              <PackageIcon className="h-5 w-5 text-primary" />
              <h2 className="text-xl font-semibold">{pkg.name}</h2>
            </div>
            <p className="text-muted-foreground mb-6">{pkg.description}</p>
            <div className="flex flex-col gap-2 text-sm">
              <div className="p-3 bg-muted rounded-md font-mono">
                npm install {pkg.name}
              </div>
              <div className="flex justify-between mt-4">
                <Link
                  href={pkg.docs}
                  className="text-primary font-medium hover:underline flex items-center gap-1"
                >
                  Documentation
                </Link>
                <a
                  href={pkg.npm}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-primary font-medium hover:underline flex items-center gap-1"
                >
                  NPM
                  <ExternalLink className="h-3.5 w-3.5" />
                </a>
              </div>
            </div>
          </div>
        ))}
      </div>

      <div className="mt-16 border-t pt-10">
        <h2 className="text-2xl font-bold mb-6">Installation Examples</h2>

        <div className="space-y-6">
          <div className="border rounded-lg p-6">
            <h3 className="text-xl font-semibold mb-4">React</h3>
            <div className="p-4 bg-muted rounded-md overflow-x-auto">
              <pre className="text-sm">
                <code>{`# npm
npm install @cardog-icons/react

# pnpm
pnpm add @cardog-icons/react

# Usage
import { CarIcon } from '@cardog-icons/react';

function App() {
  return <CarIcon />;
}`}</code>
              </pre>
            </div>
          </div>

          <div className="border rounded-lg p-6">
            <h3 className="text-xl font-semibold mb-4">React Native</h3>
            <div className="p-4 bg-muted rounded-md overflow-x-auto">
              <pre className="text-sm">
                <code>{`# npm
npm install @cardog-icons/react-native

# pnpm
pnpm add @cardog-icons/react-native

# Usage
import { CarIcon } from '@cardog-icons/react-native';

function App() {
  return <CarIcon width={24} height={24} />;
}`}</code>
              </pre>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
