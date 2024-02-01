import 'package:flutter/material.dart';

class ValueSelector extends StatefulWidget {
  final double value;
  final List<double> numbers;
  final ValueChanged<double>? onChanged;
  const ValueSelector({
    super.key,
    required this.value,
    required this.numbers,
    this.onChanged,
  });

  @override
  State<ValueSelector> createState() => _ValueSelectorState();
}

class _ValueSelectorState extends State<ValueSelector> {
  late double selectedCount;
  @override
  void initState() {
    selectedCount = widget.value;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      selectedCount = widget.value;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.numbers
          .map(
            (e) => ChoiceChip(
              label: Text(e.toString()),
              selected: e == selectedCount,
              onSelected: (value) {
                setState(() {
                  selectedCount = e;
                  widget.onChanged?.call(selectedCount);
                });
              },
            ),
          )
          .toList(),
    );
  }
}
