// flutter packages pub run build_runner build
import 'dart:io';
import 'dart:ui';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:neptunmini/network/connection.dart';
import 'package:neptunmini/pages/login_page.dart';
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
        print('Has missing strings: ${AppStrings.hasMissingStrings}\nString mode: $result');
        if(result == StringLoadMode.fatal){
          //TODO: implement some way to tell this to the user
          print("fatal error in loading the app");
          exit(1); // cant load the app, fatal error
          throw "fatal error in loading the app";
        }
        appRoot = AppRoot();
        runApp(appRoot);
        WidgetsBinding.instance.addObserver(appRoot);
        Future(()async{
          print("App Strings Version: " + (await AppStorage.getData(AppStorageKeys.appStringsDownloadedVersion)).toString());
          print("Last Checked Strings Time: " + DateTime.fromMillisecondsSinceEpoch(await AppStorage.getData(AppStorageKeys.appStringsLastCheckTimestamp)).toString());
          print("App Launched Version: " + (await AppStorage.getData(AppStorageKeys.appLastLaunchedVersionId)).toString());
        });
      });
    });
  });
}

late AppRoot appRoot;
late WidgetsBinding appBinding;

class AppRoot extends StatelessWidget with WidgetsBindingObserver {
  void Function(void Function())? rebuild; // without this, we just cant rebuild this widget
  AppRoot({super.key});

  @override
  Future<AppExitResponse> didRequestAppExit() {
    WidgetsBinding.instance.removeObserver(appRoot); // cleanup
    rebuild = null;
    return super.didRequestAppExit();
  }

  /// User has changed the language of the device, without closing the app
  @override
  void didChangeLocales(List<Locale>? locales) {
    // reset current locale
    AppLocales.resetLocale();
    // Re-init the app strings
    AppStrings.initializeStrings();
    // re-build
    if(rebuild != null){
      rebuild!((){
        rebuild = null;
      });
    }
    super.didChangeLocales(locales);
  }

  /// User has changed the native text size, without closing the app
  @override
  void didChangeTextScaleFactor() {
    // re-build
    if(rebuild != null){
      rebuild!((){
        rebuild = null;
      });
    }
    super.didChangeTextScaleFactor();
  }

  /// User has changed the darkmode, without closing the app
  @override
  void didChangePlatformBrightness() {
    // re-build
    if(rebuild != null){
      rebuild!((){
        rebuild = null;
      });
    }
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        rebuild = setState;
        return DynamicColorBuilder(
          builder: ((ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            AppThemes.applyThemes(appBinding.platformDispatcher.platformBrightness, MediaQuery.of(context).textScaler, lightMaterialYou: lightDynamic, darkMaterialYou: darkDynamic);
            return MaterialApp(
              title: AppStrings.getString(AppStringIds.appName),
              theme: _getThemeData(),
              scrollBehavior: MaterialScrollBehavior(), // This is to ensure the modern android-12 scrolling behaviour
              initialRoute: '/',
              routes: {
                '/': (context){
                  return AppLoginPage();
                },
                '/login': (context){
                  return AppLoginPage();
                },
                '/main': (context){
                  return AppMainPage();
                },
              },
            );
          }
        ));
      }
    );
  }

  ThemeData _getThemeData(){
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: ThemeCore.brightnessTheme,
        primary: ThemeCore.colorPrimary,
        onPrimary: ThemeCore.colorOnPrimary,
        surface: ThemeCore.colorBackground,
        onSurface: ThemeCore.colorOnBackground,
        secondary: ThemeCore.colorPrimaryVariant,
        onSecondary: ThemeCore.colorOnPrimaryVariant,
        // unset
        error: Colors.red.shade800,
        onError: Colors.redAccent.shade100,
      ),
      useMaterial3: true,
    );
  }
}