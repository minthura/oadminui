import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker(
      {Key? key, this.labelText, this.errorText, this.onDateSelected})
      : super(key: key);
  final String? labelText;
  final String? errorText;
  final Function(DateTime)? onDateSelected;
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: AlwaysDisabledFocusNode(),
      onTap: () => _showDatePicker(context, _textEditingController),
      controller: _textEditingController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        suffixIcon: Icon(CupertinoIcons.calendar),
      ),
    );
  }

  _showDatePicker(
      BuildContext context, TextEditingController textEditingController) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      textEditingController.text = DateFormat.yMMMd().format(selectedDate);
      if (widget.onDateSelected != null) widget.onDateSelected!(selectedDate);
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
