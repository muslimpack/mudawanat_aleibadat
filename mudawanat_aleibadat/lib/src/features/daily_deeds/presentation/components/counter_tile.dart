import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/core/utils/print.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/value_counter.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/value_selector.dart';

class CounterTile extends StatefulWidget {
  final Widget title;
  final double value;
  final double increaseBy;

  final ValueChanged<double>? onChanged;
  const CounterTile({
    super.key,
    required this.title,
    required this.value,
    this.increaseBy = 1,
    this.onChanged,
  });

  @override
  State<CounterTile> createState() => _CounterTileState();
}

class _CounterTileState extends State<CounterTile> {
  late double value;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.value;
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {
      value = widget.value;
    });
    super.didChangeDependencies();
  }

  void _onChanged(double value) {
    appPrint(value);
    setState(() {
      this.value = value;
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      subtitle: Column(
        children: [
          ValueCounter(
            value: value,
            onChanged: _onChanged,
          ),
          ValueSelector(
            value: value,
            numbers: const [2, 4, 5, 10, 15, 20, 22],
            onChanged: _onChanged,
          ),
        ],
      ),
    );
  }
}
