import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/providers/profile_provider.dart';
import 'package:portfolio_app/services/auth_service.dart';
//import 'package:portfolio_app/screens/setup_screen.dart';
import 'package:provider/provider.dart';
import '../providers/projects_provider.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import 'main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _taglineController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _glowAnim;
  late Animation<double> _textOpacity;
  late Animation<Offset> _textSlide;
  late Animation<double> _taglineOpacity;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _startAnimations();
    // });



    // Logo animation controller
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Text animation controller
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Tagline + progress controller
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Logo scale: pops in with bounce
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    // Logo fade in
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Glow pulse
    _glowAnim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    // Name text
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Tagline + progress bar
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _taglineController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _progressAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _taglineController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Chain the animations
    _startAnimations();


  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(
      const AssetImage('assets/icon/profile_icon.png'),
      context,
    );
  }


  // // Replace only this method
  // void _startAnimations() async {
  //   await Future.delayed(const Duration(milliseconds: 300));
  //   if (!mounted) return;
  //   _logoController.forward();
  //
  //   await Future.delayed(const Duration(milliseconds: 500));
  //   if (!mounted) return;
  //   _textController.forward();
  //
  //   await Future.delayed(const Duration(milliseconds: 400));
  //   if (!mounted) return;
  //   _taglineController.forward();
  //
  //   await Future.delayed(const Duration(milliseconds: 2400));
  //   if (!mounted) return;
  //
  //   final auth = Provider.of<AuthService>(context, listen: false);
  //
  //   // Wait for Firebase Auth to initialize
  //   int waited = 0;
  //   while (auth.isLoading && waited < 3000) {
  //     await Future.delayed(const Duration(milliseconds: 50));
  //     waited += 50;
  //   }
  //   if (!mounted) return;
  //
  //   if (auth.isLoggedIn) {
  //     // Load user data from Firestore
  //     await Provider.of<ProfileProvider>(context, listen: false).refresh();
  //     await Provider.of<ProjectsProvider>(context, listen: false).refresh();
  //     if (!mounted) return;
  //     Navigator.pushReplacement(
  //       context,
  //       PageRouteBuilder(
  //         pageBuilder: (_, __, ___) => const MainNavigation(),
  //         transitionsBuilder: (_, anim, __, child) =>
  //             FadeTransition(opacity: anim, child: child),
  //         transitionDuration: const Duration(milliseconds: 600),
  //       ),
  //     );
  //   } else {
  //     Navigator.pushReplacement(
  //       context,
  //       PageRouteBuilder(
  //         pageBuilder: (_, __, ___) => const LoginScreen(),
  //         transitionsBuilder: (_, anim, __, child) =>
  //             FadeTransition(opacity: anim, child: child),
  //         transitionDuration: const Duration(milliseconds: 600),
  //       ),
  //     );
  //   }
  // }

  void _startAnimations() async {
    // Start logo immediately
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _taglineController.forward();

    // Total wait: ~1.8s max
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;

    final auth = Provider.of<AuthService>(context, listen: false);

    // Firebase already initialized in main() so isLoading
    // should be false almost immediately
    int waited = 0;
    while (auth.isLoading && waited < 800) {
      await Future.delayed(const Duration(milliseconds: 50));
      waited += 50;
    }
    if (!mounted) return;

    if (auth.isLoggedIn) {
      // Load data in background — don't block navigation
      Provider.of<ProfileProvider>(context, listen: false)
          .refresh();
      Provider.of<ProjectsProvider>(context, listen: false)
          .refresh();

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainNavigation(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    }
  }



  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A0E1A),
              Color(0xFF0F1729),
              Color(0xFF0A0E1A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative circles
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accent.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -60,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentSecondary.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: -40,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accent.withOpacity(0.04),
                ),
              ),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoOpacity.value,
                        child: Transform.scale(
                          scale: _logoScale.value,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppTheme.accent,
                                  AppTheme.accentSecondary,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.accent
                                      .withOpacity(_glowAnim.value * 0.6),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                                BoxShadow(
                                  color: AppTheme.accentSecondary
                                      .withOpacity(_glowAnim.value * 0.3),
                                  blurRadius: 60,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      'assets/icon/profile_icon.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.white,
                                        );
                                      },
                                    ),
                                  ),

                                  // Container(
                                  //   width: 40,
                                  //   height: 2,
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.white.withOpacity(0.6),
                                  //     borderRadius: BorderRadius.circular(1),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Animated Name
                  FadeTransition(
                    opacity: _textOpacity,
                    child: SlideTransition(
                      position: _textSlide,
                      child: Column(
                        children: [
                          Text(
                            //'Kainat Noor',
                            profile.name,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                              letterSpacing: 1,
                            ),
                          ),

                          // Text(
                          //   profile.name,
                          //   style: GoogleFonts.poppins(
                          //     fontSize: 24,
                          //     fontWeight: FontWeight.bold,
                          //     color: textColor,
                          //     height: 1.2,
                          //   ),
                          // ),
                          const SizedBox(height: 6),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                AppTheme.accent,
                                AppTheme.accentSecondary,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              profile.title,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tagline
                  FadeTransition(
                    opacity: _taglineOpacity,
                    child: Text(
                      //'• CS Student  •  UI/UX Enthusiast',
                      '• ${profile.subtitle.replaceAll(' | ', ' • ')}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom progress bar
            Positioned(
              bottom: 60,
              left: 60,
              right: 60,
              child: FadeTransition(
                opacity: _taglineOpacity,
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _progressAnim,
                      builder: (context, child) {
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: _progressAnim.value,
                                minHeight: 3,
                                backgroundColor:
                                AppTheme.bgSurface,
                                valueColor:
                                const AlwaysStoppedAnimation<Color>(
                                  AppTheme.accent,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Loading Portfolio...',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}