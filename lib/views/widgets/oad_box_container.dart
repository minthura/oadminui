import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OADBoxContainer extends StatelessWidget {
  final String label;
  const OADBoxContainer(
      {Key? key, required this.child, required this.label, this.errorText})
      : super(key: key);
  final Widget child;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: errorText == null
                        ? Get.theme.primaryColor.withAlpha(128)
                        : Get.theme.errorColor,
                    width: errorText == null ? 1 : 2,
                  ),
                ),
                child: child,
              ),
            ),
            errorText == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 24, top: 4),
                    child: Text(
                      '$errorText',
                      style:
                          TextStyle(color: Get.theme.errorColor, fontSize: 12),
                    ),
                  )
          ],
        ),
        Positioned(
          left: 24,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              color: Colors.white,
              child: Text(
                label,
                style: TextStyle(
                    color:
                        errorText == null ? Colors.grey : Get.theme.errorColor,
                    fontSize: 12),
              )),
        ),
      ],
    );
  }
}
