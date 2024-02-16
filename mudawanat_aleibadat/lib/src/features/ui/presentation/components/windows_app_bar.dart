import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mudawanat_aleibadat/generated/l10n.dart';
import 'package:mudawanat_aleibadat/src/core/extension/extension_platform.dart';
import 'package:mudawanat_aleibadat/src/features/theme/presentation/controller/cubit/theme_cubit.dart';
import 'package:mudawanat_aleibadat/src/features/ui/presentation/components/windows_button.dart';
import 'package:window_manager/window_manager.dart';

class UIAppBar extends StatefulWidget {
  final BuildContext? shellContext;

  const UIAppBar({super.key, this.shellContext});

  @override
  State<UIAppBar> createState() => _UIAppBarState();
}

class _UIAppBarState extends State<UIAppBar> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (kIsWeb)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(S.of(context).appTitle),
              ),
            if (PlatformExtension.isDesktop)
              Expanded(
                child: DragToMoveArea(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(S.of(context).appTitle),
                  ),
                ),
              ),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: ChoiceChip(
                      selected: state.brightness == Brightness.dark,
                      showCheckmark: false,
                      label: const Icon(FontAwesomeIcons.solidMoon),
                      onSelected: (v) {
                        context.read<ThemeCubit>().changeBrightness(
                              v ? Brightness.dark : Brightness.light,
                            );
                      },
                    ),
                  ),
                );
              },
            ),
            if (!kIsWeb) const WindowButtons(),
          ],
        ),
      ),
    );
  }
}
