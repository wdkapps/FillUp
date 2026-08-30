export type IconCategory = "Icon" | "Logo" | "LogoHorizontal" | "Wordmark";
export type IconVariant = "Default" | "Dark";
export type FilterCategory = "All" | IconCategory;

// Icon name type - supports all generated component names
export type IconName = string;

// Icon information
export interface IconInfo {
  id: string;
  name: string;
  brand: string;
  category: IconCategory;
  variant: IconVariant;
  componentName: IconName;
}

// Process the icon name (like "BMWLogo" or "BMWLogoDark") into brand, category, and variant
function processIconName(iconName: string): IconInfo {
  const darkRegex = /^([A-Za-z0-9]+)(Icon|Logo|LogoHorizontal|Wordmark)(Dark)$/;
  const defaultRegex = /^([A-Za-z0-9]+)(Icon|Logo|LogoHorizontal|Wordmark)$/;

  const darkMatch = iconName.match(darkRegex);
  if (darkMatch) {
    const [, brand, category] = darkMatch;
    return {
      id: iconName,
      name: iconName,
      brand,
      category: category as IconCategory,
      variant: "Dark",
      componentName: iconName,
    };
  }

  const defaultMatch = iconName.match(defaultRegex);
  if (defaultMatch) {
    const [, brand, category] = defaultMatch;
    return {
      id: iconName,
      name: iconName,
      brand,
      category: category as IconCategory,
      variant: "Default",
      componentName: iconName,
    };
  }

  throw new Error(`Invalid icon name format: ${iconName}`);
}

// All icon names from our library
export const allIconNames: IconName[] = [
  // Acura
  "AcuraIcon",
  "AcuraIconDark",
  "AcuraLogo",
  "AcuraLogoDark",
  "AcuraLogoHorizontal",
  "AcuraLogoHorizontalDark",
  "AcuraWordmark",
  "AcuraWordmarkDark",
  // Alfa Romeo
  "AlfaRomeoIcon",
  "AlfaRomeoIconDark",
  "AlfaRomeoLogo",
  "AlfaRomeoLogoDark",
  "AlfaRomeoLogoHorizontal",
  "AlfaRomeoLogoHorizontalDark",
  "AlfaRomeoWordmark",
  "AlfaRomeoWordmarkDark",
  // Aston Martin
  "AstonMartinIcon",
  "AstonMartinIconDark",
  "AstonMartinLogo",
  "AstonMartinLogoDark",
  "AstonMartinLogoHorizontal",
  "AstonMartinLogoHorizontalDark",
  "AstonMartinWordmark",
  "AstonMartinWordmarkDark",
  // Audi
  "AudiIcon",
  "AudiIconDark",
  "AudiLogo",
  "AudiLogoDark",
  "AudiLogoHorizontal",
  "AudiLogoHorizontalDark",
  "AudiWordmark",
  "AudiWordmarkDark",
  // Bentley
  "BentleyIcon",
  "BentleyIconDark",
  "BentleyLogo",
  "BentleyLogoDark",
  "BentleyLogoHorizontal",
  "BentleyLogoHorizontalDark",
  "BentleyWordmark",
  "BentleyWordmarkDark",
  // BMW
  "BMWIcon",
  "BMWIconDark",
  "BMWLogo",
  "BMWLogoDark",
  "BMWLogoHorizontal",
  "BMWLogoHorizontalDark",
  "BMWWordmark",
  "BMWWordmarkDark",
  // Bugatti
  "BugattiIcon",
  "BugattiIconDark",
  "BugattiLogo",
  "BugattiLogoDark",
  "BugattiLogoHorizontal",
  "BugattiLogoHorizontalDark",
  "BugattiWordmark",
  "BugattiWordmarkDark",
  // Buick
  "BuickIcon",
  "BuickIconDark",
  "BuickLogo",
  "BuickLogoDark",
  "BuickLogoHorizontal",
  "BuickLogoHorizontalDark",
  "BuickWordmark",
  "BuickWordmarkDark",
  // BYD
  "BYDIcon",
  "BYDIconDark",
  "BYDLogo",
  "BYDLogoDark",
  "BYDLogoHorizontal",
  "BYDLogoHorizontalDark",
  "BYDWordmark",
  "BYDWordmarkDark",
  // Cadillac
  "CadillacIcon",
  "CadillacIconDark",
  "CadillacLogo",
  "CadillacLogoDark",
  "CadillacLogoHorizontal",
  "CadillacLogoHorizontalDark",
  "CadillacWordmark",
  "CadillacWordmarkDark",
  // Chevrolet
  "ChevroletIcon",
  "ChevroletIconDark",
  "ChevroletLogo",
  "ChevroletLogoDark",
  "ChevroletLogoHorizontal",
  "ChevroletLogoHorizontalDark",
  "ChevroletWordmark",
  "ChevroletWordmarkDark",
  // Chrysler
  "ChryslerIcon",
  "ChryslerIconDark",
  "ChryslerLogo",
  "ChryslerLogoDark",
  "ChryslerLogoHorizontal",
  "ChryslerLogoHorizontalDark",
  "ChryslerWordmark",
  "ChryslerWordmarkDark",
  // Dodge
  "DodgeIcon",
  "DodgeIconDark",
  "DodgeLogo",
  "DodgeLogoDark",
  "DodgeLogoHorizontal",
  "DodgeLogoHorizontalDark",
  "DodgeWordmark",
  "DodgeWordmarkDark",
  // Ferrari
  "FerrariIcon",
  "FerrariIconDark",
  "FerrariLogo",
  "FerrariLogoDark",
  "FerrariLogoHorizontal",
  "FerrariLogoHorizontalDark",
  "FerrariWordmark",
  "FerrariWordmarkDark",
  // Fiat
  "FiatIcon",
  "FiatIconDark",
  "FiatLogo",
  "FiatLogoDark",
  "FiatLogoHorizontal",
  "FiatLogoHorizontalDark",
  "FiatWordmark",
  "FiatWordmarkDark",
  // Ford
  "FordIcon",
  "FordIconDark",
  "FordLogo",
  "FordLogoDark",
  "FordLogoHorizontal",
  "FordLogoHorizontalDark",
  "FordWordmark",
  "FordWordmarkDark",
  // Genesis
  "GenesisIcon",
  "GenesisIconDark",
  "GenesisLogo",
  "GenesisLogoDark",
  "GenesisLogoHorizontal",
  "GenesisLogoHorizontalDark",
  "GenesisWordmark",
  "GenesisWordmarkDark",
  // GMC
  "GMCIcon",
  "GMCIconDark",
  "GMCLogo",
  "GMCLogoDark",
  "GMCLogoHorizontal",
  "GMCLogoHorizontalDark",
  "GMCWordmark",
  "GMCWordmarkDark",
  // Honda
  "HondaIcon",
  "HondaIconDark",
  "HondaLogo",
  "HondaLogoDark",
  "HondaLogoHorizontal",
  "HondaLogoHorizontalDark",
  "HondaWordmark",
  "HondaWordmarkDark",
  // Hummer
  "HummerIcon",
  "HummerIconDark",
  "HummerLogo",
  "HummerLogoDark",
  "HummerLogoHorizontal",
  "HummerLogoHorizontalDark",
  "HummerWordmark",
  "HummerWordmarkDark",
  // Hyundai
  "HyundaiIcon",
  "HyundaiIconDark",
  "HyundaiLogo",
  "HyundaiLogoDark",
  "HyundaiLogoHorizontal",
  "HyundaiLogoHorizontalDark",
  "HyundaiWordmark",
  "HyundaiWordmarkDark",
  // Infiniti
  "InfinitiIcon",
  "InfinitiIconDark",
  "InfinitiLogo",
  "InfinitiLogoDark",
  "InfinitiLogoHorizontal",
  "InfinitiLogoHorizontalDark",
  "InfinitiWordmark",
  "InfinitiWordmarkDark",
  // Jaguar
  "JaguarIcon",
  "JaguarIconDark",
  "JaguarLogo",
  "JaguarLogoDark",
  "JaguarLogoHorizontal",
  "JaguarLogoHorizontalDark",
  "JaguarWordmark",
  "JaguarWordmarkDark",
  // Jeep
  "JeepIcon",
  "JeepIconDark",
  "JeepLogo",
  "JeepLogoDark",
  "JeepLogoHorizontal",
  "JeepLogoHorizontalDark",
  "JeepWordmark",
  "JeepWordmarkDark",
  // Kia
  "KiaIcon",
  "KiaIconDark",
  "KiaLogo",
  "KiaLogoDark",
  "KiaLogoHorizontal",
  "KiaLogoHorizontalDark",
  "KiaWordmark",
  "KiaWordmarkDark",
  // Koenigsegg
  "KoenigseggIcon",
  "KoenigseggIconDark",
  "KoenigseggLogo",
  "KoenigseggLogoDark",
  "KoenigseggLogoHorizontal",
  "KoenigseggLogoHorizontalDark",
  "KoenigseggWordmark",
  "KoenigseggWordmarkDark",
  // Lamborghini
  "LamborghiniIcon",
  "LamborghiniIconDark",
  "LamborghiniLogo",
  "LamborghiniLogoDark",
  "LamborghiniLogoHorizontal",
  "LamborghiniLogoHorizontalDark",
  "LamborghiniWordmark",
  "LamborghiniWordmarkDark",
  // Land Rover
  "LandroverIcon",
  "LandroverIconDark",
  "LandroverLogo",
  "LandroverLogoDark",
  "LandroverLogoHorizontal",
  "LandroverLogoHorizontalDark",
  "LandroverWordmark",
  "LandroverWordmarkDark",
  // Lexus
  "LexusIcon",
  "LexusIconDark",
  "LexusLogo",
  "LexusLogoDark",
  "LexusLogoHorizontal",
  "LexusLogoHorizontalDark",
  "LexusWordmark",
  "LexusWordmarkDark",
  // Lincoln
  "LincolnIcon",
  "LincolnIconDark",
  "LincolnLogo",
  "LincolnLogoDark",
  "LincolnLogoHorizontal",
  "LincolnLogoHorizontalDark",
  "LincolnWordmark",
  "LincolnWordmarkDark",
  // Lotus
  "LotusIcon",
  "LotusIconDark",
  "LotusLogo",
  "LotusLogoDark",
  "LotusLogoHorizontal",
  "LotusLogoHorizontalDark",
  "LotusWordmark",
  "LotusWordmarkDark",
  // Lucid
  "LucidIcon",
  "LucidIconDark",
  "LucidLogo",
  "LucidLogoDark",
  "LucidLogoHorizontal",
  "LucidLogoHorizontalDark",
  "LucidWordmark",
  "LucidWordmarkDark",
  // Maserati
  "MaseratiIcon",
  "MaseratiIconDark",
  "MaseratiLogo",
  "MaseratiLogoDark",
  "MaseratiLogoHorizontal",
  "MaseratiLogoHorizontalDark",
  "MaseratiWordmark",
  "MaseratiWordmarkDark",
  // Mazda
  "MazdaIcon",
  "MazdaIconDark",
  "MazdaLogo",
  "MazdaLogoDark",
  "MazdaLogoHorizontal",
  "MazdaLogoHorizontalDark",
  "MazdaWordmark",
  "MazdaWordmarkDark",
  // Mercedes-Benz
  "MBIcon",
  "MBIconDark",
  "MBLogo",
  "MBLogoDark",
  "MBLogoHorizontal",
  "MBLogoHorizontalDark",
  "MBWordmark",
  "MBWordmarkDark",
  // McLaren
  "MclarenIcon",
  "MclarenIconDark",
  "MclarenLogo",
  "MclarenLogoDark",
  "MclarenLogoHorizontal",
  "MclarenLogoHorizontalDark",
  "MclarenWordmark",
  "MclarenWordmarkDark",
  // Mini
  "MiniIcon",
  "MiniIconDark",
  "MiniLogo",
  "MiniLogoDark",
  "MiniLogoHorizontal",
  "MiniLogoHorizontalDark",
  "MiniWordmark",
  "MiniWordmarkDark",
  // Mitsubishi
  "MitsubishiIcon",
  "MitsubishiIconDark",
  "MitsubishiLogo",
  "MitsubishiLogoDark",
  "MitsubishiLogoHorizontal",
  "MitsubishiLogoHorizontalDark",
  "MitsubishiWordmark",
  "MitsubishiWordmarkDark",
  // Nissan
  "NissanIcon",
  "NissanIconDark",
  "NissanLogo",
  "NissanLogoDark",
  "NissanLogoHorizontal",
  "NissanLogoHorizontalDark",
  "NissanWordmark",
  "NissanWordmarkDark",
  // Pagani
  "PaganiIcon",
  "PaganiIconDark",
  "PaganiLogo",
  "PaganiLogoDark",
  "PaganiLogoHorizontal",
  "PaganiLogoHorizontalDark",
  "PaganiWordmark",
  "PaganiWordmarkDark",
  // Polestar
  "PolestarIcon",
  "PolestarIconDark",
  "PolestarLogo",
  "PolestarLogoDark",
  "PolestarLogoHorizontal",
  "PolestarLogoHorizontalDark",
  "PolestarWordmark",
  "PolestarWordmarkDark",
  // Porsche
  "PorscheIcon",
  "PorscheIconDark",
  "PorscheLogo",
  "PorscheLogoDark",
  "PorscheLogoHorizontal",
  "PorscheLogoHorizontalDark",
  "PorscheWordmark",
  "PorscheWordmarkDark",
  // RAM
  "RAMIcon",
  "RAMIconDark",
  "RAMLogo",
  "RAMLogoDark",
  "RAMLogoHorizontal",
  "RAMLogoHorizontalDark",
  "RAMWordmark",
  "RAMWordmarkDark",
  // Rivian
  "RivianIcon",
  "RivianIconDark",
  "RivianLogo",
  "RivianLogoDark",
  "RivianLogoHorizontal",
  "RivianLogoHorizontalDark",
  "RivianWordmark",
  "RivianWordmarkDark",
  // Rolls-Royce
  "RollsRoyceIcon",
  "RollsRoyceIconDark",
  "RollsRoyceLogo",
  "RollsRoyceLogoDark",
  "RollsRoyceLogoHorizontal",
  "RollsRoyceLogoHorizontalDark",
  "RollsRoyceWordmark",
  "RollsRoyceWordmarkDark",
  // Subaru
  "SubaruIcon",
  "SubaruIconDark",
  "SubaruLogo",
  "SubaruLogoDark",
  "SubaruLogoHorizontal",
  "SubaruLogoHorizontalDark",
  "SubaruWordmark",
  "SubaruWordmarkDark",
  // Tesla
  "TeslaIcon",
  "TeslaIconDark",
  "TeslaLogo",
  "TeslaLogoDark",
  "TeslaLogoHorizontal",
  "TeslaLogoHorizontalDark",
  "TeslaWordmark",
  "TeslaWordmarkDark",
  // Toyota
  "ToyotaIcon",
  "ToyotaIconDark",
  "ToyotaLogo",
  "ToyotaLogoDark",
  "ToyotaLogoHorizontal",
  "ToyotaLogoHorizontalDark",
  "ToyotaWordmark",
  "ToyotaWordmarkDark",
  // VinFast
  "VinfastIcon",
  "VinfastIconDark",
  "VinfastLogo",
  "VinfastLogoDark",
  "VinfastLogoHorizontal",
  "VinfastLogoHorizontalDark",
  "VinfastWordmark",
  "VinfastWordmarkDark",
  // Volkswagen
  "VolkswagenIcon",
  "VolkswagenIconDark",
  "VolkswagenLogo",
  "VolkswagenLogoDark",
  "VolkswagenLogoHorizontal",
  "VolkswagenLogoHorizontalDark",
  "VolkswagenWordmark",
  "VolkswagenWordmarkDark",
  // Volvo
  "VolvoIcon",
  "VolvoIconDark",
  "VolvoLogo",
  "VolvoLogoDark",
  "VolvoLogoHorizontal",
  "VolvoLogoHorizontalDark",
  "VolvoWordmark",
  "VolvoWordmarkDark",
];

// Process all icons
export const allIcons: IconInfo[] = allIconNames.map(processIconName);

// Get all unique brands
export const allBrands = [
  ...new Set(allIcons.map((icon) => icon.brand)),
].sort();

// Get unique categories with proper display names
export const allCategories: { id: IconCategory | "All"; name: string }[] = [
  { id: "All", name: "All Types" },
  { id: "Icon", name: "Icons" },
  { id: "Logo", name: "Logos" },
  { id: "LogoHorizontal", name: "Horizontal Logos" },
  { id: "Wordmark", name: "Wordmarks" },
];

// Get variant filters
export const allVariants: { id: IconVariant | "All"; name: string }[] = [
  { id: "All", name: "All Variants" },
  { id: "Default", name: "Color" },
  { id: "Dark", name: "Mono" },
];

// Filter icons by brand, category, variant, and search query
export function filterIcons(
  icons: IconInfo[],
  brand?: string | "All",
  category?: IconCategory | "All",
  variant?: IconVariant | "All",
  searchQuery?: string
): IconInfo[] {
  return icons.filter((icon) => {
    if (brand && brand !== "All" && icon.brand !== brand) return false;
    if (category && category !== "All" && icon.category !== category)
      return false;
    if (variant && variant !== "All" && icon.variant !== variant) return false;
    if (
      searchQuery &&
      !icon.name.toLowerCase().includes(searchQuery.toLowerCase()) &&
      !icon.brand.toLowerCase().includes(searchQuery.toLowerCase())
    )
      return false;
    return true;
  });
}

// Get icon counts
export const iconCounts = {
  total: allIcons.length,
  default: allIcons.filter((i) => i.variant === "Default").length,
  dark: allIcons.filter((i) => i.variant === "Dark").length,
  brands: allBrands.length,
};
