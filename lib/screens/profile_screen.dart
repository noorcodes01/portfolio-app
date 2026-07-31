import 'package:portfolio_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
//import '../data/portfolio_data.dart';
import '../widgets/common_widgets.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  final double _expandedHeight = 220.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() => _scrollOffset = _scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double get _collapseProgress {
    final range = _expandedHeight - kToolbarHeight;
    return (_scrollOffset / range).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {

    final profile = Provider.of<ProfileProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);
    final textSub = AppTheme.textSubColor(isDark);
    final cardColor = AppTheme.cardColor(isDark);
    final dividerColor = AppTheme.dividerColor(isDark);

    final heroOpacity = (1.0 - _collapseProgress * 1.5).clamp(0.0, 1.0);
    final titleOpacity = ((_collapseProgress - 0.6) * 2.5).clamp(0.0, 1.0);
    final avatarScale = (1.0 - _collapseProgress * 0.4).clamp(0.6, 1.0);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: _expandedHeight,
            pinned: true,
            floating: false,
            snap: false,
            automaticallyImplyLeading: false,
            backgroundColor: isDark ? AppTheme.bgDark : AppTheme.lightBg,
            elevation: _collapseProgress * 4,
            shadowColor: Colors.black.withOpacity(0.5),
            // Collapsed compact title with theme toggle
            title: Opacity(
              opacity: titleOpacity,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FullImageScreen()),
                    ),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppTheme.accent, AppTheme.accentSecondary],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accent.withOpacity(0.4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/icon/profile_icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        profile.name,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      Text(
                        profile.title,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppTheme.accentSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            //     child: const ThemeToggleButton(),
            //   ),
            // ],

            actions: [
              // Padding(
              //   padding: const EdgeInsets.only(right: 2),
              //   child: IconButton(
              //     onPressed: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              //     ),
              //     icon: Container(
              //       width: 26,
              //       height: 26,
              //       decoration: BoxDecoration(
              //         color: AppTheme.accent.withOpacity(0.12),
              //         shape: BoxShape.circle,
              //         border: Border.all(color: AppTheme.accent.withOpacity(0.25)),
              //       ),
              //       child: const Icon(Icons.edit_rounded,
              //           color: AppTheme.accent, size: 18),
              //     ),
              //   ),
              // ),

              //keep a small settings icon on every screen (more professional)
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withOpacity(0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.accent.withOpacity(0.25)),
                    ),
                    child: const Icon(Icons.settings_rounded,
                        color: AppTheme.accent, size: 18),
                  ),
                ),
              ),
            ],
            //   const Padding(
            //     padding: EdgeInsets.only(right: 20),
            //     child: ThemeToggleButton(),
            //   ),
            // ],

            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1A1040), const Color(0xFF0A0E1A)]
                        : [const Color(0xFFEEF0FF), const Color(0xFFF5F7FF)],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -30,
                      right: -30,
                      child: Opacity(
                        opacity: heroOpacity,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.accent.withOpacity(0.08),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: -20,
                      child: Opacity(
                        opacity: heroOpacity,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.accentSecondary.withOpacity(0.08),
                          ),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: heroOpacity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            Transform.scale(
                              scale: avatarScale,
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const FullImageScreen()),
                                ),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppTheme.accent,
                                        AppTheme.accentSecondary,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.accent
                                            .withOpacity(0.4 * heroOpacity),
                                        blurRadius: 25,
                                        spreadRadius: 3,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'assets/icon/profile_icon.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              profile.name,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            Text(
                              profile.title,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppTheme.accentSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                      title: 'Personal Details', subtitle: 'Basic information'),
                  const SizedBox(height: 16),
                  _InfoCard(
                    cardColor: cardColor,
                    dividerColor: dividerColor,
                    textColor: textColor,
                    items: [
                      _InfoItem(
                          icon: Icons.person_outline_rounded,
                          label: 'Full Name',
                          value: profile.name),
                      _InfoItem(
                          icon: Icons.school_outlined,
                          label: 'Education',
                          value: profile.education),
                      _InfoItem(
                          icon: Icons.work_outline_rounded,
                          label: 'Role',
                          value: profile.title),
                      _InfoItem(
                          icon: Icons.location_on_outlined,
                          label: 'Location',
                          value: profile.location),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const SectionTitle(title: 'About Me', subtitle: 'Who I am'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: dividerColor),
                    ),
                    child: Text(
                      profile.about,
                      style: GoogleFonts.poppins(
                          fontSize: 13.5, color: textSub, height: 1.8),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const SectionTitle(
                      title: 'Skills', subtitle: 'My technical expertise'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: dividerColor),
                    ),
                    child: Column(
                      children: profile.skills
                          .map((skill) => SkillBar(
                        name: skill['name'],
                        icon: '',
                        level: skill['level'],

                      ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const SectionTitle(
                      title: 'Experience', subtitle: 'Where I have worked'),
                  const SizedBox(height: 16),
                  ...profile.experience.map((exp) => _ExperienceCard(
                      exp: exp,
                      cardColor: cardColor,
                      dividerColor: dividerColor,
                      textColor: textColor,
                      textSub: textSub)),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<_InfoItem> items;
  final Color cardColor, dividerColor, textColor;
  const _InfoCard(
      {required this.items,
        required this.cardColor,
        required this.dividerColor,
        required this.textColor});

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
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(entry.value.icon,
                          color: AppTheme.accent, size: 18),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.value.label,
                            style: GoogleFonts.poppins(
                                fontSize: 11, color: AppTheme.textMuted)),
                        Text(entry.value.value,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
              if (!isLast) Divider(color: dividerColor, height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  _InfoItem({required this.icon, required this.label, required this.value});
}

class _ExperienceCard extends StatelessWidget {
  final Map<String, String> exp;
  final Color cardColor, dividerColor, textColor, textSub;
  const _ExperienceCard({
    required this.exp,
    required this.cardColor,
    required this.dividerColor,
    required this.textColor,
    required this.textSub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [AppTheme.accent, AppTheme.accentSecondary]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.business_center_rounded,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exp['role']!,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 2),
                Text(exp['company']!,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppTheme.accent,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined,
                        size: 12, color: AppTheme.textMuted),
                    const SizedBox(width: 4),
                    Text(exp['duration']!,
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppTheme.textMuted)),
                  ],
                ),
                const SizedBox(height: 10),
                Text(exp['description']!,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: textSub, height: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}