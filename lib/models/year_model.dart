/// Represents a single exam year entry in the year list.
class YearModel {
  final int year;
  final String examId;
  final int paperCount;
  final bool isLatest;

  const YearModel({
    required this.year,
    required this.examId,
    required this.paperCount,
    this.isLatest = false,
  });

  factory YearModel.fromJson(Map<String, dynamic> json) => YearModel(
        year:       json['year'] as int,
        examId:     json['exam_id'] as String,
        paperCount: json['paper_count'] as int,
        isLatest:   json['is_latest'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'year':        year,
        'exam_id':     examId,
        'paper_count': paperCount,
        'is_latest':   isLatest,
      };

  @override
  String toString() => 'YearModel(year: $year, examId: $examId)';
}
