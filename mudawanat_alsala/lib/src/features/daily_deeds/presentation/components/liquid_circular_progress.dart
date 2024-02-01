// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:mudawanat_alsala/src/core/extension/extension_color.dart';

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
    final valueColor = Theme.of(context).colorScheme.primary;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: LiquidCircularProgressIndicator(
          value: value,
          // valueColor: AlwaysStoppedAnimation(valueColor),
          borderWidth: 2,
          borderColor: Theme.of(context).primaryColor,
          backgroundColor: valueColor.withOpacity(.3),
          center: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                child ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: valueColor.getContrastColor,
                  // color: Colors.amber,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
