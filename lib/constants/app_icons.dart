import 'package:flutter/material.dart';

class AppIcons {
  static const String _basePath = 'assets/icons';

  static const IconData add = Icons.add;
  static const IconData notepad = Icons.note;
  static const IconData importFile = Icons.file_download;

  static const String gasCan = '$_basePath/ic_gas_can.png';
  static const String fuelGauge = '$_basePath/fuel_gauge.png';
  static const String plotImage = '$_basePath/ic_plot.png';
  static const String statsImage = '$_basePath/ic_stats.png';

  static Widget getGasCanIcon({double size = 48}) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        gasCan,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.local_gas_station,
          size: size,
          color: Colors.green,
        ),
      ),
    );
  }

  static Widget getPlotIcon({double size = 24}) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        plotImage,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.show_chart,
          size: size,
        ),
      ),
    );
  }

  static Widget getStatsIcon({double size = 24}) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        statsImage,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.bar_chart,
          size: size,
        ),
      ),
    );
  }

  static Widget getFuelGaugeIcon({double size = 96}) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        fuelGauge,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.local_gas_station,
          size: size,
          color: Colors.green,
        ),
      ),
    );
  }
}
