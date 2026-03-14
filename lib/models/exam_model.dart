import 'package:flutter/material.dart';

/// Represents a competitive exam (UPSC, CDS, NDA, etc.).
///
/// [icon] and [color] are runtime-only — not serialised.
/// When migrating to Supabase, map [colorValue] → [color] in [fromJson].
class ExamModel {
  final String id;
  final String name;
  final String shortName;
  final String description;
  final String conductedBy;
  final IconData icon;
  final Color color;
  final int totalPapers;

  const ExamModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.conductedBy,
    required this.icon,
    required this.color,
    required this.totalPapers,
  });

  /// Supabase-ready factory — icon is resolved externally (e.g. via id map).
  factory ExamModel.fromJson(
    Map<String, dynamic> json, {
    required IconData icon,
  }) {
    return ExamModel(
      id:           json['id'] as String,
      name:         json['name'] as String,
      shortName:    json['short_name'] as String,
      description:  json['description'] as String,
      conductedBy:  json['conducted_by'] as String,
      icon:         icon,
      color:        Color(json['color_value'] as int),
      totalPapers:  json['total_papers'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id':           id,
        'name':         name,
        'short_name':   shortName,
        'description':  description,
        'conducted_by': conductedBy,
        'color_value':  color.toARGB32(),
        'total_papers': totalPapers,
      };

  @override
  String toString() => 'ExamModel(id: $id, name: $name)';
}
