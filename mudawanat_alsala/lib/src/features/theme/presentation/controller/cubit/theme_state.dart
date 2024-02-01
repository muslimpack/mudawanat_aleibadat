part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final Color color;
  final Brightness brightness;
  final bool useMaterial3;
  final Locale? locale;
  const ThemeState({
    required this.color,
    required this.brightness,
    required this.useMaterial3,
    this.locale,
  });

  @override
  List<Object?> get props => [color, brightness, useMaterial3, locale];

  ThemeState copyWith({
    Color? color,
    Brightness? brightness,
    bool? useMaterial3,
    Locale? locale,
  }) {
    return ThemeState(
      color: color ?? this.color,
      brightness: brightness ?? this.brightness,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      locale: locale ?? this.locale,
    );
  }
}
