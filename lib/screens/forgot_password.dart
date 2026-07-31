import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../services/firebase_service.dart';
import '../widgets/common_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _emailSent = false;
  String? _error;

  late AnimationController _anim;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600));
    _fade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _sendReset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final error = await FirebaseService.sendPasswordResetEmail(
        _emailCtrl.text.trim());

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (error == null) {
      setState(() => _emailSent = true);
    } else {
      setState(() => _error = error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF0A0E1A),
                const Color(0xFF0F1729)]
                  : [const Color(0xFFF5F7FF),
                const Color(0xFFEEF0FF)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 28),
              physics: const ClampingScrollPhysics(),
              child: FadeTransition(
                opacity: _fade,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Back button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppTheme.accent
                                .withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 18,
                              color: AppTheme.accent),
                        ),
                      ),
                      const SizedBox(height: 32),

                      if (!_emailSent) ...[
                        // Icon
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  AppTheme.accent,
                                  AppTheme.accentSecondary,
                                ]),
                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                          child: const Icon(
                              Icons.lock_reset_rounded,
                              color: Colors.white,
                              size: 32),
                        ),
                        const SizedBox(height: 24),
                        Text('Forgot Password?',
                            style: GoogleFonts.poppins(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: textColor)),
                        const SizedBox(height: 10),
                        Text(
                          'Enter your email address and we\'ll send you '
                              'a link to reset your password.',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppTheme.textMuted,
                              height: 1.5),
                        ),
                        const SizedBox(height: 36),

                        // Error
                        if (_error != null) ...[
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppTheme.error
                                  .withOpacity(0.1),
                              borderRadius:
                              BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppTheme.error
                                      .withOpacity(0.3)),
                            ),
                            child: Row(children: [
                              const Icon(
                                  Icons.error_outline_rounded,
                                  color: AppTheme.error,
                                  size: 18),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: Text(_error!,
                                      style: GoogleFonts.poppins(
                                          color: AppTheme.error,
                                          fontSize: 13))),
                            ]),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Email label
                        Text('Email Address',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType:
                          TextInputType.emailAddress,
                          style: GoogleFonts.poppins(
                              color: textColor, fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon:
                            Icon(Icons.email_outlined),
                          ),
                          validator: (v) {
                            if (v == null ||
                                v.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(v.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

                        _isLoading
                            ? Container(
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [
                                  AppTheme.accent,
                                  Color(0xFF8B83FF),
                                ]),
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          child: const Center(
                              child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child:
                                  CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2))),
                        )
                            : GradientButton(
                          text: 'Send Reset Link',
                          //icon: Icons.send_rounded,
                          onTap: _sendReset,
                        ),
                      ] else ...[
                        // ── Success state ──
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: AppTheme.success
                                      .withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                    Icons.mark_email_read_rounded,
                                    color: AppTheme.success,
                                    size: 50),
                              ),
                              const SizedBox(height: 28),
                              Text('Email Sent!',
                                  style: GoogleFonts.poppins(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: textColor)),
                              const SizedBox(height: 14),
                              Text(
                                'We sent a password reset link to:\n${_emailCtrl.text.trim()}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: AppTheme.textMuted,
                                    height: 1.6),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Check your inbox and click the link to reset your password.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: AppTheme.textMuted,
                                    height: 1.5),
                              ),
                              const SizedBox(height: 40),
                              GradientButton(
                                text: 'Back to Sign In',
                                //icon: Icons.login_rounded,
                                onTap: () =>
                                    Navigator.pop(context),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () => setState(
                                        () => _emailSent = false),
                                child: Text(
                                  'Resend email',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: AppTheme.accent,
                                      fontWeight:
                                      FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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