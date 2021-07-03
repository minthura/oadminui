import 'package:flutter/material.dart';

class OADRadioGroup extends StatefulWidget {
  const OADRadioGroup({
    Key? key,
    required this.values,
    this.onChanged,
    this.selectedValue = '',
  }) : super(key: key);
  final List<String> values;
  final String selectedValue;
  final Function(int index, String value)? onChanged;

  @override
  _OADRadioGroupState createState() => _OADRadioGroupState();
}

class _OADRadioGroupState extends State<OADRadioGroup> {
  String? _groupValue;
  @override
  void initState() {
    if (widget.selectedValue.isNotEmpty) {
      final index = widget.values.indexOf(widget.selectedValue);
      if (index >= 0) {
        _groupValue = widget.values[index];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.values
          .asMap()
          .entries
          .map(
            (entry) => ListTile(
                title: Text(entry.value),
                leading: Radio(
                  value: entry.value,
                  groupValue: _groupValue,
                  onChanged: (val) {
                    setState(() {
                      _groupValue = entry.value;
                      if (widget.onChanged != null)
                        widget.onChanged!(entry.key, entry.value);
                    });
                  },
                )),
          )
          .toList(),
    );
  }
}

class OADRadioGroupFormField extends FormField<String> {
  OADRadioGroupFormField({
    FormFieldSetter<String>? onSaved,
    required List<String> values,
    final String? initialValue,
  }) : super(
          onSaved: onSaved,
          builder: (state) => OADRadioGroup(
            values: values,
            onChanged: (index, value) => state.didChange(value),
            selectedValue: state.value ?? '',
          ),
          initialValue: initialValue ?? (values.length > 0 ? values[0] : null),
        );
}
