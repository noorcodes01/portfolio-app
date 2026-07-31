import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import '../providers/profile_provider.dart';
import '../providers/projects_provider.dart';
import '../widgets/common_widgets.dart';
import 'main_navigation.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;
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
    _slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  // Future<void> _signUp() async {
  //   if (!_formKey.currentState!.validate()) return;
  //   setState(() { _isLoading = true; _error = null; });
  //
  //   final auth = Provider.of<AuthService>(context, listen: false);
  //   final error = await auth.signUp(
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

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      final error = await auth.signUp(
        _emailCtrl.text.trim(),
        _passwordCtrl.text.trim(),
      );

      if (!mounted) return;

      if (error == null) {
        Provider.of<ProfileProvider>(context, listen: false).refresh();
        Provider.of<ProjectsProvider>(context, listen: false).refresh();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigation()),
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

    return Expanded(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF0A0E1A), const Color(0xFF0F1729)]
                  : [const Color(0xFFF5F7FF), const Color(0xFFEEF0FF)],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        Container(
                          width: 70, height: 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              AppTheme.accent, AppTheme.accentSecondary]),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(
                                color: AppTheme.accent.withOpacity(0.4),
                                blurRadius: 20, spreadRadius: 3)],
                          ),
                          child: const Icon(Icons.person_add_rounded,
                              color: Colors.white, size: 32),
                        ),
                        const SizedBox(height: 24),
                        Text('Create Account',
                            style: GoogleFonts.poppins(
                                fontSize: 28, fontWeight: FontWeight.bold,
                                color: textColor)),
                        const SizedBox(height: 8),
                        Text(
                          'Sign up to get your portfolio.',
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: AppTheme.textMuted,
                              height: 1.5),
                        ),
                        const SizedBox(height: 32),

                        if (_error != null) ...[
                          Container(
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

                        _lbl('Email Address'),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.poppins(
                              color: textColor, fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'your@email.com',
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

                        _lbl('Password'),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscure1,
                          style: GoogleFonts.poppins(
                              color: textColor, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Min. 6 characters',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure1
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                                  color: AppTheme.textMuted),
                              onPressed: () =>
                                  setState(() => _obscure1 = !_obscure1),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Enter password';
                            if (v.length < 6) return 'Min. 6 characters';
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),

                        _lbl('Confirm Password'),
                        TextFormField(
                          controller: _confirmCtrl,
                          obscureText: _obscure2,
                          style: GoogleFonts.poppins(
                              color: textColor, fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Re-enter password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure2
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                                  color: AppTheme.textMuted),
                              onPressed: () =>
                                  setState(() => _obscure2 = !_obscure2),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Confirm password';
                            }
                            if (v != _passwordCtrl.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

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
                            text: 'Create Account',
                            //icon: Icons.arrow_forward_rounded,
                            onTap: _signUp),
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account? ',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: AppTheme.textMuted)),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginScreen())),
                              child: Text('Sign In',
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
      ),
    );
  }

  Widget _lbl(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(t,
        style: GoogleFonts.poppins(
            fontSize: 12, color: AppTheme.textMuted,
            fontWeight: FontWeight.w500)),
  );
}