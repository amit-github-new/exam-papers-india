/// Represents a single downloadable / viewable question paper.
class PaperModel {
  final String id;
  final String title;
  final String examId;
  final int year;
  final String categoryId;
  final String categoryName;
  final String? pdfUrl;
  final String? downloadUrl;
  final double? fileSizeMb;
  final String? language;
  final int? totalQuestions;
  final int? totalMarks;
  final int? durationMinutes;

  const PaperModel({
    required this.id,
    required this.title,
    required this.examId,
    required this.year,
    required this.categoryId,
    required this.categoryName,
    this.pdfUrl,
    this.downloadUrl,
    this.fileSizeMb,
    this.language,
    this.totalQuestions,
    this.totalMarks,
    this.durationMinutes,
  });

  factory PaperModel.fromJson(Map<String, dynamic> json) => PaperModel(
        id:              json['id'] as String,
        title:           json['title'] as String,
        examId:          json['exam_id'] as String,
        year:            json['year'] as int,
        categoryId:      json['category_id'] as String,
        categoryName:    json['category_name'] as String,
        pdfUrl:          json['pdf_url'] as String?,
        downloadUrl:     json['download_url'] as String?,
        fileSizeMb:      (json['file_size_mb'] as num?)?.toDouble(),
        language:        json['language'] as String?,
        totalQuestions:  json['total_questions'] as int?,
        totalMarks:      json['total_marks'] as int?,
        durationMinutes: json['duration_minutes'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id':               id,
        'title':            title,
        'exam_id':          examId,
        'year':             year,
        'category_id':      categoryId,
        'category_name':    categoryName,
        'pdf_url':          pdfUrl,
        'download_url':     downloadUrl,
        'file_size_mb':     fileSizeMb,
        'language':         language,
        'total_questions':  totalQuestions,
        'total_marks':      totalMarks,
        'duration_minutes': durationMinutes,
      };

  @override
  String toString() => 'PaperModel(id: $id, title: $title)';
}
