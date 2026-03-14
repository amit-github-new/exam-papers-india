import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 20),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
        children: [
          // ── Last updated ───────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Last updated: January 1, 2025',
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 24),

          const _Section(
            title: '1. Introduction',
            body:
                'Welcome to Exam Papers India ("we", "our", or "us"). We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, and safeguard information when you use our mobile application.',
          ),

          const _Section(
            title: '2. Information We Collect',
            body:
                'We may collect the following types of information:\n\n'
                '• Device information (model, OS version, unique device identifiers)\n'
                '• Usage data (which exams and papers you view)\n'
                '• Crash reports and performance data\n'
                '• Bookmarks and preferences stored locally on your device\n\n'
                'We do not collect or store any personally identifiable information such as your name, email address, or phone number unless you explicitly provide it.',
          ),

          const _Section(
            title: '3. How We Use Your Information',
            body:
                'The information we collect is used to:\n\n'
                '• Provide and maintain our app\n'
                '• Improve user experience and app performance\n'
                '• Analyse usage patterns to add new features\n'
                '• Fix bugs and technical issues\n'
                '• Ensure the security of our app',
          ),

          const _Section(
            title: '4. Data Storage',
            body:
                'Your bookmarks and app preferences are stored locally on your device and are not transmitted to our servers. Exam paper content is fetched from our secure cloud servers (Supabase) over encrypted HTTPS connections.',
          ),

          const _Section(
            title: '5. Third-Party Services',
            body:
                'Our app uses the following third-party services that may collect data:\n\n'
                '• Supabase (cloud database) — for storing and retrieving exam paper data\n'
                '• Google Fonts — for typography\n\n'
                'These services have their own privacy policies, and we encourage you to review them.',
          ),

          const _Section(
            title: '6. PDF Content',
            body:
                'All question papers available in this app are official documents published by the respective examination bodies (UPSC, CDAC, etc.) and are in the public domain. We do not claim ownership of any examination content.',
          ),

          const _Section(
            title: '7. Children\'s Privacy',
            body:
                'Our app is intended for students preparing for competitive examinations. We do not knowingly collect personal information from children under the age of 13. If you believe a child has provided us with personal information, please contact us immediately.',
          ),

          const _Section(
            title: '8. Security',
            body:
                'We implement commercially reasonable security measures to protect your information. All data transmissions between the app and our servers are encrypted using TLS/HTTPS. However, no method of transmission over the Internet is 100% secure.',
          ),

          const _Section(
            title: '9. Changes to This Policy',
            body:
                'We may update this Privacy Policy from time to time. We will notify you of any changes by updating the "Last updated" date at the top of this policy. Continued use of the app after changes constitutes acceptance of the updated policy.',
          ),

          const _Section(
            title: '10. Contact Us',
            body:
                'If you have questions or concerns about this Privacy Policy, please contact us at:\n\nexampapersindia@gmail.com\n\nExam Papers India\nIndia',
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String body;

  const _Section({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 1.65,
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant, height: 1),
        ],
      ),
    );
  }
}
