import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OADDatePicker extends StatefulWidget {
  const OADDatePicker({
    Key? key,
    this.labelText,
    this.errorText,
    this.onDateSelected,
    this.initialDate,
  }) : super(key: key);
  final String? labelText;
  final String? errorText;
  final Function(DateTime)? onDateSelected;
  final DateTime? initialDate;
  @override
  _OADDatePickerState createState() => _OADDatePickerState();
}

class _OADDatePickerState extends State<OADDatePicker> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    _textEditingController.text =
        DateFormat.yMMMd().format(widget.initialDate ?? DateTime.now());
    super.initState();
  }

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
        initialDate: widget.initialDate ?? DateTime.now(),
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

class OADDatePickerFormField extends FormField<DateTime> {
  OADDatePickerFormField({
    final DateTime? initialDate,
    String? labelText,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
  }) : super(
          initialValue: initialDate ?? DateTime.now(),
          onSaved: onSaved,
          validator: validator,
          builder: (state) => OADDatePicker(
            labelText: labelText,
            initialDate: state.value,
            onDateSelected: state.didChange,
          ),
        );
}
