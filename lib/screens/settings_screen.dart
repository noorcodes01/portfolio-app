


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../providers/projects_provider.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
//import '../services/auth_service.dart';
import 'about_screen.dart';
import 'edit_profile_screen.dart';
import 'edit_skills_screen.dart';
import 'edit_experience_screen.dart';
import 'manage_projects_screen.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _sessionInfo = 'Loading...';



  Future<void> _logout() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = AppTheme.cardColor(isDark);
    final textColor = AppTheme.textColor(isDark);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: Text('Sign Out?',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: textColor)),
        content: Text(
            'You will need to sign in again to access your portfolio.',
            style: GoogleFonts.poppins(
                color: AppTheme.textMuted, fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: AppTheme.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Sign Out',
                style: GoogleFonts.poppins(
                    color: AppTheme.error, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final auth = Provider.of<AuthService>(context, listen: false);

      // Clear cached data
      await Provider.of<ProfileProvider>(context, listen: false).clearCache();
      await Provider.of<ProjectsProvider>(context, listen: false).clearCache();

      await auth.signOut();

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 400),
          ),
              (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);
    final cardColor = AppTheme.cardColor(isDark);
    final dividerColor = AppTheme.dividerColor(isDark);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: AppTheme.bgColor(isDark),
      appBar: AppBar(
        backgroundColor: AppTheme.bgColor(isDark),
        title: Text('Settings',
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
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: AppTheme.accent),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            Consumer2<ProfileProvider, AuthService>(
              builder: (context, profile, auth, _) => Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.accent.withOpacity(0.2),
                      AppTheme.accentSecondary.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppTheme.accent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          AppTheme.accent,
                          AppTheme.accentSecondary
                        ]),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: profile.profileImagePath.isNotEmpty
                            ? Image.file(
                          File(profile.profileImagePath),
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person_rounded,
                              color: Colors.white, size: 28),
                        )
                            : Image.asset(
                          'assets/icon/profile_icon.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person_rounded,
                              color: Colors.white, size: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name, // ← live from provider
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: textColor),
                          ),
                          Text(
                            profile.email, // ← live from provider
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppTheme.textMuted),
                          ),
                          Text(
                            'Portfolio App',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppTheme.accentSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── Profile ──
            _SectionLabel(label: 'Profile'),
            const SizedBox(height: 10),
            _SettingsGroup(
              isDark: isDark,
              cardColor: cardColor,
              dividerColor: dividerColor,
              items: [
                _SettingsItem(
                  icon: Icons.person_outline_rounded,
                  iconBg: AppTheme.accent,
                  title: 'Edit Profile',
                  subtitle: 'Update personal & contact info',
                  onTap: () => Navigator.push(context,
                      _slide(const EditProfileScreen())),
                  textColor: textColor,
                ),
                _SettingsItem(
                  icon: Icons.code_rounded,
                  iconBg: AppTheme.accentSecondary,
                  title: 'Edit Skills',
                  subtitle: 'Add, edit or remove skills',
                  onTap: () => Navigator.push(context,
                      _slide(const EditSkillsScreen())),
                  textColor: textColor,
                  showDivider: true,
                ),
                _SettingsItem(
                  icon: Icons.business_center_rounded,
                  iconBg: const Color(0xFFFF9500),
                  title: 'Edit Experience',
                  subtitle: 'Add, edit or remove experience',
                  onTap: () => Navigator.push(context,
                      _slide(const EditExperienceScreen())),
                  textColor: textColor,
                  showDivider: true,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Projects ──
            _SectionLabel(label: 'Projects'),
            const SizedBox(height: 10),
            _SettingsGroup(
              isDark: isDark,
              cardColor: cardColor,
              dividerColor: dividerColor,
              items: [
                _SettingsItem(
                  icon: Icons.folder_outlined,
                  iconBg: const Color(0xFF6C63FF),
                  title: 'Manage Projects',
                  subtitle: 'Add, edit or delete projects',
                  onTap: () => Navigator.push(context,
                      _slide(const ManageProjectsScreen())),
                  textColor: textColor,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Appearance ──
            _SectionLabel(label: 'Appearance'),
            const SizedBox(height: 10),
            _SettingsGroup(
              isDark: isDark,
              cardColor: cardColor,
              dividerColor: dividerColor,
              items: [
                _SettingsItem(
                  icon: isDark
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  iconBg: isDark
                      ? const Color(0xFFFF9500)
                      : const Color(0xFF3B4CCA),
                  title: isDark ? 'Light Mode' : 'Dark Mode',
                  subtitle: isDark
                      ? 'Switch to light theme'
                      : 'Switch to dark theme',
                  onTap: () => themeProvider.toggleTheme(),
                  textColor: textColor,
                  trailing: Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      value: isDark,
                      onChanged: (_) => themeProvider.toggleTheme(),
                      activeColor: AppTheme.accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // // ── About ──
            // _SectionLabel(label: 'About App'),
            // const SizedBox(height: 10),
            // _SettingsGroup(
            //   isDark: isDark,
            //   cardColor: cardColor,
            //   dividerColor: dividerColor,
            //   items: [
            //     _SettingsItem(
            //       icon: Icons.info_outline_rounded,
            //       iconBg: AppTheme.accent,
            //       title: 'App Version',
            //       subtitle: 'v3.0.0 — Portfolio App',
            //       onTap: () {},
            //       textColor: textColor,
            //       showArrow: false,
            //     ),
            //
            //     _SettingsItem(
            //       icon: Icons.person_pin_outlined,
            //       iconBg: const Color(0xFFFF6B9D),
            //       title: 'Developed by',
            //       subtitle: 'Kainat Noor — Flutter Developer',
            //       onTap: () {},
            //       textColor: textColor,
            //       showDivider: true,
            //       showArrow: false,
            //     ),
            //
            //   ],
            // ),

            _SectionLabel(label: 'About App'),
            const SizedBox(height: 10),
            _SettingsGroup(
              isDark: isDark,
              cardColor: cardColor,
              dividerColor: dividerColor,
              items: [
                _SettingsItem(
                  icon: Icons.info_outline_rounded,
                  iconBg: AppTheme.accent,
                  title: 'About App',
                  subtitle: 'Features, technologies & licenses',
                  onTap: () => Navigator.push(context,
                      _slide(const AboutScreen())),
                  textColor: textColor,
                ),
                // _SettingsItem(
                //   icon: Icons.person_pin_outlined,
                //   iconBg: const Color(0xFFFF6B9D),
                //   title: 'Developer',
                //   subtitle: 'Kainat Noor — Flutter Developer',
                //   onTap: () => Navigator.push(context,
                //       _slide(const AboutScreen())),
                //   textColor: textColor,
                //   showDivider: true,
                // ),
                _SettingsItem(
                  icon: Icons.article_outlined,
                  iconBg: AppTheme.accentSecondary,
                  title: 'App Version',
                  subtitle: 'v3.0.0',
                  onTap: () {},
                  textColor: textColor,
                  showDivider: true,
                  showArrow: false,
                ),
              ],
            ),




            const SizedBox(height: 28),

            // ── Logout Button ──
            GestureDetector(
              onTap: _logout,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppTheme.error.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: AppTheme.error.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout_rounded,
                        color: AppTheme.error, size: 20),
                    const SizedBox(width: 8),
                    Text('Sign Out',
                        style: GoogleFonts.poppins(
                            color: AppTheme.error,
                            fontWeight: FontWeight.w600,
                            fontSize: 15)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  PageRoute _slide(Widget screen) => PageRouteBuilder(
    pageBuilder: (_, __, ___) => screen,
    transitionsBuilder: (_, animation, __, child) =>
        SlideTransition(
          position: Tween<Offset>(
              begin: const Offset(1, 0), end: Offset.zero)
              .animate(CurvedAnimation(
              parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
    transitionDuration: const Duration(milliseconds: 300),
  );
}

// ── Section Label ──
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppTheme.textMuted,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ── Settings Group ──
class _SettingsGroup extends StatelessWidget {
  final bool isDark;
  final Color cardColor, dividerColor;
  final List<_SettingsItem> items;

  const _SettingsGroup({
    required this.isDark,
    required this.cardColor,
    required this.dividerColor,
    required this.items,
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
        children: items.asMap().entries.map((entry) {
          return entry.value._build(context,
              dividerColor: dividerColor);
        }).toList(),
      ),
    );
  }
}

// ── Settings Item ──
class _SettingsItem {
  final IconData icon;
  final Color iconBg, textColor;
  final String title, subtitle;
  final VoidCallback onTap;
  final bool showDivider, showArrow;
  final Widget? trailing;

  const _SettingsItem({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.textColor,
    this.showDivider = false,
    this.showArrow = true,
    this.trailing,
  });

  Widget _build(BuildContext context,
      {required Color dividerColor}) {
    return Column(
      children: [
        if (showDivider)
          Divider(height: 1, color: dividerColor, indent: 68),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon,
                      color: Colors.white, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: textColor)),
                      Text(subtitle,
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppTheme.textMuted)),
                    ],
                  ),
                ),
                if (trailing != null)
                  trailing!
                else if (showArrow)
                  const Icon(Icons.chevron_right_rounded,
                      color: AppTheme.textMuted, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}