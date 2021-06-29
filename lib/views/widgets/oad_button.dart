import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OADButton extends StatelessWidget {
  const OADButton(
      {Key? key, this.isNegative = false, this.onPressed, required this.title})
      : super(key: key);
  final bool isNegative;
  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 100, minHeight: 40),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: isNegative
              ? MaterialStateProperty.all(Get.theme.errorColor)
              : MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled))
                      return Get.theme.primaryColor.withOpacity(0.5);
                    return Get
                        .theme.primaryColor; // Use the component's default.
                  },
                ),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
