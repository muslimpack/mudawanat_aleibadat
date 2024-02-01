part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final Color color;
  final Brightness brightness;
  final bool useMaterial3;
  final bool useOldTheme;
  final Locale? locale;
  const ThemeState({
    required this.color,
    required this.brightness,
    required this.useMaterial3,
    required this.useOldTheme,
    this.locale,
  });

  @override
  List<Object?> get props {
    return [
      color,
      brightness,
      useMaterial3,
      useOldTheme,
      locale,
    ];
  }

  ThemeState copyWith({
    Color? color,
    Brightness? brightness,
    bool? useMaterial3,
    bool? useOldTheme,
    Locale? locale,
  }) {
    return ThemeState(
      color: color ?? this.color,
      brightness: brightness ?? this.brightness,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      useOldTheme: useOldTheme ?? this.useOldTheme,
      locale: locale ?? this.locale,
    );
  }
}
