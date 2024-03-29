import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mudawanat_aleibadat/src/core/repos/local_storage_repo.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeState(
            brightness: LocalStorageRepo.getBrightness(),
            color: LocalStorageRepo.getColor(),
            useMaterial3: LocalStorageRepo.getUseMaterial3(),
            useOldTheme: LocalStorageRepo.getUseOldTheme(),
            locale: LocalStorageRepo.getLocale(),
          ),
        );

  Future<void> changeBrightness(Brightness brightness) async {
    await LocalStorageRepo.setBrightness(brightness);
    emit(state.copyWith(brightness: brightness));
  }

  Future<void> changeUseMaterial3(bool useMaterial3) async {
    await LocalStorageRepo.setUseMaterial3(useMaterial3);
    emit(state.copyWith(useMaterial3: useMaterial3));
  }

  Future<void> changeUseOldTheme(bool useOldTheme) async {
    await LocalStorageRepo.setUseOldTheme(useOldTheme);
    emit(state.copyWith(useOldTheme: useOldTheme));
  }

  Future<void> changeColor(Color color) async {
    await LocalStorageRepo.setColor(color);
    emit(state.copyWith(color: color));
  }

  Future<void> changeLocale(Locale locale) async {
    await LocalStorageRepo.changeLocale(locale);
    emit(state.copyWith(locale: locale));
  }
}
