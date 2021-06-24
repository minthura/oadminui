import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: kPrimaryColor,
    accentColor: kAccentColor,
    textTheme: textTheme(),
    buttonColor: kButtonColor,
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: <TargetPlatform, PageTransitionsBuilder>{
    //     TargetPlatform.android: ZoomPageTransitionsBuilder(),
    //   },
    // ),
    pageTransitionsTheme: PageTransitionsTheme(
      // makes all platforms that can run Flutter apps display routes without any animation
      builders:
          Map<TargetPlatform, _InanimatePageTransitionsBuilder>.fromIterable(
              TargetPlatform.values.toList(),
              key: (dynamic k) => k,
              value: (dynamic _) => const _InanimatePageTransitionsBuilder()),
    ),
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline4: TextStyle(color: kTextColor),
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
    subtitle1: TextStyle(color: kTextColor.withOpacity(0.6)),
    subtitle2: TextStyle(color: kTextColor.withOpacity(0.6)),
  );
}

/// This class is used to build page transitions that don't have any animation
class _InanimatePageTransitionsBuilder extends PageTransitionsBuilder {
  const _InanimatePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}
