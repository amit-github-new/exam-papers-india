import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/exam_model.dart';
import '../models/paper_model.dart';
import '../models/year_model.dart';

/// Static mock dataset — replace data sources with Supabase queries when ready.
///
/// All public methods mirror the signatures used in the repository interfaces
/// so the swap is purely in the repository layer.
class MockDataService {
  MockDataService._();

  // ── Exams ─────────────────────────────────────────────────────────────────

  static List<ExamModel> get exams => const [
        ExamModel(
          id: 'upsc',
          name: 'UPSC Civil Services',
          shortName: 'UPSC',
          description: 'Union Public Service Commission Civil Services Exam',
          conductedBy: 'UPSC',
          icon: Icons.account_balance_rounded,
          color: Color(0xFF2563EB),
          totalPapers: 120,
        ),
        ExamModel(
          id: 'cds',
          name: 'CDS',
          shortName: 'CDS',
          description: 'Combined Defence Services Examination',
          conductedBy: 'UPSC',
          icon: Icons.military_tech_rounded,
          color: Color(0xFF7C3AED),
          totalPapers: 48,
        ),
        ExamModel(
          id: 'geo_scientist',
          name: 'Geo Scientist',
          shortName: 'Geo Sci',
          description: 'Combined Geo-Scientist Examination',
          conductedBy: 'UPSC',
          icon: Icons.terrain_rounded,
          color: Color(0xFF059669),
          totalPapers: 36,
        ),
        ExamModel(
          id: 'capf',
          name: 'CAPF',
          shortName: 'CAPF',
          description: 'Central Armed Police Forces Examination',
          conductedBy: 'UPSC',
          icon: Icons.shield_rounded,
          color: Color(0xFFDC2626),
          totalPapers: 24,
        ),
        ExamModel(
          id: 'nda',
          name: 'NDA',
          shortName: 'NDA',
          description: 'National Defence Academy Examination',
          conductedBy: 'UPSC',
          icon: Icons.star_rounded,
          color: Color(0xFFD97706),
          totalPapers: 60,
        ),
        ExamModel(
          id: 'engineering_services',
          name: 'Engineering Services',
          shortName: 'ESE',
          description: 'Engineering Services Examination',
          conductedBy: 'UPSC',
          icon: Icons.engineering_rounded,
          color: Color(0xFF0891B2),
          totalPapers: 48,
        ),
      ];

  // ── Years ─────────────────────────────────────────────────────────────────

  static List<YearModel> getYears(String examId) {
    final current = DateTime.now().year;
    return List.generate(
      current - 2009,
      (i) {
        final year = current - i;
        return YearModel(
          year:       year,
          examId:     examId,
          paperCount: _paperCountFor(examId),
          isLatest:   i == 0,
        );
      },
    );
  }

  static int _paperCountFor(String examId) {
    const map = {
      'upsc':                 8,
      'cds':                  4,
      'geo_scientist':        3,
      'capf':                 2,
      'nda':                  4,
      'engineering_services': 4,
    };
    return map[examId] ?? 2;
  }

  // ── Categories ────────────────────────────────────────────────────────────

  static List<CategoryModel> getCategories(String examId) {
    switch (examId) {
      case 'upsc':
        return const [
          CategoryModel(
            id: 'upsc_prelims_gs1',
            name: 'Prelims — GS Paper I',
            examId: 'upsc',
            icon: Icons.assignment_rounded,
            description: 'History, Geography, Polity, Economy & Environment',
            paperCount: 15,
          ),
          CategoryModel(
            id: 'upsc_prelims_csat',
            name: 'Prelims — CSAT',
            examId: 'upsc',
            icon: Icons.calculate_rounded,
            description: 'Civil Services Aptitude Test (Paper II)',
            paperCount: 15,
          ),
          CategoryModel(
            id: 'upsc_mains_gs1',
            name: 'Mains — GS Paper I',
            examId: 'upsc',
            icon: Icons.history_edu_rounded,
            description: 'Indian Heritage, History & Geography',
            paperCount: 10,
          ),
          CategoryModel(
            id: 'upsc_mains_gs2',
            name: 'Mains — GS Paper II',
            examId: 'upsc',
            icon: Icons.policy_rounded,
            description: 'Governance, Constitution & International Relations',
            paperCount: 10,
          ),
          CategoryModel(
            id: 'upsc_mains_gs3',
            name: 'Mains — GS Paper III',
            examId: 'upsc',
            icon: Icons.eco_rounded,
            description: 'Economy, Environment, Technology & Disaster',
            paperCount: 10,
          ),
          CategoryModel(
            id: 'upsc_mains_gs4',
            name: 'Mains — GS Paper IV',
            examId: 'upsc',
            icon: Icons.balance_rounded,
            description: 'Ethics, Integrity & Aptitude',
            paperCount: 10,
          ),
          CategoryModel(
            id: 'upsc_mains_essay',
            name: 'Mains — Essay',
            examId: 'upsc',
            icon: Icons.edit_note_rounded,
            description: 'Essay Paper (250 marks)',
            paperCount: 10,
          ),
        ];

      case 'cds':
        return const [
          CategoryModel(
            id: 'cds_english',
            name: 'English',
            examId: 'cds',
            icon: Icons.translate_rounded,
            description: 'English Language comprehension & grammar',
            paperCount: 8,
          ),
          CategoryModel(
            id: 'cds_maths',
            name: 'Mathematics',
            examId: 'cds',
            icon: Icons.functions_rounded,
            description: 'Arithmetic, Algebra, Trigonometry & Geometry',
            paperCount: 8,
          ),
          CategoryModel(
            id: 'cds_gk',
            name: 'General Knowledge',
            examId: 'cds',
            icon: Icons.public_rounded,
            description: 'Current Affairs, History, Science & Geography',
            paperCount: 8,
          ),
        ];

      case 'geo_scientist':
        return const [
          CategoryModel(
            id: 'geo_paper1',
            name: 'Geology — Paper I',
            examId: 'geo_scientist',
            icon: Icons.landscape_rounded,
            description: 'General Geology & Geophysics',
            paperCount: 5,
          ),
          CategoryModel(
            id: 'geo_paper2',
            name: 'Geology — Paper II',
            examId: 'geo_scientist',
            icon: Icons.water_rounded,
            description: 'Geomorphology & Remote Sensing',
            paperCount: 5,
          ),
          CategoryModel(
            id: 'geo_paper3',
            name: 'Geology — Paper III',
            examId: 'geo_scientist',
            icon: Icons.science_rounded,
            description: 'Economic Geology & Mineral Resources',
            paperCount: 5,
          ),
        ];

      case 'capf':
        return const [
          CategoryModel(
            id: 'capf_paper1',
            name: 'Paper I — General Ability',
            examId: 'capf',
            icon: Icons.menu_book_rounded,
            description: 'General Studies, Reasoning & Awareness',
            paperCount: 5,
          ),
          CategoryModel(
            id: 'capf_paper2',
            name: 'Paper II — GS & Essay',
            examId: 'capf',
            icon: Icons.edit_rounded,
            description: 'General Studies, Essay & Comprehension',
            paperCount: 5,
          ),
        ];

      case 'nda':
        return const [
          CategoryModel(
            id: 'nda_maths',
            name: 'Mathematics',
            examId: 'nda',
            icon: Icons.calculate_rounded,
            description: 'Algebra, Matrices, Calculus, Statistics',
            paperCount: 10,
          ),
          CategoryModel(
            id: 'nda_gat',
            name: 'General Ability Test',
            examId: 'nda',
            icon: Icons.quiz_rounded,
            description: 'English & General Knowledge',
            paperCount: 10,
          ),
        ];

      case 'engineering_services':
        return const [
          CategoryModel(
            id: 'ese_prelims_gst',
            name: 'Prelims — GST',
            examId: 'engineering_services',
            icon: Icons.settings_rounded,
            description: 'General Studies & Engineering Aptitude',
            paperCount: 5,
          ),
          CategoryModel(
            id: 'ese_civil',
            name: 'Civil Engineering',
            examId: 'engineering_services',
            icon: Icons.apartment_rounded,
            description: 'Structural, Geotechnical & Environmental Engg.',
            paperCount: 5,
          ),
          CategoryModel(
            id: 'ese_mechanical',
            name: 'Mechanical Engineering',
            examId: 'engineering_services',
            icon: Icons.precision_manufacturing_rounded,
            description: 'Thermodynamics, Manufacturing & Design',
            paperCount: 5,
          ),
          CategoryModel(
            id: 'ese_electrical',
            name: 'Electrical Engineering',
            examId: 'engineering_services',
            icon: Icons.bolt_rounded,
            description: 'Power Systems, Machines & Control',
            paperCount: 5,
          ),
          CategoryModel(
            id: 'ese_electronics',
            name: 'Electronics & Telecom',
            examId: 'engineering_services',
            icon: Icons.developer_board_rounded,
            description: 'Analog, Digital, Signals & Communications',
            paperCount: 5,
          ),
        ];

      default:
        return [];
    }
  }

  // ── Papers ────────────────────────────────────────────────────────────────

  static List<PaperModel> getPapers({
    required String examId,
    required int year,
    required String categoryId,
  }) {
    final sets = ['Set A', 'Set B', 'Set C'];
    return List.generate(sets.length, (i) {
      final setLabel = sets[i];
      return PaperModel(
        id:              '${examId}_${year}_${categoryId}_${i + 1}',
        title:           '$year Question Paper — $setLabel',
        examId:          examId,
        year:            year,
        categoryId:      categoryId,
        categoryName:    _categoryName(examId, categoryId),
        pdfUrl:
            'https://mock.exampapers.in/$examId/$year/$categoryId/paper_${i + 1}.pdf',
        downloadUrl:
            'https://mock.exampapers.in/download/$examId/$year/$categoryId/paper_${i + 1}.pdf',
        fileSizeMb:      2.4 + i * 0.6,
        language:        'English',
        totalQuestions:  100 + i * 20,
        totalMarks:      200 + i * 50,
        durationMinutes: 120,
      );
    });
  }

  static String _categoryName(String examId, String categoryId) {
    return getCategories(examId)
        .firstWhere(
          (c) => c.id == categoryId,
          orElse: () => const CategoryModel(
            id: '', name: 'Unknown', examId: '',
            icon: Icons.help_outline, description: '', paperCount: 0,
          ),
        )
        .name;
  }
}
