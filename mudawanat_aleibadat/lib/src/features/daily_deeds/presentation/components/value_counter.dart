import 'package:flutter/material.dart';

class ValueCounter extends StatefulWidget {
  final double value;
  final double? min;
  final double? max;
  final bool allowReset;
  final double increaseBy;

  final ValueChanged<double>? onChanged;
  const ValueCounter({
    super.key,
    required this.value,
    this.increaseBy = 1,
    this.onChanged,
    this.allowReset = false,
    this.min,
    this.max,
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
    value = widget.value;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ValueCounter oldWidget) {
    value = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  void _onChanged(double value) {
    setState(() {
      this.value = value;
      if (widget.min != null && this.value < widget.min!) {
        this.value = widget.min!;
      }
      if (widget.max != null && this.value > widget.max!) {
        this.value = widget.max!;
      }
      widget.onChanged?.call(this.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            _onChanged(value + widget.increaseBy);
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
            _onChanged(value - widget.increaseBy);
          },
          icon: const Icon(Icons.exposure_minus_1_outlined),
        ),
        if (widget.allowReset)
          IconButton(
            onPressed: () {
              _onChanged(0);
            },
            icon: const Icon(Icons.refresh_outlined),
          ),
      ],
    );
  }
}
