import 'package:reflectable/reflectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class StorageReflectable extends Reflectable {
  const StorageReflectable() : super(declarationsCapability, staticInvokeCapability);
}

const storageReflectable = const StorageReflectable();

/// Manages data storing
class AppStorage{
  /// Only allows setting this class up once
  static bool _hasSetUp = false;
  /// Give the predefined keys their value
  static Future<void> initializeKeys()async{
    if(_hasSetUp){
      return;
    }
    _hasSetUp = true;
    // Make the keys value, themselves
    ClassMirror mirror = storageReflectable.reflectType(AppStorageKeys) as ClassMirror;
    // Have to use future foreach, due to future usage inside
    await Future.forEach(mirror.declarations.keys, (key)async{
      // Ignore default values, as their parent values have already used them
      if(key.startsWith("default_")){
        return;
      }
      if(!mirror.declarations.containsKey("default_$key")){
        throw "No default value for '$key'!";
      }
      // set each field to its own value
      mirror.invokeSetter(key, key);
      // If there is no default value present, we set it
      if(!await hasKey(key)){
        await setData(key, mirror.invokeGetter("default_$key"));
      }
    });
  }

  /// Preference instance
  static Future<SharedPreferences> _getPrefs()async{
    return await SharedPreferences.getInstance();
  }

  /// Deletes all data from this
  static Future<void> clearData() async{
    await _getPrefs().then((prefs)async{
      await prefs.clear();
    });
  }

  /// Check if this store has a value paired to the given key
  static Future<bool> hasKey(String key) async{
    if(key == "" || key == " ") {
      throw "Given key was null or empty!";
    }
    return await _getPrefs().then((prefs)async{
      return prefs.containsKey(key);
    });
  }

  /// Gets rid of a data, where the key matches
  static Future<void> removeData(String key) async{
    if(key == "" || key == " ") {
      throw "Given key was null or empty!";
    }
    await _getPrefs().then((prefs)async{
      if(!await hasKey(key)){
        throw "Key '$key' doesnt exist in database!";
      }
      await prefs.remove(key);
    });
  }

  /// Get the value of the given key
  static Future<T> getData<T>(String key) async{
    return _getPrefs().then((prefs)async{
      if(key == "" || key == " ") {
        throw "Given key was null or empty!";
      }
      if(!(await hasKey(key))){
        throw "Key '$key' doesnt exist in database!";
      }
      switch(prefs.getString('${key}___TYPE___')!){
        case "int":
          return prefs.getInt(key)! as T;
        case "double":
          return prefs.getDouble(key)! as T;
        case "bool":
          return prefs.getBool(key)! as T;
        case "string":
          return prefs.getString(key)! as T;
        default:
          throw "Given type is invalid!";
      }
    });
  }

  /// Set the data of a key, into the store
  static Future<void> setData<T>(String key, T value) async{
    return _getPrefs().then((prefs)async{
      if(key == "" || key == " ") {
        throw "Given key was null or empty!";
      }
      switch(value.runtimeType.toString().toLowerCase()){
        case "int":
          await prefs.setInt(key, value as int);
          await prefs.setString('${key}___TYPE___', 'int');
          break;
        case "double":
          await prefs.setDouble(key, value as double);
          await prefs.setString('${key}___TYPE___', 'double');
          break;
        case "bool":
          await prefs.setBool(key, value as bool);
          await prefs.setString('${key}___TYPE___', 'bool');
          break;
        case "string":
          await prefs.setString(key, value as String);
          await prefs.setString('${key}___TYPE___', 'string');
          break;
        default:
          throw "Given type is invalid!";
      }
    });
  }
}

@storageReflectable
/// Stores the keys, which can be used for storing data
class AppStorageKeys{
  static late final String appStringsHasDownloaded;
  static const bool default_appStringsHasDownloaded = false;

  static late final String appStringsLastCheckTimestamp;
  static const int default_appStringsLastCheckTimestamp = 0;

  static late final String appStringsDownloadedVersion;
  static const int default_appStringsDownloadedVersion = 0;

  static late final String appLastLaunchedVersionId;
  static const int default_appLastLaunchedVersionId = 0;
}