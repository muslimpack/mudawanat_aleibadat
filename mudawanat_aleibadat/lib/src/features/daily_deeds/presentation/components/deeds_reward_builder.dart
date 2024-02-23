// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DeedsRewardBuilder extends StatelessWidget {
  final List<String> rewards;
  const DeedsRewardBuilder({
    super.key,
    required this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: rewards.length,
      itemBuilder: (context, index) {
        return Text(
          rewards[index],
          textAlign: TextAlign.center,
          style: const TextStyle(
            height: 1.5,
            fontFamily: "Kitab",
            fontSize: 15,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
