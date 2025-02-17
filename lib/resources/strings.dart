import 'dart:convert';
import 'package:neptunmini/json/json_serializable.dart';
import 'package:reflectable/reflectable.dart';
import 'package:http/http.dart' as http;

final class StringsReflectable extends Reflectable {
  const StringsReflectable() : super(declarationsCapability, staticInvokeCapability, instanceInvokeCapability);
}

const stringsReflectable = const StringsReflectable();

/// All String values, regardless of current language
final class AppStrings{
  /// The default string, which is displayed when a string resource is missing
  static const String _defaultMissingString = "!MISSING!";
  /// This is called, to fetch all values from the selected language for use
  static Future<void> initializeStrings()async{
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
    // Get the new json to use
    Map<String, dynamic> json = jsonDecode(StringsManager._getSelectedLanguageJson());
    // Default value, when any else is missing
    _loadedStringRes.addAll({0: _defaultMissingString});
    // set up values, corresponding to the predefined
    mirror.declarations.forEach((key, _){
      if(_loadedStringRes.containsKey(key)){
        throw "Duplicate key found!";
      }
      else if(!json.containsKey(key)){
        throw "Key: '$key' is not in json!";
      }
      _loadedStringRes.addAll({mirror.invokeGetter(key) as int: json[key]});
    });

    final manifest = await StringsManager._fetchLanguageManifest();
    print(StringsManifest.toJson(StringsManifest.fromJson(StringsManifest.toJson(manifest))));
  }

  /// Obtain a string value by the given Id
  static String getStringById(int resourceId){
    if(!_loadedStringRes.containsKey(resourceId)){
      return _loadedStringRes[0]!;
    }
    return _loadedStringRes[resourceId]!;
  }

  /// Obtain a string value by the given Id, filling the placeholders with the given params
  static String getStringWithParams(int resourceId, List<dynamic> params){
    var string = getStringById(resourceId);
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
}

/// Stores the ids, which can be found in the language json
@stringsReflectable
final class AppStringIds{
  static bool _hasSetUp = false;
  //-------------------------------------
  // The names must match with the json
  static late final int appName;
  static late final int appDeveloper;
}

/// Responsible for any language downloading, and fetching logic
final class StringsManager{

  ///Returns the currently selected language json
  static String _getSelectedLanguageJson(){
    return "{}";
  }

  /// Defines the manifest on the server
  static const String _stringsManifestUrl = "https://raw.githubusercontent.com/domedav/Neptun-Mini/refs/heads/main/dynamic-resources/stringsmanifest.json";

  /// Download the manifest from the server
  static Future<StringsManifest> _fetchLanguageManifest()async{
    // Download manifest from server
    final response = jsonDecode((await http.get(Uri.parse(_stringsManifestUrl))).body) as Map<String, dynamic>;
    // Construct an instance, with proper values from the fetched
    ClassMirror mirror = stringsReflectable.reflectType(StringsManifest) as ClassMirror;
    InstanceMirror instance = stringsReflectable.reflect(StringsManifest());
    mirror.declarations.forEach((key, _){
      if(!response.containsKey(key)){
        throw "Key: '$key' is not in response json!";
      }
      // Set instance values from json keys dynamically
      instance.invokeSetter(key, response[key]);
    });
    return (instance.reflectee as StringsManifest);
  }
}

@stringsReflectable
/// Local manifest, this matches the one on the server
final class StringsManifest{
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