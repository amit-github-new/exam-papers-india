import 'package:flutter/material.dart';

/// Represents a paper category within an exam (e.g. Prelims GS1, CDS Maths).
///
/// [icon] is runtime-only and resolved from a local map.
class CategoryModel {
  final String id;
  final String name;
  final String examId;
  final IconData icon;
  final String description;
  final int paperCount;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.examId,
    required this.icon,
    required this.description,
    required this.paperCount,
  });

  /// Supabase-ready factory.
  factory CategoryModel.fromJson(
    Map<String, dynamic> json, {
    required IconData icon,
  }) {
    return CategoryModel(
      id:          json['id'] as String,
      name:        json['name'] as String,
      examId:      json['exam_id'] as String,
      icon:        icon,
      description: json['description'] as String,
      paperCount:  json['paper_count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id':          id,
        'name':        name,
        'exam_id':     examId,
        'description': description,
        'paper_count': paperCount,
      };

  @override
  String toString() => 'CategoryModel(id: $id, name: $name)';
}
