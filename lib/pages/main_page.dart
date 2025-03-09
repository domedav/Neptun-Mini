import 'package:flutter/material.dart';
import 'package:neptunmini/page_widgets/basic_padded_page.dart';

import '../resources/themes.dart';
import '../use_widgets/app_text_field.dart';

class AppMainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BasicPaddedPage(
        child: Column(
          children: [

          ],
        )
      ),
    );
  }
}