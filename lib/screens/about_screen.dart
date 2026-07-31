import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);
    final cardColor = AppTheme.cardColor(isDark);
    final dividerColor = AppTheme.dividerColor(isDark);

    return Scaffold(
      backgroundColor: AppTheme.bgColor(isDark),
      appBar: AppBar(
        backgroundColor: AppTheme.bgColor(isDark),
        title: Text('About App',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: textColor)),
        centerTitle: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.accent.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppTheme.accent),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── App Header ──
            Center(
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        AppTheme.accent,
                        AppTheme.accentSecondary,
                      ]),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accent.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset(
                        'assets/icon/profile_icon.png',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 46),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Portfolio App',
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  const SizedBox(height: 4),
                  Text('Version 3.0.0',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppTheme.textMuted)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Built with Flutter & Firebase',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppTheme.accent,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ── Features ──
            _SectionTitle(title: 'Features', isDark: isDark),
            const SizedBox(height: 12),
            _InfoCard(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _FeatureRow(
                    icon: '',
                    title: 'Authentication',
                    subtitle:
                    'Secure sign up & sign in with Firebase'),
                _FeatureRow(
                    icon: '',
                    title: 'Profile Management',
                    subtitle: 'Edit personal info, bio & photo'),
                _FeatureRow(
                    icon: '',
                    title: 'Skills Tracking',
                    subtitle:
                    'Add skills with animated progress bars'),
                _FeatureRow(
                    icon: '',
                    title: 'Experience',
                    subtitle: 'Manage work & internship history'),
                _FeatureRow(
                    icon: '',
                    title: 'Projects',
                    subtitle:
                    'Showcase projects with details & links'),
                _FeatureRow(
                    icon: '',
                    title: 'Dark & Light Mode',
                    subtitle:
                    'Theme preference saved automatically'),
                _FeatureRow(
                    icon: '',
                    title: 'Search & Filter',
                    subtitle: 'Find projects by name or category'),
                _FeatureRow(
                    icon: '',
                    title: 'Cloud Sync',
                    subtitle:
                    'Data synced across all your devices'),
                _FeatureRow(
                    icon: '',
                    title: 'Offline Support',
                    subtitle: 'Access data without internet'),
              ],
            ),
            const SizedBox(height: 28),

            // ── Technologies ──
            _SectionTitle(
                title: 'Technologies Used', isDark: isDark),
            const SizedBox(height: 12),
            _InfoCard(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _TechRow(
                    name: 'Flutter',
                    desc: 'Cross-platform mobile framework',
                    color: const Color(0xFF54C5F8)),
                _TechRow(
                    name: 'Firebase Auth',
                    desc: 'Secure user authentication',
                    color: const Color(0xFFFFCA28)),
                _TechRow(
                    name: 'Cloud Firestore',
                    desc: 'Real-time NoSQL database',
                    color: const Color(0xFFFF6D00)),
                _TechRow(
                    name: 'Provider',
                    desc: 'State management solution',
                    color: AppTheme.accent),
                _TechRow(
                    name: 'SharedPreferences',
                    desc: 'Local data caching',
                    color: AppTheme.accentSecondary),
                _TechRow(
                    name: 'Google Fonts',
                    desc: 'Poppins typography',
                    color: const Color(0xFF4285F4)),
              ],
            ),
            const SizedBox(height: 28),

            // ── Developer ──
            _SectionTitle(title: 'Developer', isDark: isDark),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: dividerColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppTheme.accent,
                            AppTheme.accentSecondary,
                          ]),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icon/profile_icon.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 28),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text('Kainat Noor',
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: textColor)),
                            Text(
                                'Flutter Developer | CS Student',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppTheme.textMuted)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),
                  _LinkButton(
                    icon: Icons.code_rounded,
                    color: const Color(0xFF6E5494),
                    label: 'GitHub — KainatNoor',
                    onTap: () => _launch(
                        'https://github.com/KainatNoor'),
                  ),
                  const SizedBox(height: 10),
                  _LinkButton(
                    icon: Icons.work_rounded,
                    color: const Color(0xFF0A66C2),
                    label: 'LinkedIn — kainat-noor',
                    onTap: () => _launch(
                        'https://linkedin.com/in/kainat-noor-02a5873b1'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ── Licenses ──
            _SectionTitle(title: 'Licenses', isDark: isDark),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: dividerColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This application uses the following open source packages:',
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                        height: 1.5),
                  ),
                  const SizedBox(height: 14),
                  ...[
                    'flutter — BSD 3-Clause License',
                    'firebase_core — Apache 2.0',
                    'firebase_auth — Apache 2.0',
                    'cloud_firestore — Apache 2.0',
                    'provider — MIT License',
                    'google_fonts — Apache 2.0',
                    'shared_preferences — BSD 3-Clause',
                    'url_launcher — BSD 3-Clause',
                    'image_picker — Apache 2.0',
                    'font_awesome_flutter — MIT License',
                  ].map((license) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppTheme.accent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(license,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppTheme.textSubColor(isDark))),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => showLicensePage(
                      context: context,
                      applicationName: 'Portfolio App',
                      applicationVersion: '3.0.0',
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color:
                            AppTheme.accent.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          const Icon(
                              Icons.article_outlined,
                              color: AppTheme.accent,
                              size: 16),
                          const SizedBox(width: 8),
                          Text('View All Open Source Licenses',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppTheme.accent,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ── Legal ──
            _SectionTitle(title: 'Legal', isDark: isDark),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: dividerColor),
              ),
              child: Text(
                'This application was developed for educational and '
                    'portfolio demonstration purposes. All data is stored '
                    'securely in Firebase Cloud Firestore. User credentials '
                    'are managed by Firebase Authentication.\n\n'
                    '© 2024 Kainat Noor. All rights reserved.\n\n'
                    'Built with using Flutter & Firebase.',
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppTheme.textMuted,
                    height: 1.7),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ── Helper Widgets ──

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SectionTitle({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppTheme.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(title,
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor(isDark))),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Color cardColor, dividerColor;
  final List<Widget> children;
  const _InfoCard({
    required this.cardColor,
    required this.dividerColor,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dividerColor),
      ),
      child: Column(
        children: children.asMap().entries.map((e) {
          final isLast = e.key == children.length - 1;
          return Column(
            children: [
              e.value,
              if (!isLast)
                Divider(height: 1, color: dividerColor, indent: 56),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String icon, title, subtitle;
  const _FeatureRow(
      {required this.icon,
        required this.title,
        required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor(isDark))),
                Text(subtitle,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppTheme.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TechRow extends StatelessWidget {
  final String name, desc;
  final Color color;
  const _TechRow(
      {required this.name,
        required this.desc,
        required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textColor(isDark))),
                Text(desc,
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppTheme.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  const _LinkButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border:
          Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: color,
                    fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(Icons.open_in_new_rounded,
                color: color, size: 16),
          ],
        ),
      ),
    );
  }
}