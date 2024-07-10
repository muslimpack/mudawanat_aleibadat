// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'deeds_statistics_cubit.dart';

sealed class DeedsStatisticsState extends Equatable {
  const DeedsStatisticsState();

  @override
  List<Object> get props => [];
}

final class DeedsStatisticsLoading extends DeedsStatisticsState {}

final class DeedsStatisticsLoaded extends DeedsStatisticsState {
  final int totalDays;
  final TimeRange timeRange;
  final List<PlotCardItem> additionalSeparatedSpots;
  final List<PlotCardItem> obligatorySeparatedSpots;
  final List<FlSpot> obligatorySpots;
  final List<FlSpot> additionalSpots;
  final List<FlSpot> quranSpots;
  final List<FlSpot> azkarSpots;
  const DeedsStatisticsLoaded({
    required this.totalDays,
    required this.additionalSeparatedSpots,
    required this.obligatorySeparatedSpots,
    required this.obligatorySpots,
    required this.additionalSpots,
    required this.quranSpots,
    required this.azkarSpots,
    required this.timeRange,
  });

  @override
  List<Object> get props {
    return [
      totalDays,
      additionalSeparatedSpots,
      obligatorySeparatedSpots,
      obligatorySpots,
      additionalSpots,
      quranSpots,
      azkarSpots,
      timeRange,
    ];
  }

  DeedsStatisticsLoaded copyWith({
    int? totalDays,
    TimeRange? timeRange,
    List<PlotCardItem>? additionalSeparatedSpots,
    List<PlotCardItem>? obligatorySeparatedSpots,
    List<FlSpot>? obligatorySpots,
    List<FlSpot>? additionalSpots,
    List<FlSpot>? quranSpots,
    List<FlSpot>? azkarSpots,
  }) {
    return DeedsStatisticsLoaded(
      totalDays: totalDays ?? this.totalDays,
      timeRange: timeRange ?? this.timeRange,
      additionalSeparatedSpots:
          additionalSeparatedSpots ?? this.additionalSeparatedSpots,
      obligatorySeparatedSpots:
          obligatorySeparatedSpots ?? this.obligatorySeparatedSpots,
      obligatorySpots: obligatorySpots ?? this.obligatorySpots,
      additionalSpots: additionalSpots ?? this.additionalSpots,
      quranSpots: quranSpots ?? this.quranSpots,
      azkarSpots: azkarSpots ?? this.azkarSpots,
    );
  }
}
