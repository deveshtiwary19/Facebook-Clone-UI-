import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  Responsive({@required this.mobile, this.tablet, @required this.desktop});

  //Following are teh static methods, to getthe device side and respectively decide mobile, deskto or Tablet
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 900;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      //Returning different widget styles, according to teh screen width
      if (constraints.maxWidth >= 1200) {
        return desktop;
      } else if (constraints.maxWidth >= 900) {
        return tablet ?? mobile;
      } else {
        return mobile;
      }
    });
  }
}
