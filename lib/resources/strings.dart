import 'dart:convert';
import 'package:neptunmini/json/json_serializable.dart';
import 'package:neptunmini/network/connection.dart';
import 'package:neptunmini/resources/locales.dart';
import 'package:neptunmini/resources/network_loader.dart';
import 'package:neptunmini/resources/storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reflectable/reflectable.dart';

final class StringsReflectable extends Reflectable {
  const StringsReflectable() : super(declarationsCapability, staticInvokeCapability, instanceInvokeCapability);
}

const stringsReflectable = const StringsReflectable();

/// Stores the ids, which can be found in the language json
@stringsReflectable
class AppStringIds{
  static bool _hasSetUp = false;
  //-------------------------------------
  // The names must match with the json
  static late final int appName;
  static late final int appDeveloper;

  static late final int loginGreetHeaderText;
  static late final int loginGreetExplainingText;
  static late final int loginUrlInputFieldHint;
  static late final int loginUrlQuestionmarkHint;
}

@stringsReflectable
/// Local manifest, this matches the one on the server
class StringsManifest{
  late final int langpackVersion;
  late final String huUrl;
  late final String enUrl;
  late final String deUrl;
  late final String esUrl;

  /// Create a json from instance
  static String toJson(StringsManifest stringsManifest){
    return JsonSerialize.toJson(stringsReflectable, stringsManifest);
  }

  /// Create an instance from json
  static StringsManifest fromJson(String json){
    return JsonSerialize.fromJson(stringsReflectable, StringsManifest(), json);
  }
}

/// All String values, regardless of current language
class AppStrings{
  /// The default string, which is displayed when a string resource is missing
  static const String _defaultMissingString = "!MISSING!";
  static bool hasMissingStrings = false;
  /// This is called, to fetch all values from the selected language for use
  static Future<StringLoadMode> initializeStrings({bool forceRefresh = false})async{
    // Get the keys class
    ClassMirror mirror = stringsReflectable.reflectType(AppStringIds) as ClassMirror;
    // Multiple setups are allowed, for dynamic language change
    if(!AppStringIds._hasSetUp){
      // These fields are final, cant set more than once
      AppStringIds._hasSetUp = true;
      int count = 0;
      mirror.declarations.forEach((key, _){
        // set each field to an unique number
        mirror.invokeSetter(key, ++count);
      });
    }
    // Clear all, from previous lang
    _loadedStringRes.clear();
    // Default value, when any else is missing
    _loadedStringRes.addAll({0: _defaultMissingString});
    var loadMode = await _getStringLoadMode();
    if(forceRefresh){
      loadMode = StringLoadMode.online;
    }
    switch (loadMode){
      case StringLoadMode.warn:
      case StringLoadMode.offline:
        hasMissingStrings = loadMode == StringLoadMode.warn;
        final locale = AppLocales.getCurrentLocale();
        if(locale == AppLocale.none){
          return loadMode;
        }
        // set up language based on the locale
        final currentLocale = locale.name.toLowerCase();
        ClassMirror appStringIdsClass = stringsReflectable.reflectType(AppStringIds) as ClassMirror;
        _setupByJson(await AppStorage.getData<String>('appLanguage$currentLocale'), appStringIdsClass);
        return loadMode;

      case StringLoadMode.online:
        final manifest = await ResourceNetworkLoader.fetchLanguageManifest();
        final currentVersion = await AppStorage.getData<int>(AppStorageKeys.appStringsDownloadedVersion);
        if(manifest.langpackVersion == currentVersion){ // we are on the desired version, no need to download anything
          return loadMode;
        }

        final locale = AppLocales.getCurrentLocale();
        if(locale == AppLocale.none){
          return loadMode;
        }

        // contains all concurrent futures
        List<Future<dynamic>> futures = [];

        ClassMirror mirror = stringsReflectable.reflectType(StringsManifest) as ClassMirror;
        InstanceMirror instance = stringsReflectable.reflect(manifest);
        mirror.declarations.forEach((key, _){
          // loop thru all keys
          if(key.toLowerCase().contains('url')){
            // is a language property
            futures.add( // add to list
              Future(()async{
                // fetch json by key
                final json = await ResourceNetworkLoader.fetchLanguageFromUrl(instance.invokeGetter(key).toString());
                // save json onto key
                final newKey = key.toLowerCase().replaceAll('url', '');
                await AppStorage.setData('appLanguage$newKey', json.toString());
              })
            );
          }
        });
        // wait till all langauges are finalized
        await Future.wait(futures);

        // set up language based on the locale
        final currentLocale = locale.name.toLowerCase();
        ClassMirror appStringIdsClass = stringsReflectable.reflectType(AppStringIds) as ClassMirror;
        _setupByJson(await AppStorage.getData<String>('appLanguage$currentLocale'), appStringIdsClass);

        // if online execution, means we are 100% on the latest strings resources
        Future(()async{
          await AppStorage.setData(AppStorageKeys.appStringsHasDownloaded, true);
          await AppStorage.setData(AppStorageKeys.appStringsLastCheckTimestamp, DateTime.now().millisecondsSinceEpoch);
          await AppStorage.setData(AppStorageKeys.appLastLaunchedVersionId, int.parse((await PackageInfo.fromPlatform()).buildNumber));
          await AppStorage.setData(AppStorageKeys.appStringsDownloadedVersion, manifest.langpackVersion);
        });
        return loadMode;
      default:
        return loadMode;
    }
  }

  static void _setupByJson(String jsonString, ClassMirror mirror){
    final json = jsonDecode(jsonString) as Map<String, dynamic>;

    // set up values, corresponding to the json
    mirror.declarations.forEach((key, _){
      if(_loadedStringRes.containsKey(key)){
        throw "Duplicate key found!";
      }
      else if(!json.containsKey(key)){
        print("Key: '$key' is not in json!"); // non fatal error, as we can just use the missing resource
        return; // but we cant add null to the resources
      }
      _loadedStringRes.addAll({mirror.invokeGetter(key) as int: json[key]});
    });
  }

  /// Obtain a string value by the given Id
  static String getString(int resourceId){
    if(!_loadedStringRes.containsKey(resourceId)){
      return _loadedStringRes[0]!;
    }
    return _loadedStringRes[resourceId]!;
  }

  /// Obtain a string value by the given Id, filling the placeholders with the given params
  static String getStringWithParams(int resourceId, List<dynamic> params){
    var string = getString(resourceId);
    if(!string.contains('%1')){
      throw "The given string, doesnt support parameters!";
    }
    int replace = 0;
    for(var item in params){
      if(!string.contains('%$replace')){
        throw "More params are given than the string supports!";
      }
      string = string.replaceAll('%${++replace}', item);
    }
    return string;
  }

  /// The currently selected language strings loaded here, in this map
  static final Map<int, String> _loadedStringRes = {};

  static Future<StringLoadMode> _getStringLoadMode()async{
    final hasInternet = AppConnection.hasInternet() && !AppConnection.isDatasaver(); // we have internet, and we can download
    final hasDefaultStrings = await AppStorage.getData<bool>(AppStorageKeys.appStringsHasDownloaded); // do we have strings at all
    final lastCheckedTime = DateTime.fromMillisecondsSinceEpoch(await AppStorage.getData<int>(AppStorageKeys.appStringsLastCheckTimestamp)); // can we check for strings? we should only do this once a day
    final lastAppVersion = await AppStorage.getData<int>(AppStorageKeys.appLastLaunchedVersionId); // can we check for strings? we should only do this once a day
    final currentAppVersion = int.parse((await PackageInfo.fromPlatform()).buildNumber);
    if(!hasDefaultStrings && !hasInternet){ // no downloaded languages, and no internet to download them => fatal error, cant display anything to user
      return StringLoadMode.fatal; // cant use the app
    }
    else if(!hasInternet && lastAppVersion != currentAppVersion){ // no internet, and the app needs the new strings
        return StringLoadMode.warn; // can use the app, but warn user, that some resources are missing
    }
    else if(
      !hasInternet // no internet
      || (lastCheckedTime.add(Duration(days: 1)).millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch) // or already checked for new languages in 24h period
    ){
      return StringLoadMode.offline; // use the downloaded language
    }
    else {
      return StringLoadMode.online; // download language otherwise
    }
  }
}

enum StringLoadMode {
  online,
  offline,
  warn,
  fatal
}