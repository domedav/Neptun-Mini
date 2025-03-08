import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neptunmini/json/json_serializable.dart';
import 'package:reflectable/reflectable.dart';

final class ThemesReflectable extends Reflectable {
  const ThemesReflectable() : super(declarationsCapability, staticInvokeCapability, instanceInvokeCapability);
}

const themesReflectable = const ThemesReflectable();

/// The app specific themes are stored here
class AppThemes{
  /// the currently active theme
  static late Theme currentTheme;
  /// the currently active color palette
  static late ColorPalette currentPalette;

  /// set up the app theme
  /// call multiple times, when application theming is changed
  static Future<void> initializeThemes()async{

  }
}

@themesReflectable
/// The color palette, which the app coloring is based on
/// base - the color to draw shapes with
/// onBase - the color to draw text or other visual elements, on base colored shapes
class ColorPalette{
  late final Brightness brightness;

  late final Color background;
  late final Color onBackground;

  late final Color primary;
  late final Color onPrimary;

  late final Color primaryVariant;
  late final Color onPrimaryVariant;

  /// Create a json from instance
  static String toJson(ColorPalette colorPalette){
    return JsonSerialize.toJson(themesReflectable, colorPalette);
  }

  /// Create an instance from json
  static ColorPalette fromJson(String json){
    return JsonSerialize.fromJson(themesReflectable, ColorPalette(), json);
  }
}

@themesReflectable
/// The app specific theming of objects are set up here
class ThemeCore{

}