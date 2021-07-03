import 'package:flutter/material.dart';

class OADCheckbox extends StatefulWidget {
  const OADCheckbox(
      {Key? key, this.isChecked, this.onChanged, required this.label})
      : super(key: key);
  @override
  _OADCheckboxState createState() => _OADCheckboxState();
  final bool? isChecked;
  final Function(bool? value)? onChanged;
  final String label;
}

class _OADCheckboxState extends State<OADCheckbox> {
  bool? _state;
  @override
  void initState() {
    _state = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.label),
      leading: Checkbox(
        value: _state ?? false,
        onChanged: (value) {
          setState(() {
            _state = _state == null ? true : !_state!;
            if (widget.onChanged != null) widget.onChanged!(_state);
          });
        },
      ),
    );
  }
}

class OADCheckboxFormField extends FormField<bool> {
  OADCheckboxFormField({
    required String title,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          builder: (state) => OADCheckbox(
            label: title,
            onChanged: state.didChange,
            isChecked: state.value,
          ),
          initialValue: false,
        );
}
