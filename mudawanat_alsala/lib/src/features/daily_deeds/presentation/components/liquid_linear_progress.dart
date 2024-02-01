// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class CircularLiquidProgress extends StatelessWidget {
  final double value;
  final String? child;
  const CircularLiquidProgress({
    super.key,
    required this.value,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: LiquidCircularProgressIndicator(
          value: value,
          borderWidth: 2,
          borderColor: Theme.of(context).primaryColor,
          center: Text(
            child ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              // color: Colors.amber,
            ),
          ),
        ),
      ),
    );
  }
}
