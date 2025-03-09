import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
class AppIcon extends StatelessWidget{
  final PhosphorDuotoneIconData icon;
  final Color? color;
  final Color? duotoneColor;
  final double? iconSize;

  const AppIcon(this.icon, {super.key, required this.color, required this.duotoneColor, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return PhosphorIcon(
      icon,
      color: color,
      duotoneSecondaryColor: duotoneColor,
      duotoneSecondaryOpacity: 1,
      fill: 1,
      size: iconSize,
      opticalSize: iconSize,
    );
  }

}