import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/profile_provider.dart';

class EditExperienceScreen extends StatelessWidget {
  const EditExperienceScreen({super.key});

  void _showDialog(BuildContext context, bool isDark,
      {Map<String, String>? existing, int? index}) {
    final roleCtrl =
    TextEditingController(text: existing?['role'] ?? '');
    final companyCtrl =
    TextEditingController(text: existing?['company'] ?? '');
    final durationCtrl =
    TextEditingController(text: existing?['duration'] ?? '');
    final descCtrl =
    TextEditingController(text: existing?['description'] ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.cardColor(isDark),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: Text(
            existing == null ? 'Add Experience' : 'Edit Experience',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppTheme.textColor(isDark))),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dField('Job Title / Role', roleCtrl, isDark),
              const SizedBox(height: 12),
              _dField('Company Name', companyCtrl, isDark),
              const SizedBox(height: 12),
              _dField('Duration (e.g. 2024 - Present)',
                  durationCtrl, isDark),
              const SizedBox(height: 12),
              _dField('Description', descCtrl, isDark, maxLines: 3),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style:
                GoogleFonts.poppins(color: AppTheme.textMuted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () async {
              if (roleCtrl.text.trim().isEmpty ||
                  companyCtrl.text.trim().isEmpty) return;
              final exp = {
                'role': roleCtrl.text.trim(),
                'company': companyCtrl.text.trim(),
                'duration': durationCtrl.text.trim(),
                'description': descCtrl.text.trim(),
              };
              final p = Provider.of<ProfileProvider>(context,
                  listen: false);
              if (index == null) {
                await p.addExperience(exp);
              } else {
                await p.updateExperience(index, exp);
              }
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: Text('Save',
                style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _dField(String label, TextEditingController ctrl,
      bool isDark,
      {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
          color: AppTheme.textColor(isDark), fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(
            color: AppTheme.textMuted, fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppTheme.dividerColor(isDark))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: AppTheme.dividerColor(isDark))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: AppTheme.accent, width: 2)),
      ),
    );
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
        title: Text('Edit Experience',
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => _showDialog(context, isDark),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    AppTheme.accent,
                    Color(0xFF8B83FF)
                  ]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add_rounded,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text('Add',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, _) {
          if (profile.experience.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_off_rounded,
                      size: 60,
                      color: AppTheme.textMuted.withOpacity(0.4)),
                  const SizedBox(height: 16),
                  Text('No experience added yet',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Text('Tap + Add to add your experience',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppTheme.textMuted)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            physics: const ClampingScrollPhysics(),
            itemCount: profile.experience.length,
            itemBuilder: (context, i) {
              final exp = profile.experience[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: dividerColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          AppTheme.accent,
                          AppTheme.accentSecondary
                        ]),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                          Icons.business_center_rounded,
                          color: Colors.white,
                          size: 20),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(exp['role'] ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: textColor)),
                          const SizedBox(height: 2),
                          Text(exp['company'] ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppTheme.accent,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(height: 2),
                          Row(children: [
                            const Icon(
                                Icons.calendar_today_outlined,
                                size: 11,
                                color: AppTheme.textMuted),
                            const SizedBox(width: 4),
                            Text(exp['duration'] ?? '',
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppTheme.textMuted)),
                          ]),
                          if ((exp['description'] ?? '')
                              .isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(exp['description'] ?? '',
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppTheme.textMuted,
                                    height: 1.5)),
                          ],
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_rounded,
                              color: AppTheme.accent, size: 18),
                          onPressed: () => _showDialog(context,
                              isDark,
                              existing: exp, index: i),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_rounded,
                              color: AppTheme.error, size: 18),
                          onPressed: () async {
                            final ok = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                backgroundColor: cardColor,
                                title: Text('Delete Experience?',
                                    style: GoogleFonts.poppins(
                                        color: textColor,
                                        fontWeight:
                                        FontWeight.w600)),
                                content: Text(
                                    'Remove "${exp['role']}"?',
                                    style: GoogleFonts.poppins(
                                        color:
                                        AppTheme.textMuted)),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx, false),
                                      child: Text('Cancel',
                                          style:
                                          GoogleFonts.poppins(
                                              color: AppTheme
                                                  .textMuted))),
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx, true),
                                      child: Text('Delete',
                                          style:
                                          GoogleFonts.poppins(
                                              color:
                                              AppTheme.error))),
                                ],
                              ),
                            );
                            if (ok == true && context.mounted) {
                              await Provider.of<ProfileProvider>(
                                  context,
                                  listen: false)
                                  .deleteExperience(i);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}