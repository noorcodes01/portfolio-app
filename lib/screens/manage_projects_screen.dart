import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/projects_provider.dart';
import '../widgets/common_widgets.dart';
import 'edit_project_screen.dart';

class ManageProjectsScreen extends StatelessWidget {
  const ManageProjectsScreen({super.key});

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
        title: Text('Manage Projects',
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const EditProjectScreen()),
        ),
        backgroundColor: AppTheme.accent,
        icon:
        const Icon(Icons.add_rounded, color: Colors.white),
        label: Text('Add Project',
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ),
      body: Consumer<ProjectsProvider>(
        builder: (context, provider, _) {
          final projects = provider.allProjects;
          if (projects.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_off_rounded,
                      size: 60,
                      color: AppTheme.textMuted.withOpacity(0.4)),
                  const SizedBox(height: 16),
                  Text('No projects yet',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppTheme.textMuted,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Text('Tap + Add Project to get started',
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppTheme.textMuted)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
            physics: const ClampingScrollPhysics(),
            itemCount: projects.length,
            itemBuilder: (context, i) {
              final project = projects[i];
              final color = Color(project['color'] as int);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: dividerColor),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          color,
                          color.withOpacity(0.5)
                        ]),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(project['icon'],
                                  style: const TextStyle(
                                      fontSize: 24)),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(project['title'],
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: textColor)),
                                const SizedBox(height: 2),
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2),
                                  decoration: BoxDecoration(
                                    color:
                                    color.withOpacity(0.12),
                                    borderRadius:
                                    BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                      project['category'],
                                      style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: color,
                                          fontWeight:
                                          FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                          // Edit button
                          IconButton(
                            icon: const Icon(Icons.edit_rounded,
                                color: AppTheme.accent, size: 20),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProjectScreen(
                                  existing: project,
                                  index: i,
                                ),
                              ),
                            ),
                          ),
                          // Delete button
                          IconButton(
                            icon: Icon(Icons.delete_rounded,
                                color: AppTheme.error, size: 20),
                            onPressed: () async {
                              final ok = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: cardColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          16)),
                                  title: Text('Delete Project?',
                                      style: GoogleFonts.poppins(
                                          color: textColor,
                                          fontWeight:
                                          FontWeight.w600)),
                                  content: Text(
                                      'Remove "${project['title']}"? This cannot be undone.',
                                      style: GoogleFonts.poppins(
                                          color:
                                          AppTheme.textMuted,
                                          fontSize: 13)),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(
                                                ctx, false),
                                        child: Text('Cancel',
                                            style: GoogleFonts
                                                .poppins(
                                                color: AppTheme
                                                    .textMuted))),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.pop(
                                                ctx, true),
                                        child: Text('Delete',
                                            style: GoogleFonts
                                                .poppins(
                                                color: AppTheme
                                                    .error,
                                                fontWeight:
                                                FontWeight
                                                    .w600))),
                                  ],
                                ),
                              );
                              if (ok == true &&
                                  context.mounted) {
                                await provider.deleteProject(i);
                              }
                            },
                          ),
                        ],
                      ),
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