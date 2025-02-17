import 'package:flutter/material.dart';
import 'package:neptunmini/network/connection.dart';
import 'package:neptunmini/resources/strings.dart';
import 'main.reflectable.dart';

void main() {
  initializeReflectable(); // flutter packages pub run build_runner build
  final binding = WidgetsFlutterBinding.ensureInitialized();
  AppConnection.initializeConnection().whenComplete((){
    AppStrings.initializeStrings().whenComplete((){
      final app = const NeptunMiniRoot();
      runApp(app);
      WidgetsBinding.instance.addObserver(app);
    });
  });
}

class NeptunMiniRoot extends StatelessWidget with WidgetsBindingObserver {
  const NeptunMiniRoot({super.key});

  /// User has changed the language of the device, without closing the app
  @override
  void didChangeLocales(List<Locale>? locales) {
    // Re-init the strings, from the appropriate json
    AppStrings.initializeStrings();
    super.didChangeLocales(locales);
  }

  /// User has changed the native text size, without closing the app
  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
    super.didChangeTextScaleFactor();
  }

  /// User has changed the darkmode, without closing the app
  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.getStringById(AppStringIds.appName),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
