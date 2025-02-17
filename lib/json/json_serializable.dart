import 'dart:convert';
import 'package:reflectable/reflectable.dart';

/// Responsible to serialize, and deserialize json
final class JsonSerialize{
  /// Serialize a json, by reflection, and instance
  static String toJson<T>(Reflectable reflector, T tInstance){
    Map<String, dynamic> result = {};

    ClassMirror mirror = reflector.reflectType(T) as ClassMirror;
    InstanceMirror instance = reflector.reflect(tInstance as Object);

    // Create a json from the class
    mirror.declarations.forEach((key, _){
      result.addAll({key: instance.invokeGetter(key)});
    });

    return jsonEncode(result);
  }

  /// Deserialize a json, into an instance, by reflection
  static T fromJson<T>(Reflectable reflector, T tInstance, String json){
    final result = jsonDecode(json) as Map<String, dynamic>;

    ClassMirror mirror = reflector.reflectType(T) as ClassMirror;
    InstanceMirror instance = reflector.reflect(tInstance as Object);

    // Apply values back into the instance, from the json
    mirror.declarations.forEach((key, _){
      instance.invokeSetter(key, result[key]);
    });

    return (instance.reflectee as T);
  }
}