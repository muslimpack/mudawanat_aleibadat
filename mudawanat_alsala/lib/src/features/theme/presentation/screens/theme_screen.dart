import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mudawanat_alsala/generated/l10n.dart';
import 'package:mudawanat_alsala/src/features/theme/presentation/controller/cubit/theme_cubit.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).settings),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              ListTile(
                title: Text(S.of(context).appColor),
                trailing: CircleAvatar(
                  backgroundColor: state.color,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Color selectedColor = state.color;
                      return AlertDialog(
                        title: Text(S.of(context).selectColor),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            hexInputBar: true,
                            enableAlpha: false,
                            pickerColor: state.color,
                            onColorChanged: (value) {
                              selectedColor = value;
                            },
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text(S.of(context).select),
                            onPressed: () {
                              context
                                  .read<ThemeCubit>()
                                  .changeColor(selectedColor);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SwitchListTile(
                value: state.brightness == Brightness.dark,
                title: Text(S.of(context).darkMode),
                onChanged: (value) {
                  if (state.brightness == Brightness.dark) {
                    context
                        .read<ThemeCubit>()
                        .changeBrightness(Brightness.light);
                  } else {
                    context
                        .read<ThemeCubit>()
                        .changeBrightness(Brightness.dark);
                  }
                },
              ),
              SwitchListTile(
                value: state.useMaterial3,
                title: Text(S.of(context).useMaterial3),
                onChanged: (value) {
                  context.read<ThemeCubit>().changeUseMaterial3(value);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(S.of(context).appLanguage),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Wrap(
                    spacing: 8.0, // Spacing between chips
                    runSpacing: 4.0, // Spacing between rows of chips
                    children: S.delegate.supportedLocales
                        .map(
                          (locale) => ChoiceChip(
                            selected: state.locale?.languageCode ==
                                locale.languageCode,
                            label: Text(locale.languageCode),
                            onSelected: (value) {
                              context.read<ThemeCubit>().changeLocale(locale);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
