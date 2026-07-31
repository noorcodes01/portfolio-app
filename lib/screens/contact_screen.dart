//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../theme/app_theme.dart';
// import '../data/portfolio_data.dart';
//
// class ContactScreen extends StatelessWidget {
//   const ContactScreen({super.key});
//
//   void _copyToClipboard(BuildContext context, String text, String label) {
//     Clipboard.setData(ClipboardData(text: text));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           '$label copied to clipboard!',
//           style: GoogleFonts.poppins(fontSize: 13),
//
//         ),
//         backgroundColor: AppTheme.accentSecondary,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // flutter pub get
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // HEADER
//
//
//             Padding(
//               padding: const EdgeInsets.only(top: 28),
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       AppTheme.accent.withOpacity(0.2),
//                       AppTheme.accentSecondary.withOpacity(0.1),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
//                 ),
//
//                 child: Column(
//                   children: [
//                     Container(
//                       width: 64,
//                       height: 64,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                           colors: [AppTheme.accent, AppTheme.accentSecondary],
//                         ),
//                         borderRadius: BorderRadius.circular(18),
//                       ),
//                       child: const Icon(
//                         Icons.connect_without_contact_rounded,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                     const SizedBox(height: 14),
//                     Text(
//                       "Let's Connect",
//                       style: GoogleFonts.poppins(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: AppTheme.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       "Open to collaboration, internships, and professional opportunities.",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.poppins(
//                         fontSize: 13,
//                         color: AppTheme.textMuted,
//                         height: 1.6,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 28),
//
//             // CONTACT INFO
//             const _SectionLabel(label: 'Contact Info'),
//             const SizedBox(height: 12),
//
//             _ContactCard(
//               iconWidget: Icon(
//                 Icons.email_outlined,
//                 color: const Color(0xFFEA4335),
//                 size: 22,
//               ),
//               label: 'Email',
//               value: PortfolioData.email,
//               color: const Color(0xFFEA4335),
//               onTap: () => _copyToClipboard(
//                 context,
//                 PortfolioData.email,
//                 'Email',
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             _ContactCard(
//               iconWidget: Icon(
//                 Icons.phone_outlined,
//                 color: const Color(0xFF25D366),
//                 size: 22,
//               ),
//               label: 'Phone',
//               value: PortfolioData.phone,
//               color: const Color(0xFF25D366),
//               onTap: () => _copyToClipboard(
//                 context,
//                 PortfolioData.phone,
//                 'Phone',
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             // SOCIAL LINKS
//             const _SectionLabel(label: 'Professional Profiles'),
//             const SizedBox(height: 12),
//
//             _ContactCard(
//               iconWidget: FaIcon(
//                 FontAwesomeIcons.github,
//                 color: const Color(0xFF6E5494),
//                 size: 22,
//               ),
//               label: 'GitHub',
//               value: PortfolioData.github,
//               color: const Color(0xFF6E5494),
//               onTap: () => _copyToClipboard(
//                 context,
//                 PortfolioData.github,
//                 'GitHub',
//               ),
//             ),
//
//             const SizedBox(height: 10),
//
//             _ContactCard(
//               iconWidget: FaIcon(
//                 FontAwesomeIcons.linkedin,
//                 color: const Color(0xFF0A66C2),
//                 size: 22,
//               ),
//               label: 'LinkedIn',
//               value: PortfolioData.linkedin,
//               color: const Color(0xFF0A66C2),
//               onTap: () => _copyToClipboard(
//                 context,
//                 PortfolioData.linkedin,
//                 'LinkedIn',
//               ),
//             ),
//
//             const SizedBox(height: 28),
//
//             // AVAILABILITY
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: AppTheme.bgCard,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: AppTheme.divider),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppTheme.success,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Available for Opportunities',
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: AppTheme.textPrimary,
//                           ),
//                         ),
//                         Text(
//                           'Currently open to internships and freelance projects.',
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: AppTheme.textMuted,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _SectionLabel extends StatelessWidget {
//   final String label;
//   const _SectionLabel({required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label,
//       style: GoogleFonts.poppins(
//         fontSize: 13,
//         color: AppTheme.textMuted,
//         fontWeight: FontWeight.w500,
//         letterSpacing: 0.5,
//       ),
//     );
//   }
// }
//
// class _ContactCard extends StatelessWidget {
//   final Widget iconWidget;
//   final String label;
//   final String value;
//   final Color color;
//   final VoidCallback onTap;
//
//   const _ContactCard({
//     required this.iconWidget,
//     required this.label,
//     required this.value,
//     required this.color,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: AppTheme.bgCard,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: AppTheme.divider),
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: 46,
//               height: 46,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.12),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(child: iconWidget),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     label,
//                     style: GoogleFonts.poppins(
//                       fontSize: 11,
//                       color: AppTheme.textMuted,
//                     ),
//                   ),
//                   Text(
//                     value,
//                     style: GoogleFonts.poppins(
//                       fontSize: 13.5,
//                       color: AppTheme.textPrimary,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(
//               Icons.copy_outlined,
//               size: 18,
//               color: AppTheme.textMuted,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:portfolio_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
//import '../data/portfolio_data.dart';
import '../widgets/common_widgets.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    try {
      final launched =
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) _showError(context);
    } catch (_) {
      _showError(context);
    }
  }

  Future<void> _launchEmail(BuildContext context, String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    try {
      final launched = await launchUrl(uri);
      if (!launched) _showError(context);
    } catch (_) {
      _showError(context);
    }
  }

  Future<void> _launchPhone(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    try {
      final launched = await launchUrl(uri);
      if (!launched) _showError(context);
    } catch (_) {
      _showError(context);
    }
  }

  void _showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not open link',
            style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);
    final cardColor = AppTheme.cardColor(isDark);
    final dividerColor = AppTheme.dividerColor(isDark);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18,),
            //keep a small settings icon on every screen (more professional)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
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
            ),
            // // Top bar with theme toggle
            // const Padding(
            //   padding: EdgeInsets.only(top: 0.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [ThemeToggleButton()],
            //   ),
            // ),
            // HEADER
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.accent.withOpacity(0.2),
                      AppTheme.accentSecondary.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.accent.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.accent, AppTheme.accentSecondary],
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.connect_without_contact_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Let's Connect",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Open to collaboration, internships, and professional opportunities.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // CONTACT INFO — now opens email/phone apps
            const _SectionLabel(label: 'Contact Info',),
            const SizedBox(height: 12),

            _ContactCard(
              iconWidget: const Icon(Icons.email_outlined,
                  color: Color(0xFFEA4335), size: 22),
              label: 'Email',
              value: profile.email,
              color: const Color(0xFFEA4335),
              cardColor: cardColor,
              dividerColor: dividerColor,
              textColor: textColor,
              onTap: () => _launchEmail(context, profile.email),
            ),

            const SizedBox(height: 10),

            _ContactCard(
              iconWidget: const Icon(Icons.phone_outlined,
                  color: Color(0xFF25D366), size: 22),
              label: 'Phone',
              value: profile.phone,
              color: const Color(0xFF25D366),
              cardColor: cardColor,
              dividerColor: dividerColor,
              textColor: textColor,
              onTap: () => _launchPhone(context, profile.phone),
            ),

            const SizedBox(height: 24),

            // SOCIAL LINKS — now actually open the links
            const _SectionLabel(label: 'Professional Profiles'),
            const SizedBox(height: 12),

            _ContactCard(
              iconWidget: const FaIcon(FontAwesomeIcons.github,
                  color: Color(0xFF6E5494), size: 22),
              label: 'GitHub',
              value: profile.github,
              color: const Color(0xFF6E5494),
              cardColor: cardColor,
              dividerColor: dividerColor,
              textColor: textColor,
              onTap: () => _launchUrl(context, profile.github),
            ),

            const SizedBox(height: 10),

            _ContactCard(
              iconWidget: const FaIcon(FontAwesomeIcons.linkedin,
                  color: Color(0xFF0A66C2), size: 22),
              label: 'LinkedIn',
              value: profile.linkedin,
              color: const Color(0xFF0A66C2),
              cardColor: cardColor,
              dividerColor: dividerColor,
              textColor: textColor,
              onTap: () => _launchUrl(context, profile.linkedin),
            ),

            const SizedBox(height: 10),

            _ContactCard(
              iconWidget: const Icon(Icons.language_rounded,
                  color: AppTheme.accent, size: 22),
              label: 'Portfolio Website',
              value: profile.portfolio,
              color: AppTheme.accent,
              cardColor: cardColor,
              dividerColor: dividerColor,
              textColor: textColor,
              onTap: () => _launchUrl(context, profile.portfolio),
            ),

            const SizedBox(height: 28),

            // AVAILABILITY
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: dividerColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.success,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.success.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available for Opportunities',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        Text(
                          'Currently open to internships and freelance projects.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 13,
        color: AppTheme.textMuted,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final Widget iconWidget;
  final String label;
  final String value;
  final Color color, cardColor, dividerColor, textColor;
  final VoidCallback onTap;

  const _ContactCard({
    required this.iconWidget,
    required this.label,
    required this.value,
    required this.color,
    required this.cardColor,
    required this.dividerColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: dividerColor),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: iconWidget),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.poppins(
                          fontSize: 11, color: AppTheme.textMuted)),
                  Text(value,
                      style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          color: textColor,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.open_in_new_rounded, size: 18, color: color),
          ],
        ),
      ),
    );
  }
}