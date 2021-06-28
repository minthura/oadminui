import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    inputDecorationTheme: inputDecorationTheme(),
    primarySwatch: kPrimaryColor,
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    fontFamily: GoogleFonts.notoSans().fontFamily,
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

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: kPrimaryColor.withAlpha(128),
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 1,
      ),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: kErrorColor,
        width: 1,
      ),
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
    headline6: TextStyle(color: kTextColor),
    caption: TextStyle(color: kTextColor),
  ).apply(
    bodyColor: kTextColor,
    displayColor: kTextColor,
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
