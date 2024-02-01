class StatsElement {
  final String label;
  final int times;
  final int? count;
  final double percentage;

  StatsElement({
    required this.label,
    required this.times,
    required this.percentage,
    this.count,
  });
}
