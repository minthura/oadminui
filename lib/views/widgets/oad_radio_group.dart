import 'package:flutter/material.dart';
import 'package:oadminui/constants.dart';

class RadioGroup extends StatefulWidget {
  const RadioGroup(
      {Key? key,
      required this.values,
      this.selectedIndex = 0,
      this.onChanged,
      required this.label})
      : super(key: key);
  final List<String> values;
  final String label;
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
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: kAccentColor.withAlpha(128))),
            child: Column(
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
            ),
          ),
        ),
        Positioned(
          left: 24,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              color: Colors.white,
              child: Text(
                widget.label,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )),
        ),
      ],
    );
  }
}
