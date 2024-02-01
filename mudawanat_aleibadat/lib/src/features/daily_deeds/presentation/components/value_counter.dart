import 'package:flutter/material.dart';

class ValueCounter extends StatefulWidget {
  final double value;
  final bool allowReset;
  final double increaseBy;

  final ValueChanged<double>? onChanged;
  const ValueCounter({
    super.key,
    required this.value,
    this.increaseBy = 1,
    this.onChanged,
    this.allowReset = false,
  });

  @override
  State<ValueCounter> createState() => _ValueCounterState();
}

class _ValueCounterState extends State<ValueCounter> {
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  void didChangeDependencies() {
    setState(() {
      value = widget.value;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              value += widget.increaseBy;
              widget.onChanged?.call(value);
            });
          },
          icon: const Icon(Icons.add),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "$value",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              value -= widget.increaseBy;
              widget.onChanged?.call(value);
            });
          },
          icon: const Icon(Icons.exposure_minus_1_outlined),
        ),
        if (widget.allowReset)
          IconButton(
            onPressed: () {
              setState(() {
                value = 0;
                widget.onChanged?.call(value);
              });
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
      ],
    );
  }
}
