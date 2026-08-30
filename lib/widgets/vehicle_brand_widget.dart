import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/vehicle_brands.dart';

class VehicleBrandWidget extends StatelessWidget {
  final String vehicleName;
  final double size;
  final bool isDefaultCarIcon;

  const VehicleBrandWidget({
    super.key,
    required this.vehicleName,
    this.size = 32,
    this.isDefaultCarIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final brand = VehicleBrands.detect(vehicleName);

    if (brand == null || isDefaultCarIcon) {
      return Icon(Icons.directions_car, size: size);
    }

    if (brand.logoAsset != null) {
      final brightness = Theme.of(context).brightness;
      final asset = (brightness == Brightness.dark && brand.logoAssetDark != null)
          ? brand.logoAssetDark!
          : brand.logoAsset!;
      return ClipOval(
        child: SvgPicture.asset(
          asset,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      );
    }

    // Generate a branded initial avatar
    final initial = brand.name.isNotEmpty ? brand.name[0].toUpperCase() : '?';
    final brightness = Theme.of(context).brightness;
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.white;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: brand.color,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: textColor,
          fontSize: size * 0.45,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
