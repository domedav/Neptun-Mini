import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:neptunmini/json/json_serializable.dart';
import 'package:reflectable/reflectable.dart';

final class ThemesReflectable extends Reflectable {
  const ThemesReflectable() : super(declarationsCapability, staticInvokeCapability, instanceInvokeCapability);
}

const themesReflectable = const ThemesReflectable();

@themesReflectable
/// The color palette, which the app coloring is based on, use ThemeCore for coloring
/// base - the color to draw shapes with
/// onBase - the color to draw text or other visual elements, on base colored shapes
class ColorPalette{
  late final Brightness? brightness;

  late final Color? background;
  late final Color? onBackground;

  late final Color? primary;
  late final Color? onPrimary;

  late final Color? primaryVariant;
  late final Color? onPrimaryVariant;

  ColorPalette([this.brightness, this.background, this.onBackground, this.primary, this.onPrimary, this.primaryVariant, this.onPrimaryVariant]);

  /// Create a json from instance
  static String toJson(ColorPalette colorPalette){
    return JsonSerialize.toJson(themesReflectable, colorPalette);
  }

  /// Create an instance from json
  static ColorPalette fromJson(String json){
    return JsonSerialize.fromJson(themesReflectable, ColorPalette(), json);
  }
}

/// The app specific theming of objects are set up here
class ThemeCore{
  static Brightness get brightnessTheme{
    return AppThemes._currentPalette.brightness!;
  }

  static Color get colorBackground{
    return AppThemes._currentPalette.background!;
  }

  static Color get colorOnBackground{
    return AppThemes._currentPalette.onBackground!;
  }

  static Color get colorPrimary{
    return AppThemes._currentPalette.primary!;
  }

  static Color get colorOnPrimary{
    return AppThemes._currentPalette.onPrimary!;
  }

  static Color get colorPrimaryVariant{
    return AppThemes._currentPalette.primaryVariant!;
  }

  static Color get colorOnPrimaryVariant{
    return AppThemes._currentPalette.onPrimaryVariant!;
  }

  static Color get colorSemiTonedBackground{
    final background = AppThemes._currentPalette.background!;
    return Color.lerp(Color.from(alpha: background.a, red: background.r, green: background.g, blue: background.b), _colorBrightnessToning, .5)!;
  }

  static Color get colorDuoTonedBackground{
    final background = AppThemes._currentPalette.background!;
    return Color.lerp(Color.from(alpha: background.a * .4, red: background.r, green: background.g, blue: background.b), _colorBrightnessToning, .75)!;
  }

  static Color get colorSemiTonedPrimary{
    final primary = AppThemes._currentPalette.primary!;
    return Color.lerp(Color.from(alpha: primary.a, red: primary.r, green: primary.g, blue: primary.b), _colorBrightnessToning, .5)!;
  }

  static Color get colorDuoTonedPrimary{
    final primary = AppThemes._currentPalette.primary!;
    return Color.lerp(Color.from(alpha: primary.a * .4, red: primary.r, green: primary.g, blue: primary.b), _colorBrightnessToning, .75)!;
  }

  static Color get _colorBrightnessToning{
    final brightness = AppThemes._currentPalette.brightness!;
    return brightness == Brightness.dark ? Colors.black : Colors.white;
  }

  static TextStyle get styleNormalText {
    return TextStyle(
      fontSize: AppThemes._textScaler.scale(14),
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.fade
    );
  }

  static TextStyle get styleBigText {
    return styleNormalText.copyWith(
      fontSize: AppThemes._textScaler.scale(22),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle get styleSmallText {
    return styleNormalText.copyWith(
      fontSize: AppThemes._textScaler.scale(10),
      fontWeight: FontWeight.w400
    );
  }

  static double get styleIconSizeNormal {
    return AppThemes._textScaler.scale(styleNormalText.fontSize! + 8);
  }

  static double get styleIconSizeSmall {
    return AppThemes._textScaler.scale(styleSmallText.fontSize! + 4);
  }

  static double get styleIconSizeBig {
    return AppThemes._textScaler.scale(styleBigText.fontSize! + 12);
  }
}

/// The app specific themes are stored here
class AppThemes{
  static bool _initialized = false;

  /// the currently active color palette
  static late ColorPalette _currentPalette;

  /// does the user have big text enabled
  static late TextScaler _textScaler;

  /// set up the app theme
  /// call multiple times, when application theming is changed
  static void applyThemes(Brightness platformBrightness, TextScaler textScaler, {ColorScheme? lightMaterialYou, ColorScheme? darkMaterialYou})async{
    if(!_initialized){
      _fallbackLightPalette = ColorPalette(
        Brightness.light,
        Color.fromARGB(0xFF, 0xD5, 0xD5, 0xD5),
        Color.fromARGB(0xFF, 0x1D, 0x1F, 0x1F),
        Color.fromARGB(0xFF, 0x37, 0x3F, 0x3E),
        Color.fromARGB(0xFF, 0xB4, 0xD6, 0xD4),
        Color.fromARGB(0xFF, 0x26, 0x32, 0x31),
        Color.fromARGB(0xFF, 0x9D, 0xCF, 0xCC),
      );
      _fallbackDarkPalette = ColorPalette(
        Brightness.dark,
        Color.fromARGB(0xFF, 0x21, 0x21, 0x21),
        Color.fromARGB(0xFF, 0xCE, 0xD5, 0xD5),
        Color.fromARGB(0xFF, 0xB4, 0xD6, 0xD4),
        Color.fromARGB(0xFF, 0x37, 0x3F, 0x3E),
        Color.fromARGB(0xFF, 0x9D, 0xCF, 0xCC),
        Color.fromARGB(0xFF, 0x26, 0x32, 0x31),
      );
      _initialized = true;
    }
    _textScaler = textScaler;
    if(lightMaterialYou != null && platformBrightness == lightMaterialYou.brightness){ // user has material you, and is using light theme
      _currentPalette = ColorPalette(
        Brightness.light,
        lightMaterialYou.surface,
        lightMaterialYou.onSurface,
        lightMaterialYou.primary,
        lightMaterialYou.primaryContainer,
        lightMaterialYou.onPrimary,
        lightMaterialYou.onPrimaryContainer
      );
    }
    else if(darkMaterialYou != null && platformBrightness == darkMaterialYou.brightness){ // user has material you, and is using dark theme
      _currentPalette = ColorPalette(
          Brightness.dark,
          darkMaterialYou.surface,
          darkMaterialYou.onSurface,
          darkMaterialYou.primary,
          darkMaterialYou.primaryContainer,
          darkMaterialYou.onPrimary,
          darkMaterialYou.onPrimaryContainer
      );
    }
    else{
      // usually never gets called, but just in case
      _currentPalette = platformBrightness == Brightness.light ? _fallbackLightPalette : _fallbackDarkPalette;
    }
  }

  static late ColorPalette _fallbackLightPalette;
  static late ColorPalette _fallbackDarkPalette;
}