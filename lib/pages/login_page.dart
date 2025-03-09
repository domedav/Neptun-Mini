import 'package:flutter/material.dart';
import 'package:neptunmini/page_widgets/basic_padded_page.dart';
import 'package:neptunmini/resources/strings.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../resources/themes.dart';
import '../use_widgets/app_icon.dart';
import '../use_widgets/app_text_field.dart';

class AppLoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AppLoginPageState();
}

class _AppLoginPageState extends State<AppLoginPage>{

  TextEditingController _urlInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasicPaddedPage(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.getString(AppStringIds.loginGreetHeaderText),
                            style: ThemeCore.styleBigText.copyWith(color: ThemeCore.colorPrimary),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            AppStrings.getString(AppStringIds.loginGreetExplainingText),
                            style: ThemeCore.styleNormalText.copyWith(color: ThemeCore.colorPrimary),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Flexible(
                      child: AppTextField(
                        controller: _urlInputController,
                        colorTint: ThemeCore.colorPrimary,
                        unselectedColorTint: ThemeCore.colorSemiTonedPrimary,
                        duotoneTint: ThemeCore.colorDuoTonedPrimary,
                        icon: AppIcon(
                          PhosphorIconsDuotone.linkSimple,
                          color: ThemeCore.colorPrimary,
                          duotoneColor: ThemeCore.colorDuoTonedPrimary,
                          iconSize: ThemeCore.styleIconSizeNormal,
                        ),
                        hintText: AppStrings.getString(AppStringIds.loginUrlInputFieldHint),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: ThemeCore.colorBackground,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: ThemeCore.colorOnBackground,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: ThemeCore.colorPrimary,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: ThemeCore.colorOnPrimary,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: ThemeCore.colorPrimaryVariant,
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: ThemeCore.colorOnPrimaryVariant,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}