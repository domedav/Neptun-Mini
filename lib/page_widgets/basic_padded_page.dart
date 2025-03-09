import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicPaddedPage extends StatelessWidget{
  static void push(BuildContext context, StatelessWidget pushWidget, {bool canDismiss = true, bool canPersist = true}){
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        maintainState: true,
        barrierDismissible: canDismiss,
        allowSnapshotting: canPersist,
        builder: (context){
          return Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: MediaQuery.of(context).padding,
              child: pushWidget,
            ),
          );
        }
      )
    );
  }

  final List<Widget> children;

  BasicPaddedPage({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: MediaQuery.of(context).padding,
      child: Stack(
        children: children,
      ),
    );
  }
}