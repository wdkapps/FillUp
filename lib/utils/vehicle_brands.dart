import 'package:flutter/material.dart';

class VehicleBrand {
  final String name;
  final String keyword;
  final Color color;
  final String? country;
  final String? logoAsset;
  final String? logoAssetDark;

  const VehicleBrand({
    required this.name,
    required this.keyword,
    required this.color,
    this.country,
    this.logoAsset,
    this.logoAssetDark,
  });
}

class VehicleBrands {
  static VehicleBrand? detect(String vehicleName) {
    final lower = vehicleName.toLowerCase();
    VehicleBrand? bestMatch;
    var bestLength = 0;
    for (final brand in allBrands) {
      if (lower.contains(brand.keyword) && brand.keyword.length > bestLength) {
        bestMatch = brand;
        bestLength = brand.keyword.length;
      }
    }
    return bestMatch;
  }

  static const _b = 'assets/brands_icons/core/optimized';

  static const List<VehicleBrand> allBrands = [
    VehicleBrand(name: 'Acura', keyword: 'acura', color: Color(0xFF999999), country: 'JP', logoAsset: '$_b/Acura Logo.svg', logoAssetDark: '$_b/Acura Logo Dark.svg'),
    VehicleBrand(name: 'Alfa Romeo', keyword: 'alfa', color: Color(0xFF8B1E3F), country: 'IT', logoAsset: '$_b/Alfa Romeo Logo.svg', logoAssetDark: '$_b/Alfa Romeo Logo Dark.svg'),
    VehicleBrand(name: 'Aston Martin', keyword: 'aston', color: Color(0xFF003D0A), country: 'GB', logoAsset: '$_b/Aston Martin Logo.svg', logoAssetDark: '$_b/Aston Martin Logo Dark.svg'),
    VehicleBrand(name: 'Audi', keyword: 'audi', color: Color(0xFFBB0A30), country: 'DE', logoAsset: '$_b/Audi Logo.svg', logoAssetDark: '$_b/Audi Logo Dark.svg'),
    VehicleBrand(name: 'Bentley', keyword: 'bentley', color: Color(0xFF2D2D2D), country: 'GB', logoAsset: '$_b/Bentley Logo.svg', logoAssetDark: '$_b/Bentley Logo Dark.svg'),
    VehicleBrand(name: 'BMW', keyword: 'bmw', color: Color(0xFF0066B1), country: 'DE', logoAsset: '$_b/BMW Logo.svg', logoAssetDark: '$_b/BMW Logo Dark.svg'),
    VehicleBrand(name: 'Bugatti', keyword: 'bugatti', color: Color(0xFF1A1A1A), country: 'DE', logoAsset: '$_b/Bugatti Logo.svg', logoAssetDark: '$_b/Bugatti Logo Dark.svg'),
    VehicleBrand(name: 'Buick', keyword: 'buick', color: Color(0xFFC41E3A), country: 'US', logoAsset: '$_b/Buick Logo.svg', logoAssetDark: '$_b/Buick Logo Dark.svg'),
    VehicleBrand(name: 'BYD', keyword: 'byd', color: Color(0xFF003DA5), country: 'CN', logoAsset: '$_b/BYD Logo.svg', logoAssetDark: '$_b/BYD Logo Dark.svg'),
    VehicleBrand(name: 'Cadillac', keyword: 'cadillac', color: Color(0xFF1C1C1C), country: 'US', logoAsset: '$_b/Cadillac Logo.svg', logoAssetDark: '$_b/Cadillac Logo Dark.svg'),
    VehicleBrand(name: 'Chevrolet', keyword: 'chevrolet', color: Color(0xFFD1A054), country: 'US', logoAsset: '$_b/Chevrolet Logo.svg', logoAssetDark: '$_b/Chevrolet Logo Dark.svg'),
    VehicleBrand(name: 'Chevy', keyword: 'chevy', color: Color(0xFFD1A054), country: 'US', logoAsset: '$_b/Chevrolet Logo.svg', logoAssetDark: '$_b/Chevrolet Logo Dark.svg'),
    VehicleBrand(name: 'Chrysler', keyword: 'chrysler', color: Color(0xFF2C2C2C), country: 'US', logoAsset: '$_b/Chrysler Logo.svg', logoAssetDark: '$_b/Chrysler Logo Dark.svg'),
    VehicleBrand(name: 'Dodge', keyword: 'dodge', color: Color(0xFF1C1C1C), country: 'US', logoAsset: '$_b/Dodge Logo.svg', logoAssetDark: '$_b/Dodge Logo Dark.svg'),
    VehicleBrand(name: 'Ferrari', keyword: 'ferrari', color: Color(0xFFDC0000), country: 'IT', logoAsset: '$_b/Ferrari Logo.svg', logoAssetDark: '$_b/Ferrari Logo Dark.svg'),
    VehicleBrand(name: 'Fiat', keyword: 'fiat', color: Color(0xFF8B1E3F), country: 'IT', logoAsset: '$_b/Fiat Logo.svg', logoAssetDark: '$_b/Fiat Logo Dark.svg'),
    VehicleBrand(name: 'Ford', keyword: 'ford', color: Color(0xFF003478), country: 'US', logoAsset: '$_b/Ford Logo.svg', logoAssetDark: '$_b/Ford Logo Dark.svg'),
    VehicleBrand(name: 'Genesis', keyword: 'genesis', color: Color(0xFF1A1A1A), country: 'KR', logoAsset: '$_b/Genesis Logo.svg', logoAssetDark: '$_b/Genesis Logo Dark.svg'),
    VehicleBrand(name: 'GMC', keyword: 'gmc', color: Color(0xFFC8102E), country: 'US', logoAsset: '$_b/GMC Logo.svg', logoAssetDark: '$_b/GMC Logo Dark.svg'),
    VehicleBrand(name: 'Honda', keyword: 'honda', color: Color(0xFFCC0000), country: 'JP', logoAsset: '$_b/Honda Logo.svg', logoAssetDark: '$_b/Honda Logo Dark.svg'),
    VehicleBrand(name: 'Hummer', keyword: 'hummer', color: Color(0xFF3B5E3B), country: 'US', logoAsset: '$_b/Hummer Logo.svg', logoAssetDark: '$_b/Hummer Logo Dark.svg'),
    VehicleBrand(name: 'Hyundai', keyword: 'hyundai', color: Color(0xFF002C5F), country: 'KR', logoAsset: '$_b/Hyundai Logo.svg', logoAssetDark: '$_b/Hyundai Logo Dark.svg'),
    VehicleBrand(name: 'Infiniti', keyword: 'infiniti', color: Color(0xFF2D2D2D), country: 'JP', logoAsset: '$_b/Infiniti Logo.svg', logoAssetDark: '$_b/Infiniti Logo Dark.svg'),
    VehicleBrand(name: 'Jaguar', keyword: 'jaguar', color: Color(0xFF001E50), country: 'GB', logoAsset: '$_b/Jaguar Logo.svg', logoAssetDark: '$_b/Jaguar Logo Dark.svg'),
    VehicleBrand(name: 'Jeep', keyword: 'jeep', color: Color(0xFF3D523E), country: 'US', logoAsset: '$_b/Jeep Logo.svg', logoAssetDark: '$_b/Jeep Logo Dark.svg'),
    VehicleBrand(name: 'Kia', keyword: 'kia', color: Color(0xFF05141F), country: 'KR', logoAsset: '$_b/Kia Logo.svg', logoAssetDark: '$_b/Kia Logo Dark.svg'),
    VehicleBrand(name: 'Koenigsegg', keyword: 'koenigsegg', color: Color(0xFF1A1A1A), country: 'SE', logoAsset: '$_b/Koenigsegg Logo.svg', logoAssetDark: '$_b/Koenigsegg Logo Dark.svg'),
    VehicleBrand(name: 'Lamborghini', keyword: 'lamborghini', color: Color(0xFFDDB321), country: 'IT', logoAsset: '$_b/Lamborghini Logo.svg', logoAssetDark: '$_b/Lamborghini Logo Dark.svg'),
    VehicleBrand(name: 'Land Rover', keyword: 'land rover', color: Color(0xFF005A2B), country: 'GB', logoAsset: '$_b/Landrover Logo.svg', logoAssetDark: '$_b/Landrover Logo Dark.svg'),
    VehicleBrand(name: 'Lexus', keyword: 'lexus', color: Color(0xFF1A1A1A), country: 'JP', logoAsset: '$_b/Lexus Logo.svg', logoAssetDark: '$_b/Lexus Logo Dark.svg'),
    VehicleBrand(name: 'Lincoln', keyword: 'lincoln', color: Color(0xFF000000), country: 'US', logoAsset: '$_b/Lincoln Logo.svg', logoAssetDark: '$_b/Lincoln Logo Dark.svg'),
    VehicleBrand(name: 'Lotus', keyword: 'lotus', color: Color(0xFF3B5E3B), country: 'GB', logoAsset: '$_b/Lotus Logo.svg', logoAssetDark: '$_b/Lotus Logo Dark.svg'),
    VehicleBrand(name: 'Lucid', keyword: 'lucid', color: Color(0xFF1A1A1A), country: 'US', logoAsset: '$_b/Lucid Logo.svg', logoAssetDark: '$_b/Lucid Logo Dark.svg'),
    VehicleBrand(name: 'Maserati', keyword: 'maserati', color: Color(0xFF1C1C1C), country: 'IT', logoAsset: '$_b/Maserati Logo.svg', logoAssetDark: '$_b/Maserati Logo Dark.svg'),
    VehicleBrand(name: 'Mazda', keyword: 'mazda', color: Color(0xFF101820), country: 'JP', logoAsset: '$_b/Mazda Logo.svg', logoAssetDark: '$_b/Mazda Logo Dark.svg'),
    VehicleBrand(name: 'Mercedes-Benz', keyword: 'mercedes', color: Color(0xFF333333), country: 'DE', logoAsset: '$_b/MB Logo.svg', logoAssetDark: '$_b/MB Logo Dark.svg'),
    VehicleBrand(name: 'McLaren', keyword: 'mclaren', color: Color(0xFFFF8000), country: 'GB', logoAsset: '$_b/McLaren Logo.svg', logoAssetDark: '$_b/McLaren Logo Dark.svg'),
    VehicleBrand(name: 'Mini', keyword: 'mini', color: Color(0xFF0066B1), country: 'GB', logoAsset: '$_b/Mini Logo.svg', logoAssetDark: '$_b/Mini Logo Dark.svg'),
    VehicleBrand(name: 'Mitsubishi', keyword: 'mitsubishi', color: Color(0xFFE60012), country: 'JP', logoAsset: '$_b/Mitsubishi Logo.svg', logoAssetDark: '$_b/Mitsubishi Logo Dark.svg'),
    VehicleBrand(name: 'Nissan', keyword: 'nissan', color: Color(0xFFC3002F), country: 'JP', logoAsset: '$_b/Nissan Logo.svg', logoAssetDark: '$_b/Nissan Logo Dark.svg'),
    VehicleBrand(name: 'Pagani', keyword: 'pagani', color: Color(0xFF1A1A1A), country: 'IT', logoAsset: '$_b/Pagani Logo.svg', logoAssetDark: '$_b/Pagani Logo Dark.svg'),
    VehicleBrand(name: 'Polestar', keyword: 'polestar', color: Color(0xFF003DA5), country: 'SE', logoAsset: '$_b/Polestar Logo.svg', logoAssetDark: '$_b/Polestar Logo Dark.svg'),
    VehicleBrand(name: 'Porsche', keyword: 'porsche', color: Color(0xFFA31F34), country: 'DE', logoAsset: '$_b/Porsche Logo.svg', logoAssetDark: '$_b/Porsche Logo Dark.svg'),
    VehicleBrand(name: 'Ram', keyword: 'ram', color: Color(0xFF1C1C1C), country: 'US', logoAsset: '$_b/RAM Logo.svg', logoAssetDark: '$_b/RAM Logo Dark.svg'),
    VehicleBrand(name: 'Rivian', keyword: 'rivian', color: Color(0xFF48A84C), country: 'US', logoAsset: '$_b/Rivian Logo.svg', logoAssetDark: '$_b/Rivian Logo Dark.svg'),
    VehicleBrand(name: 'Rolls-Royce', keyword: 'rolls', color: Color(0xFF1A1A1A), country: 'GB', logoAsset: '$_b/Rolls Royce Logo.svg', logoAssetDark: '$_b/Rolls Royce Logo Dark.svg'),
    VehicleBrand(name: 'Subaru', keyword: 'subaru', color: Color(0xFF003DA5), country: 'JP', logoAsset: '$_b/Subaru Logo.svg', logoAssetDark: '$_b/Subaru Logo Dark.svg'),
    VehicleBrand(name: 'Tesla', keyword: 'tesla', color: Color(0xFFCC0000), country: 'US', logoAsset: '$_b/Tesla Logo.svg', logoAssetDark: '$_b/Tesla Logo Dark.svg'),
    VehicleBrand(name: 'Toyota', keyword: 'toyota', color: Color(0xFFEB0A1E), country: 'JP', logoAsset: '$_b/Toyota Logo.svg', logoAssetDark: '$_b/Toyota Logo Dark.svg'),
    VehicleBrand(name: 'VinFast', keyword: 'vinfast', color: Color(0xFF003DA5), country: 'VN', logoAsset: '$_b/Vinfast Logo.svg', logoAssetDark: '$_b/Vinfast Logo Dark.svg'),
    VehicleBrand(name: 'Volkswagen', keyword: 'volkswagen', color: Color(0xFF001E50), country: 'DE', logoAsset: '$_b/Volkswagen Logo.svg', logoAssetDark: '$_b/Volkswagen Logo Dark.svg'),
    VehicleBrand(name: 'Volvo', keyword: 'volvo', color: Color(0xFF003057), country: 'SE', logoAsset: '$_b/Volvo Logo.svg', logoAssetDark: '$_b/Volvo Logo Dark.svg'),

    // Additional brands without logos in the repo (use fallback)
    VehicleBrand(name: 'Opel', keyword: 'opel', color: Color(0xFF004B87), country: 'DE'),
    VehicleBrand(name: 'Smart', keyword: 'smart', color: Color(0xFFAABB00), country: 'DE'),
    VehicleBrand(name: 'Daihatsu', keyword: 'daihatsu', color: Color(0xFF003DA5), country: 'JP'),
    VehicleBrand(name: 'Isuzu', keyword: 'isuzu', color: Color(0xFF003DA5), country: 'JP'),
    VehicleBrand(name: 'Suzuki', keyword: 'suzuki', color: Color(0xFF003DA5), country: 'JP'),
    VehicleBrand(name: 'Daewoo', keyword: 'daewoo', color: Color(0xFF00529B), country: 'KR'),
    VehicleBrand(name: 'Renault', keyword: 'renault', color: Color(0xFFFBCC0A), country: 'FR'),
    VehicleBrand(name: 'Peugeot', keyword: 'peugeot', color: Color(0xFF1F3C73), country: 'FR'),
    VehicleBrand(name: 'Citroën', keyword: 'citroen', color: Color(0xFF6D6E71), country: 'FR'),
    VehicleBrand(name: 'Lancia', keyword: 'lancia', color: Color(0xFF8B1E3F), country: 'IT'),
    VehicleBrand(name: 'Range Rover', keyword: 'range rover', color: Color(0xFF005A2B), country: 'GB'),
    VehicleBrand(name: 'Saab', keyword: 'saab', color: Color(0xFF003057), country: 'SE'),
    VehicleBrand(name: 'Škoda', keyword: 'skoda', color: Color(0xFF4BA82E), country: 'CZ'),
    VehicleBrand(name: 'SEAT', keyword: 'seat', color: Color(0xFFC8102E), country: 'ES'),
    VehicleBrand(name: 'Cupra', keyword: 'cupra', color: Color(0xFF440028), country: 'ES'),
    VehicleBrand(name: 'Dacia', keyword: 'dacia', color: Color(0xFF003DA5), country: 'RO'),
    VehicleBrand(name: 'Lada', keyword: 'lada', color: Color(0xFFC8102E), country: 'RU'),
    VehicleBrand(name: 'Geely', keyword: 'geely', color: Color(0xFF003DA5), country: 'CN'),
    VehicleBrand(name: 'Chery', keyword: 'chery', color: Color(0xFF003DA5), country: 'CN'),
    VehicleBrand(name: 'Great Wall', keyword: 'great wall', color: Color(0xFFC8102E), country: 'CN'),
    VehicleBrand(name: 'Haval', keyword: 'haval', color: Color(0xFFC8102E), country: 'CN'),
    VehicleBrand(name: 'Changan', keyword: 'changan', color: Color(0xFF003DA5), country: 'CN'),
    VehicleBrand(name: 'NIO', keyword: 'nio', color: Color(0xFF003DA5), country: 'CN'),
    VehicleBrand(name: 'Xpeng', keyword: 'xpeng', color: Color(0xFF003DA5), country: 'CN'),
    VehicleBrand(name: 'Li Auto', keyword: 'li auto', color: Color(0xFF003DA5), country: 'CN'),
    VehicleBrand(name: 'Tata', keyword: 'tata', color: Color(0xFF1C3F7C), country: 'IN'),
    VehicleBrand(name: 'Mahindra', keyword: 'mahindra', color: Color(0xFFC8102E), country: 'IN'),
    VehicleBrand(name: 'Holden', keyword: 'holden', color: Color(0xFFC8102E), country: 'AU'),
    VehicleBrand(name: 'Pontiac', keyword: 'pontiac', color: Color(0xFFC8102E), country: 'US'),
    VehicleBrand(name: 'Oldsmobile', keyword: 'oldsmobile', color: Color(0xFF003DA5), country: 'US'),
    VehicleBrand(name: 'Saturn', keyword: 'saturn', color: Color(0xFF003DA5), country: 'US'),
    VehicleBrand(name: 'Plymouth', keyword: 'plymouth', color: Color(0xFFC8102E), country: 'US'),
    VehicleBrand(name: 'Mercury', keyword: 'mercury', color: Color(0xFF003DA5), country: 'US'),
    VehicleBrand(name: 'Scion', keyword: 'scion', color: Color(0xFF1A1A1A), country: 'JP'),
  ];
}
