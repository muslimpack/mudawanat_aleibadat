// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/features/ui/presentation/components/windows_app_bar.dart';

class DesktopWindowWrapper extends StatelessWidget {
  final Widget? child;
  const DesktopWindowWrapper({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Column(
          children: [
            const UIAppBar(),
            Expanded(
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: child ?? const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
