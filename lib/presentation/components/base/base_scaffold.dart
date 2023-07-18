import 'package:flutter/material.dart';

import '../../../common/extensions/extensions.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.padding,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
    this.bottomNavigationBar,
  }) : super(key: key);

  final Widget body;
  final PreferredSizeWidget? appBar;
  final EdgeInsetsGeometry? padding;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final BottomNavigationBar? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: padding ?? 24.all,
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
