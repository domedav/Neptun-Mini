import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neptunmini/resources/strings.dart';
import 'package:reflectable/mirrors.dart';

/// Loads resources from the web
class ResourceNetworkLoader{
  /// Defines the manifest on the server
  static const String _stringsManifestUrl = "https://raw.githubusercontent.com/domedav/Neptun-Mini/refs/heads/main/dynamic-resources/stringsmanifest.json";

  /// Download the manifest from the server
  static Future<StringsManifest> fetchLanguageManifest()async{
    // Download manifest from server
    final response = jsonDecode(
        (await http.get(Uri.parse(_stringsManifestUrl))).body
    ) as Map<String, dynamic>;
    // Construct an instance, with proper values from the fetched
    ClassMirror mirror = stringsReflectable.reflectType(StringsManifest) as ClassMirror;
    InstanceMirror instance = stringsReflectable.reflect(StringsManifest());
    mirror.declarations.forEach((key, _){
      if(mirror.staticMembers.containsKey(key)){
        return; // ignore static function calls
      }
      else if(!response.containsKey(key)){
        throw "Key: '$key' is not in response json!";
      }
      // Set instance values from json keys dynamically
      instance.invokeSetter(key, response[key]);
    });
    return (instance.reflectee as StringsManifest);
  }

  static Future<String> fetchLanguageFromUrl(String url)async{
    print('Downloading from url: $url');
    final response = jsonDecode(
        (await http.get(Uri.parse(url))).body
    ).toString();
    return response;
  }
}