//import 'package:portfolio_app/services/api_service.dart';
import 'package:portfolio_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/portfolio_data.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // // Add these variables to _HomeScreenState
  // String? _quote;
  // String? _quoteAuthor;
  // bool _loadingQuote = true;
  // List<Map<String, dynamic>> _githubRepos = [];
  // bool _loadingRepos = true;

  // Future<void> _fetchApiData() async {
  //   // Fetch quote
  //   try {
  //     final quote = await ApiService.fetchQuote();
  //     if (mounted && quote != null) {
  //       setState(() {
  //         _quote = quote['quote'];
  //         _quoteAuthor = quote['author'];
  //         _loadingQuote = false;
  //       });
  //     } else {
  //       if (mounted) setState(() => _loadingQuote = false);
  //     }
  //   } catch (e) {
  //     if (mounted) setState(() => _loadingQuote = false);
  //   }
  //
  //   // Fetch GitHub repos
  //   try {
  //     final repos =
  //     await ApiService.fetchGithubRepos('KainatNoor');
  //     if (mounted && repos != null) {
  //       setState(() {
  //         _githubRepos = repos;
  //         _loadingRepos = false;
  //       });
  //     } else {
  //       if (mounted) setState(() => _loadingRepos = false);
  //     }
  //   } catch (e) {
  //     if (mounted) setState(() => _loadingRepos = false);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    // // Fetch API data
    // _fetchApiData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final profile = Provider.of<ProfileProvider>(context);
    final profile = Provider.of<ProfileProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);
    final textSub = AppTheme.textSubColor(isDark);
    final cardColor = AppTheme.cardColor(isDark);
    final dividerColor = AppTheme.dividerColor(isDark);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF0D1220), AppTheme.bgDark]
                : [const Color(0xFFEEF0FF), AppTheme.lightBg],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // Top Bar with theme toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome to my portfolio',
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Explore my projects, skills, and journey',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Padding(
                          padding: const EdgeInsets.only(right: 0.0),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppTheme.accent.withOpacity(0.12),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppTheme.accent.withOpacity(0.25)),
                              ),
                              child: const Icon(
                                Icons.settings_rounded,
                                color: AppTheme.accent,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                      // Padding(
                      //   padding: const EdgeInsets.only( top: 0.0, right: 0.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       const ThemeToggleButton(),
                      //     ],
                      //   ),
                      // ),
                    ),
                    const SizedBox(height: 32),
                    // Hero Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.accent.withOpacity(0.2),
                            AppTheme.accentSecondary.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppTheme.accent.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const FullImageScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    AppTheme.accent,
                                    AppTheme.accentSecondary
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.accent.withOpacity(0.4),
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
                          const SizedBox(height: 20),
                          Text(
                            profile.name,
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppTheme.accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              profile.title,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppTheme.accent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            profile.subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Quick Stats
                    Row(
                      children: [
                        _StatCard(
                          value: '4+',
                          label: 'Projects',
                          icon: Icons.work_rounded,
                          color: AppTheme.accent,
                          cardColor: cardColor,
                          dividerColor: dividerColor,
                          textColor: textColor,
                        ),
                        const SizedBox(width: 12),
                        _StatCard(
                          value: '6+',
                          label: 'Skills',
                          icon: Icons.code_rounded,
                          color: AppTheme.accentSecondary,
                          cardColor: cardColor,
                          dividerColor: dividerColor,
                          textColor: textColor,
                        ),
                        const SizedBox(width: 12),
                        _StatCard(
                          value: '2+',
                          label: 'Experience',
                          icon: Icons.school_rounded,
                          color: const Color(0xFFFF6B6B),
                          cardColor: cardColor,
                          dividerColor: dividerColor,
                          textColor: textColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // About
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
                          Row(
                            children: [
                              const Icon(Icons.person_outline_rounded,
                                  color: AppTheme.accent, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'About Me',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            profile.about,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: textSub,
                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Technical Skills',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: profile.skills
                          .map((s) => _SkillChip(
                        //icon: s['icon'],
                        label: s['name'],
                        cardColor: cardColor,
                        dividerColor: dividerColor,
                        textSub: textSub,
                      ))
                          .toList(),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color, cardColor, dividerColor, textColor;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    required this.cardColor,
    required this.dividerColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: dividerColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final Color cardColor, dividerColor, textSub;

  const _SkillChip({
    //required this.icon,
    required this.label,
    required this.cardColor,
    required this.dividerColor,
    required this.textSub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Text(icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: textSub,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  const FullImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.asset(
            'assets/icon/profile_icon.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}