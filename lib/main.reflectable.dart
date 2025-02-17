// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
import 'dart:core';
import 'package:neptunmini/resources/strings.dart' as prefix0;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const
// ignore_for_file: unused_import

import 'package:reflectable/mirrors.dart' as m;
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.StringsReflectable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'AppStringIds',
            r'.AppStringIds',
            134217735,
            0,
            const prefix0.StringsReflectable(),
            const <int>[0, 1],
            const <int>[11, 12, 13, 14, 15],
            const <int>[7, 8, 9, 10],
            -1,
            {
              r'appName': () => prefix0.AppStringIds.appName,
              r'appDeveloper': () => prefix0.AppStringIds.appDeveloper
            },
            {
              r'appName=': (dynamic value) =>
                  prefix0.AppStringIds.appName = value,
              r'appDeveloper=': (dynamic value) =>
                  prefix0.AppStringIds.appDeveloper = value
            },
            {},
            -1,
            -1,
            const <int>[-1],
            null,
            null),
        r.NonGenericClassMirrorImpl(
            r'StringsManifest',
            r'.StringsManifest',
            134217735,
            1,
            const prefix0.StringsReflectable(),
            const <int>[2, 3, 4, 5, 6],
            const <int>[
              11,
              12,
              13,
              14,
              15,
              16,
              17,
              18,
              19,
              20,
              21,
              22,
              23,
              24,
              25
            ],
            const <int>[],
            -1,
            {},
            {},
            {},
            -1,
            -1,
            const <int>[-1],
            null,
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(r'appName', 134349845, 0,
            const prefix0.StringsReflectable(), -1, -1, -1, null, null),
        r.VariableMirrorImpl(r'appDeveloper', 134349845, 0,
            const prefix0.StringsReflectable(), -1, -1, -1, null, null),
        r.VariableMirrorImpl(r'langpackVersion', 134349829, 1,
            const prefix0.StringsReflectable(), -1, -1, -1, null, null),
        r.VariableMirrorImpl(r'huUrl', 134349829, 1,
            const prefix0.StringsReflectable(), -1, -1, -1, null, null),
        r.VariableMirrorImpl(r'enUrl', 134349829, 1,
            const prefix0.StringsReflectable(), -1, -1, -1, null, null),
        r.VariableMirrorImpl(r'deUrl', 134349829, 1,
            const prefix0.StringsReflectable(), -1, -1, -1, null, null),
        r.VariableMirrorImpl(r'esUrl', 134349829, 1,
            const prefix0.StringsReflectable(), -1, -1, -1, null, null),
        r.ImplicitGetterMirrorImpl(const prefix0.StringsReflectable(), 0, 7),
        r.ImplicitSetterMirrorImpl(const prefix0.StringsReflectable(), 0, 8),
        r.ImplicitGetterMirrorImpl(const prefix0.StringsReflectable(), 1, 9),
        r.ImplicitSetterMirrorImpl(const prefix0.StringsReflectable(), 1, 10),
        r.MethodMirrorImpl(r'==', 2097154, -1, -1, -1, -1, null, const <int>[2],
            const prefix0.StringsReflectable(), null),
        r.MethodMirrorImpl(r'toString', 2097154, -1, -1, -1, -1, null,
            const <int>[], const prefix0.StringsReflectable(), null),
        r.MethodMirrorImpl(r'noSuchMethod', 524290, -1, -1, -1, -1, null,
            const <int>[3], const prefix0.StringsReflectable(), null),
        r.MethodMirrorImpl(r'hashCode', 2097155, -1, -1, -1, -1, null,
            const <int>[], const prefix0.StringsReflectable(), null),
        r.MethodMirrorImpl(r'runtimeType', 2097155, -1, -1, -1, -1, null,
            const <int>[], const prefix0.StringsReflectable(), null),
        r.ImplicitGetterMirrorImpl(const prefix0.StringsReflectable(), 2, 16),
        r.ImplicitSetterMirrorImpl(const prefix0.StringsReflectable(), 2, 17),
        r.ImplicitGetterMirrorImpl(const prefix0.StringsReflectable(), 3, 18),
        r.ImplicitSetterMirrorImpl(const prefix0.StringsReflectable(), 3, 19),
        r.ImplicitGetterMirrorImpl(const prefix0.StringsReflectable(), 4, 20),
        r.ImplicitSetterMirrorImpl(const prefix0.StringsReflectable(), 4, 21),
        r.ImplicitGetterMirrorImpl(const prefix0.StringsReflectable(), 5, 22),
        r.ImplicitSetterMirrorImpl(const prefix0.StringsReflectable(), 5, 23),
        r.ImplicitGetterMirrorImpl(const prefix0.StringsReflectable(), 6, 24),
        r.ImplicitSetterMirrorImpl(const prefix0.StringsReflectable(), 6, 25)
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(
            r'_appName',
            134348902,
            8,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null),
        r.ParameterMirrorImpl(
            r'_appDeveloper',
            134348902,
            10,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null),
        r.ParameterMirrorImpl(
            r'other',
            134348806,
            11,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null),
        r.ParameterMirrorImpl(
            r'invocation',
            134348806,
            13,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null),
        r.ParameterMirrorImpl(
            r'_langpackVersion',
            134348902,
            17,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null),
        r.ParameterMirrorImpl(
            r'_huUrl',
            134348902,
            19,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null),
        r.ParameterMirrorImpl(
            r'_enUrl',
            134348902,
            21,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null),
        r.ParameterMirrorImpl(
            r'_deUrl',
            134348902,
            23,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null),
        r.ParameterMirrorImpl(
            r'_esUrl',
            134348902,
            25,
            const prefix0.StringsReflectable(),
            -1,
            -1,
            -1,
            null,
            null,
            null,
            null)
      ],
      <Type>[prefix0.AppStringIds, prefix0.StringsManifest],
      2,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'langpackVersion': (dynamic instance) => instance.langpackVersion,
        r'huUrl': (dynamic instance) => instance.huUrl,
        r'enUrl': (dynamic instance) => instance.enUrl,
        r'deUrl': (dynamic instance) => instance.deUrl,
        r'esUrl': (dynamic instance) => instance.esUrl
      },
      {
        r'langpackVersion=': (dynamic instance, value) =>
            instance.langpackVersion = value,
        r'huUrl=': (dynamic instance, value) => instance.huUrl = value,
        r'enUrl=': (dynamic instance, value) => instance.enUrl = value,
        r'deUrl=': (dynamic instance, value) => instance.deUrl = value,
        r'esUrl=': (dynamic instance, value) => instance.esUrl = value
      },
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
