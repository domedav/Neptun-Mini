// flutter packages pub run build_runner build
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neptunmini/network/connection.dart';
import 'package:neptunmini/pages/main_page.dart';
import 'package:neptunmini/resources/locales.dart';
import 'package:neptunmini/resources/storage.dart';
import 'package:neptunmini/resources/strings.dart';
import 'package:neptunmini/resources/themes.dart';
import 'main.reflectable.dart';

void main() {
  initializeReflectable(); // flutter packages pub run build_runner build
  appBinding = WidgetsFlutterBinding.ensureInitialized();
  AppStorage.initializeKeys().whenComplete(()async{
    AppConnection.initializeConnection().whenComplete((){
      AppStrings.initializeStrings().then((result)async{
        print('String mode: $result');
        appLoadMode = result;
        if(appLoadMode == StringLoadMode.fatal){
          //TODO: implement some way to tell this to the user
          print("fatal error in loading the app");
          exit(1); // cant load the app, fatal error
          throw "fatal error in loading the app";
        }
        appRoot = const NeptunMiniRoot();
        runApp(appRoot);
        WidgetsBinding.instance.addObserver(appRoot);
        await AppThemes.initializeThemes();
        initializedThemes = true;
        // we can re-build the app, as soon as the appthemes are initialized, this ensures that the correct theme is shown for the user
        appBinding.drawFrame();
        Future(()async{
          print(await AppStorage.getData(AppStorageKeys.appStringsDownloadedVersion));
          print(await AppStorage.getData(AppStorageKeys.appStringsLastCheckTimestamp));
          print(await AppStorage.getData(AppStorageKeys.appStringsHasDownloaded));
          print(await AppStorage.getData(AppStorageKeys.appLastLaunchedVersionId));
          //print(await AppStorage.getData("appLanguagehu"));
        });
      });
    });
  });
}

/// Themes need to be initialized, in order to provide platform specific app theming
bool initializedThemes = false;

late NeptunMiniRoot appRoot;
late WidgetsBinding appBinding;
late StringLoadMode appLoadMode;

class NeptunMiniRoot extends StatelessWidget with WidgetsBindingObserver {
  const NeptunMiniRoot({super.key});

  /// User has changed the language of the device, without closing the app
  @override
  void didChangeLocales(List<Locale>? locales) {
    // reset current locale
    AppLocales.resetLocale();
    // Re-init the app strings
    AppStrings.initializeStrings();
    super.didChangeLocales(locales);
  }

  /// User has changed the native text size, without closing the app
  @override
  void didChangeTextScaleFactor() {
    // Re-init the app themes
    AppThemes.initializeThemes();
    super.didChangeTextScaleFactor();
  }

  /// User has changed the darkmode, without closing the app
  @override
  void didChangePlatformBrightness() {
    // Re-init the app themes
    AppThemes.initializeThemes();
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    //final palette = AppThemes.currentPalette;
    return MaterialApp(
      title: AppStrings.getString(AppStringIds.appName),
      theme: ThemeData(
        /*colorScheme: ColorScheme(
            brightness: palette.brightness,
            primary: palette.primary,
            onPrimary: palette.onPrimary,
            surface: palette.background,
            onSurface: palette.onBackground,
            // unsused colors
            secondary: palette.primary,
            onSecondary: palette.onPrimary,
            error: palette.primary,
            onError: palette.onPrimary,
        ),*/
        useMaterial3: true,
      ),
      scrollBehavior: MaterialScrollBehavior(), // This is to ensure the modern android-12 scrolling behaviour
      initialRoute: "/",
      routes: {
        // root page
        "/": (BuildContext context){
          if(!initializedThemes){
            // no concrete app theme, dont load anything
            return Scaffold();
          }
          return AppMainPage(warnMissingStrings: appLoadMode == StringLoadMode.warn);
        }
      },
    );
  }
}