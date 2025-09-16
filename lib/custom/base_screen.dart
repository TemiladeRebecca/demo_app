import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final bool scrollable;
  final EdgeInsetsGeometry padding;

  const BaseScreen({
    super.key,
    required this.child,
    this.appBar,
    this.scrollable = false,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: scrollable ? SingleChildScrollView(child: child) : child,
        ),
      ),
    );
  }
}
