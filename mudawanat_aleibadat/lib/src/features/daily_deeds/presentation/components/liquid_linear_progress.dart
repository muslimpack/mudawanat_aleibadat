import 'package:flutter/material.dart';

class LinearLiquidProgress extends StatelessWidget {
  final double value;
  final String? child;
  const LinearLiquidProgress({
    super.key,
    required this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      minHeight: 10,
      value: value,
    );
  }
}
