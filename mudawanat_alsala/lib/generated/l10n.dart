// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `App Color`
  String get appColor {
    return Intl.message(
      'App Color',
      name: 'appColor',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get appLanguage {
    return Intl.message(
      'App Language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `App Theme`
  String get appTheme {
    return Intl.message(
      'App Theme',
      name: 'appTheme',
      desc: '',
      args: [],
    );
  }

  /// `Mudawanat Alsala`
  String get appTitle {
    return Intl.message(
      'Mudawanat Alsala',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Calender`
  String get calender {
    return Intl.message(
      'Calender',
      name: 'calender',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Count`
  String get count {
    return Intl.message(
      'Count',
      name: 'count',
      desc: '',
      args: [],
    );
  }

  /// `Daily Deeds`
  String get dailyDeeds {
    return Intl.message(
      'Daily Deeds',
      name: 'dailyDeeds',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Fasting`
  String get fasting {
    return Intl.message(
      'Fasting',
      name: 'fasting',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Missed Deeds`
  String get missedDeeds {
    return Intl.message(
      'Missed Deeds',
      name: 'missedDeeds',
      desc: '',
      args: [],
    );
  }

  /// `Additional Prayers`
  String get prayer_additional {
    return Intl.message(
      'Additional Prayers',
      name: 'prayer_additional',
      desc: '',
      args: [],
    );
  }

  /// `Asr`
  String get prayer_asr {
    return Intl.message(
      'Asr',
      name: 'prayer_asr',
      desc: '',
      args: [],
    );
  }

  /// `Asr Pre`
  String get prayer_asr_pre {
    return Intl.message(
      'Asr Pre',
      name: 'prayer_asr_pre',
      desc: '',
      args: [],
    );
  }

  /// `Dhuhr`
  String get prayer_dhuhr {
    return Intl.message(
      'Dhuhr',
      name: 'prayer_dhuhr',
      desc: '',
      args: [],
    );
  }

  /// `Dhuhr After`
  String get prayer_dhuhr_after {
    return Intl.message(
      'Dhuhr After',
      name: 'prayer_dhuhr_after',
      desc: '',
      args: [],
    );
  }

  /// `Dhuhr Pre`
  String get prayer_dhuhr_pre {
    return Intl.message(
      'Dhuhr Pre',
      name: 'prayer_dhuhr_pre',
      desc: '',
      args: [],
    );
  }

  /// `Doha`
  String get prayer_doha {
    return Intl.message(
      'Doha',
      name: 'prayer_doha',
      desc: '',
      args: [],
    );
  }

  /// `Fajr`
  String get prayer_fajr {
    return Intl.message(
      'Fajr',
      name: 'prayer_fajr',
      desc: '',
      args: [],
    );
  }

  /// `Fajr Pre`
  String get prayer_fajr_pre {
    return Intl.message(
      'Fajr Pre',
      name: 'prayer_fajr_pre',
      desc: '',
      args: [],
    );
  }

  /// `Ishaa`
  String get prayer_ishaa {
    return Intl.message(
      'Ishaa',
      name: 'prayer_ishaa',
      desc: '',
      args: [],
    );
  }

  /// `Ishaa After`
  String get prayer_ishaa_after {
    return Intl.message(
      'Ishaa After',
      name: 'prayer_ishaa_after',
      desc: '',
      args: [],
    );
  }

  /// `Ishaa Pre`
  String get prayer_ishaa_pre {
    return Intl.message(
      'Ishaa Pre',
      name: 'prayer_ishaa_pre',
      desc: '',
      args: [],
    );
  }

  /// `Maghrib`
  String get prayer_maghrib {
    return Intl.message(
      'Maghrib',
      name: 'prayer_maghrib',
      desc: '',
      args: [],
    );
  }

  /// `Maghrib After`
  String get prayer_maghrib_after {
    return Intl.message(
      'Maghrib After',
      name: 'prayer_maghrib_after',
      desc: '',
      args: [],
    );
  }

  /// `Maghrib Pre`
  String get prayer_maghrib_pre {
    return Intl.message(
      'Maghrib Pre',
      name: 'prayer_maghrib_pre',
      desc: '',
      args: [],
    );
  }

  /// `Prayer Name`
  String get prayer_name {
    return Intl.message(
      'Prayer Name',
      name: 'prayer_name',
      desc: '',
      args: [],
    );
  }

  /// `Night Prayer`
  String get prayer_night_prayer {
    return Intl.message(
      'Night Prayer',
      name: 'prayer_night_prayer',
      desc: '',
      args: [],
    );
  }

  /// `Obligatory Prayers`
  String get prayer_obligatory {
    return Intl.message(
      'Obligatory Prayers',
      name: 'prayer_obligatory',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Select Color`
  String get selectColor {
    return Intl.message(
      'Select Color',
      name: 'selectColor',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `Done Times`
  String get timesDone {
    return Intl.message(
      'Done Times',
      name: 'timesDone',
      desc: '',
      args: [],
    );
  }

  /// `Times Missed`
  String get timesMissed {
    return Intl.message(
      'Times Missed',
      name: 'timesMissed',
      desc: '',
      args: [],
    );
  }

  /// `Use Material3`
  String get useMaterial3 {
    return Intl.message(
      'Use Material3',
      name: 'useMaterial3',
      desc: '',
      args: [],
    );
  }

  /// `Use Old Theme`
  String get useOldTheme {
    return Intl.message(
      'Use Old Theme',
      name: 'useOldTheme',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
