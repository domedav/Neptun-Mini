import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neptunmini/resources/themes.dart';

import 'app_icon.dart';

class AppTextField extends StatelessWidget{
  TextEditingController? controller;
  FocusNode? focusNode;
  final bool isPassword;
  final bool useAutocorrect;
  final Color colorTint;
  final Color duotoneTint;
  final Color unselectedColorTint;
  final String? hintText;
  final AppIcon? icon;
  AppTextField({this.controller, this.focusNode, this.isPassword = false, this.useAutocorrect = false, this.icon = null, required this.colorTint, required this.duotoneTint, required this.unselectedColorTint, this.hintText}){
    if(focusNode == null){
      focusNode = FocusNode();
    }
    if(controller == null){
      controller = TextEditingController();
    }
    focusNode!.addListener((){
      if(rebuild == null){
        return;
      }
      rebuild!((){
        _isFocused = focusNode!.hasFocus;
        _displayHintBorder = _isFocused || controller!.text.isNotEmpty;
      });
    });
  }

  void Function(void Function())? rebuild;
  bool _isFocused = false;
  bool _displayHintBorder = false;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        rebuild = setState;
        return TextSelectionTheme(
          data: TextSelectionThemeData(
            cursorColor: colorTint,
            selectionColor: unselectedColorTint,
            selectionHandleColor: colorTint
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            maxLines: 1,
            minLines: 1,
            enableSuggestions: useAutocorrect,
            enableIMEPersonalizedLearning: !isPassword,
            autocorrect: useAutocorrect,
            obscureText: isPassword,
            cursorColor: colorTint,
            scribbleEnabled: useAutocorrect,
            style: ThemeCore.styleNormalText.copyWith(color: colorTint),
            decoration: InputDecoration(
              suffixIcon: icon,
              alignLabelWithHint: true,
              labelStyle: ThemeCore.styleSmallText,
              label: hintText != null ? Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: _displayHintBorder ? duotoneTint : Colors.transparent,
                  border: Border.all(
                    color: _displayHintBorder ? colorTint : Colors.transparent,
                    width: 2,
                    style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(16))
                ),
                child: Text(
                  hintText! + (!_displayHintBorder ? '...' : ''),
                  style: ThemeCore.styleSmallText.apply(color: colorTint),
                ),
              ) : null,
              filled: true,
              fillColor: duotoneTint,
              focusColor: colorTint,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colorTint,
                  width: 2,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(16)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: unselectedColorTint,
                      width: 2,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(16)
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            ),
          ),
        );
      }
    );
  }
}