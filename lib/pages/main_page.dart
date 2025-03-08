import 'package:flutter/material.dart';
import 'package:neptunmini/resources/strings.dart';

class AppMainPage extends StatefulWidget{
  final bool warnMissingStrings;

  AppMainPage({required this.warnMissingStrings});
  @override
  State<StatefulWidget> createState() => _AppMainPageState();
}

class _AppMainPageState extends State<AppMainPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return Text('${AppStrings.getString(AppStringIds.appName)} $index');
          },
        ),
      ),
    );
  }
}