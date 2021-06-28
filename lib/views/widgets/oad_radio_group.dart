import 'package:flutter/material.dart';

class RadioGroup extends StatefulWidget {
  const RadioGroup({
    Key? key,
    required this.values,
    this.selectedIndex = 0,
    this.onChanged,
  }) : super(key: key);
  final List<String> values;
  final int selectedIndex;
  final Function(int index, String value)? onChanged;

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  String? _groupValue;
  @override
  void initState() {
    _groupValue = widget.values[widget.selectedIndex];
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
