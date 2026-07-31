import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import '../providers/profile_provider.dart';
import '../providers/projects_provider.dart';
import '../widgets/common_widgets.dart';
import 'forgot_password.dart';
import 'main_navigation.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  bool _isLoading = false;
  String? _error;

  late AnimationController _anim;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // Future<void> _signIn() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   setState(() { _isLoading = true; _error = null; });
  //
  //   final auth = Provider.of<AuthService>(context, listen: false);
  //   final error = await auth.signIn(
  //     _emailCtrl.text.trim(),
  //     _passwordCtrl.text.trim(),
  //   );
  //
  //   if (!mounted) return;
  //   setState(() => _isLoading = false);
  //
  //   if (error == null) {
  //     await Provider.of<ProfileProvider>(context, listen: false).refresh();
  //     await Provider.of<ProjectsProvider>(context, listen: false).refresh();
  //     if (!mounted) return;
  //     Navigator.pushReplacement(context, MaterialPageRoute(
  //         builder: (_) => const MainNavigation()));
  //   } else {
  //     setState(() => _error = error);
  //   }
  // }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;

    // ✅ Show loading immediately before any await
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      final error = await auth.signIn(
        _emailCtrl.text.trim(),
        _passwordCtrl.text.trim(),
      );

      if (!mounted) return;

      if (error == null) {
        Provider.of<ProfileProvider>(context, listen: false).refresh();
        Provider.of<ProjectsProvider>(context, listen: false).refresh();

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
        setState(() {
          _isLoading = false;
          _error = error;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = 'Something went wrong. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [const Color(0xFF0A0E1A), const Color(0xFF0F1729),
              const Color(0xFF0A0E1A)]
                : [const Color(0xFFF5F7FF), const Color(0xFFEEF0FF),
              const Color(0xFFF5F7FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            physics: const ClampingScrollPhysics(),
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),

                      Container(
                        width: 100, height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(colors: [
                            AppTheme.accent, AppTheme.accentSecondary]),
                          boxShadow: [BoxShadow(
                              color: AppTheme.accent.withOpacity(0.4),
                              blurRadius: 30, spreadRadius: 5)],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/icon/profile_icon.png',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                            const Icon(Icons.person_rounded,
                                color: Colors.white, size: 50),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      Text('Welcome Back',
                          style: GoogleFonts.poppins(
                              fontSize: 28, fontWeight: FontWeight.bold,
                              color: textColor)),
                      const SizedBox(height: 8),
                      Text('Sign in to my portfolio',
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: AppTheme.textMuted)),
                      const SizedBox(height: 40),

                      if (_error != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppTheme.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppTheme.error.withOpacity(0.3)),
                          ),
                          child: Row(children: [
                            const Icon(Icons.error_outline_rounded,
                                color: AppTheme.error, size: 18),
                            const SizedBox(width: 10),
                            Expanded(child: Text(_error!,
                                style: GoogleFonts.poppins(
                                    color: AppTheme.error, fontSize: 13))),
                          ]),
                        ),
                        const SizedBox(height: 20),
                      ],

                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.poppins(
                            color: textColor, fontSize: 14),
                        decoration: const InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Please enter email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(v.trim())) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),

                      TextFormField(
                        controller: _passwordCtrl,
                        obscureText: _obscure,
                        style: GoogleFonts.poppins(
                            color: textColor, fontSize: 14),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(_obscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                                color: AppTheme.textMuted),
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Enter password';
                          if (v.length < 6) return 'Min. 6 characters';
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      // Add after password field SizedBox(height: 18)
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen()),
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppTheme.accent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      _isLoading
                          ? Container(
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            AppTheme.accent, Color(0xFF8B83FF)]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(child: SizedBox(
                            width: 24, height: 24,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))),
                      )
                          : GradientButton(
                          text: 'Sign In',
                          //icon: Icons.login_rounded,
                          onTap: _signIn),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, color: AppTheme.textMuted)),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                    builder: (_) => const SignupScreen())),
                            child: Text('Sign Up',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: AppTheme.accent,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}