import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/profile_provider.dart';

class EditSkillsScreen extends StatelessWidget {
  const EditSkillsScreen({super.key});

  void _showDialog(BuildContext context, bool isDark,
      {Map<String, dynamic>? existing, int? index}) {
    final nameCtrl =
    TextEditingController(text: existing?['name'] ?? '');
    // final iconCtrl =
    // TextEditingController(text: existing?['icon'] ?? '');
    double level = (existing?['level'] as num?)?.toDouble() ?? 0.5;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          backgroundColor: AppTheme.cardColor(isDark),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: Text(
              existing == null ? 'Add Skill' : 'Edit Skill',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textColor(isDark))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogField('Skill Name', nameCtrl, isDark),
              const SizedBox(height: 12),
              // _dialogField('Emoji Icon (e.g. 📱)', iconCtrl, isDark),
              // const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Proficiency Level',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppTheme.textMuted)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${(level * 100).toInt()}%',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppTheme.accent,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              Slider(
                value: level,
                min: 0.1,
                max: 1.0,
                divisions: 18,
                activeColor: AppTheme.accent,
                inactiveColor: AppTheme.accent.withOpacity(0.2),
                onChanged: (v) => setS(() => level = v),
              ),
              // Preview bar
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: level,
                  minHeight: 6,
                  backgroundColor:
                  AppTheme.accent.withOpacity(0.15),
                  valueColor: const AlwaysStoppedAnimation(
                      AppTheme.accent),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel',
                  style: GoogleFonts.poppins(
                      color: AppTheme.textMuted)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                if (nameCtrl.text.trim().isEmpty) return;
                final skill = {
                  'name': nameCtrl.text.trim(),
                  // 'icon': iconCtrl.text.trim().isEmpty
                  //     ? '⭐'
                  //     : iconCtrl.text.trim(),
                  'level': level,
                };
                final p = Provider.of<ProfileProvider>(context,
                    listen: false);
                if (index == null) {
                  await p.addSkill(skill);
                } else {
                  await p.updateSkill(index, skill);
                }
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: Text('Save',
                  style:
                  GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogField(String label,
      TextEditingController ctrl, bool isDark,
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
        title: Text('Edit Skills',
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
          if (profile.skills.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.code_off_rounded,
                      size: 60,
                      color: AppTheme.textMuted.withOpacity(0.4)),
                  const SizedBox(height: 16),
                  Text('No skills yet',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Text('Tap + Add to add your first skill',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppTheme.textMuted)),
                ],
              ),
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Row(
                  children: [
                    const Icon(Icons.drag_handle_rounded,
                        color: AppTheme.textMuted, size: 16),
                    const SizedBox(width: 6),
                    Text('Hold and drag to reorder',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppTheme.textMuted)),
                  ],
                ),
              ),
              Expanded(
                child: ReorderableListView.builder(
                  padding:
                  const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  itemCount: profile.skills.length,
                  onReorder: (o, n) =>
                      Provider.of<ProfileProvider>(context,
                          listen: false)
                          .reorderSkills(o, n),
                  itemBuilder: (context, i) {
                    final skill = profile.skills[i];
                    final level =
                    (skill['level'] as num).toDouble();
                    return Container(
                      key: ValueKey('skill_$i'),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: dividerColor),
                      ),
                      child: Row(
                        children: [
                          // Text(skill['icon'],
                          //     style:
                          //     const TextStyle(fontSize: 24)),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(skill['name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight.w600,
                                              color: textColor)),
                                    ),

                                    const SizedBox(width: 8,),
                                    Text(
                                        '${(level * 100).toInt()}%',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: AppTheme.accent,
                                            fontWeight:
                                            FontWeight.w600)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(3),
                                  child: LinearProgressIndicator(
                                    value: level,
                                    minHeight: 6,
                                    backgroundColor: AppTheme
                                        .accent
                                        .withOpacity(0.15),
                                    valueColor:
                                    const AlwaysStoppedAnimation(
                                        AppTheme.accent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.edit_rounded,
                                color: AppTheme.accent, size: 18),
                            onPressed: () => _showDialog(context,
                                isDark,
                                existing: skill, index: i),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_rounded,
                                color: AppTheme.error, size: 18),
                            onPressed: () async {
                              final ok = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: cardColor,
                                  title: Text('Delete Skill?',
                                      style: GoogleFonts.poppins(
                                          color: textColor,
                                          fontWeight:
                                          FontWeight.w600)),
                                  content: Text(
                                      'Remove "${skill['name']}"?',
                                      style: GoogleFonts.poppins(
                                          color:
                                          AppTheme.textMuted)),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(
                                                ctx, false),
                                        child: Text('Cancel',
                                            style:
                                            GoogleFonts.poppins(
                                                color: AppTheme
                                                    .textMuted))),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(
                                                ctx, true),
                                        child: Text('Delete',
                                            style:
                                            GoogleFonts.poppins(
                                                color: AppTheme
                                                    .error))),
                                  ],
                                ),
                              );
                              if (ok == true && context.mounted) {
                                await Provider.of<ProfileProvider>(
                                    context,
                                    listen: false)
                                    .deleteSkill(i);
                              }
                            },
                          ),
                          const Icon(Icons.drag_handle_rounded,
                              color: AppTheme.textMuted, size: 20),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}