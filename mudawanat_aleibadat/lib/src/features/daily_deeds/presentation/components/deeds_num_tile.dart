import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/value_counter.dart';
import 'package:mudawanat_aleibadat/src/features/daily_deeds/presentation/components/value_selector.dart';

class DeedsNumTile extends StatefulWidget {
  final Widget title;
  final Widget? info;
  final int value;
  final bool showCounter;
  final List<double>? numbers;
  final ValueChanged<int>? onChanged;
  const DeedsNumTile({
    super.key,
    required this.value,
    this.numbers,
    this.onChanged,
    required this.title,
    this.info,
    this.showCounter = false,
  });

  @override
  State<DeedsNumTile> createState() => _DeedsNumTileState();
}

class _DeedsNumTileState extends State<DeedsNumTile> {
  late int value;
  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    value = widget.value;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant DeedsNumTile oldWidget) {
    value = widget.value;
    super.didUpdateWidget(oldWidget);
  }

  void _onChanged(double value) {
    setState(() {
      this.value = value.toInt();
      widget.onChanged?.call(value.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: widget.title,
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.showCounter)
                    ValueCounter(
                      min: 0,
                      value: value.toDouble(),
                      onChanged: _onChanged,
                    ),
                  if (widget.numbers != null)
                    ValueSelector(
                      value: value.toDouble(),
                      numbers: widget.numbers!,
                      onChanged: _onChanged,
                    ),
                ],
              ),
            ),
          ),
          if (widget.info != null) widget.info!,
        ],
      ),
    );
  }
}
