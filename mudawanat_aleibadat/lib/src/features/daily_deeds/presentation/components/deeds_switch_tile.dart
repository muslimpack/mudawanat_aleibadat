// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/core/utils/color_generator.dart';

class DeedsSwitchTile extends StatelessWidget {
  final bool value;
  final Widget? title;
  final ValueChanged<bool>? onChanged;
  final Widget? info;
  const DeedsSwitchTile({
    super.key,
    required this.value,
    this.title,
    this.onChanged,
    this.info,
  });
  String getKey() {
    if (title != null && title is Text) {
      final text = (title! as Text).data;
      final key = text ?? title.toString();

      return key + key;
    }
    return title.hashCode.toString();
  }

  @override
  Widget build(BuildContext context) {
    final color = ColorGenerator.highContrastByKey(
      key: getKey(),
    );
    return Card(
      clipBehavior: Clip.hardEdge,
      color: color.withAlpha((.1 * 255).toInt()),
      child: Column(
        children: [
          SwitchListTile(
            value: value,
            title: title,
            onChanged: onChanged,
          ),
          if (info != null) info!,
        ],
      ),
    );
  }
}
