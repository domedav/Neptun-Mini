import 'package:flutter/material.dart';
import 'package:neptunmini/page_widgets/basic_padded_page.dart';
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Szia!",
                          style: ThemeCore.styleBigText.copyWith(color: ThemeCore.colorPrimary),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Az app használatához szükséged lesz a neptunos naptárad linkjére.",
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
                      hintText: "Ide másold be",
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}