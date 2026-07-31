

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_app/screens/settings_screen.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/projects_provider.dart';
import '../widgets/common_widgets.dart';
import 'edit_project_screen.dart';
import 'project_detail_screen.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);
    final cardColor = AppTheme.cardColor(isDark);
    final dividerColor = AppTheme.dividerColor(isDark);

    return Scaffold(
      appBar: AppBar(
        title: Text('Projects',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: textColor)),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SettingsScreen()),
              ),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppTheme.accent.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppTheme.accent.withOpacity(0.25)),
                ),
                child: const Icon(Icons.settings_rounded,
                    color: AppTheme.accent, size: 18),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const EditProjectScreen()),
        ),
        backgroundColor: AppTheme.accent,
        child:
        const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: Column(
        children: [
          // ── Search + Filter (fixed, not scrolling) ──
          Container(
            color: AppTheme.bgColor(isDark),
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
            child: Column(
              children: [
                Consumer<ProjectsProvider>(
                  builder: (context, provider, _) => TextField(
                    onChanged: provider.setSearch,
                    style: GoogleFonts.poppins(
                        color: textColor, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search projects...',
                      prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppTheme.textMuted),
                      suffixIcon: provider.searchQuery.isNotEmpty
                          ? GestureDetector(
                        onTap: provider.clearSearch,
                        child: const Icon(
                            Icons.close_rounded,
                            color: AppTheme.textMuted),
                      )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Consumer<ProjectsProvider>(
                  builder: (context, provider, _) => SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.categories.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = provider.categories[index];
                        final isSelected =
                            provider.selectedCategory == cat;
                        return GestureDetector(
                          onTap: () =>
                              provider.setCategory(cat),
                          child: AnimatedContainer(
                            duration:
                            const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.accent
                                  : cardColor,
                              borderRadius:
                              BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppTheme.accent
                                    : dividerColor,
                              ),
                            ),
                            child: Text(
                              cat,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.textMuted,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // ── Projects List ──
          Expanded(
            child: Consumer<ProjectsProvider>(
              builder: (context, provider, _) {
                final projects = provider.filteredProjects;

                if (projects.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 60,
                            color: AppTheme.textMuted
                                .withOpacity(0.5)),
                        const SizedBox(height: 16),
                        Text('No projects found',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: AppTheme.textMuted,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        Text(
                            'Try a different search or category',
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppTheme.textMuted)),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding:
                  const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  physics: const ClampingScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    // ✅ Get real index from allProjects
                    final realIndex = provider.allProjects
                        .indexOf(project);
                    return _ProjectCard(
                      project: project,
                      realIndex: realIndex,
                      cardColor: cardColor,
                      dividerColor: dividerColor,
                      textColor: textColor,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final int realIndex; // ✅ renamed from index to realIndex
  final Color cardColor, dividerColor, textColor;

  const _ProjectCard({
    required this.project,
    required this.realIndex,
    required this.cardColor,
    required this.dividerColor,
    required this.textColor,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _controller, curve: Curves.easeOut));
    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(CurvedAnimation(
            parent: _controller, curve: Curves.easeOut));
    Future.delayed(
        Duration(milliseconds: 100 * widget.realIndex.clamp(0, 5)),
            () {
          if (mounted) _controller.forward();
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openDetail() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            ProjectDetailScreen(project: widget.project),
        transitionsBuilder: (_, animation, __, child) =>
            SlideTransition(
              position: Tween<Offset>(
                  begin: const Offset(1, 0), end: Offset.zero)
                  .animate(CurvedAnimation(
                  parent: animation, curve: Curves.easeOut)),
              child: child,
            ),
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  Future<void> _deleteProject() async {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;
    final cardColor = AppTheme.cardColor(isDark);
    final textColor = AppTheme.textColor(isDark);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Project?',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: textColor)),
        content: Text(
            'Remove "${widget.project['title']}"?\nThis cannot be undone.',
            style: GoogleFonts.poppins(
                color: AppTheme.textMuted, fontSize: 13)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('Cancel',
                style: GoogleFonts.poppins(
                    color: AppTheme.textMuted)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete',
                style: GoogleFonts.poppins(
                    color: AppTheme.error,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      await Provider.of<ProjectsProvider>(context,
          listen: false)
          .deleteProject(widget.realIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    // ✅ Safe cast — handles both List<String> and List<dynamic>
    final List<String> techs = (project['tech'] as List?)
        ?.map((e) => e.toString())
        .toList() ??
        [];

    // ✅ Safe color parse
    int colorValue = 0xFF6C63FF;
    try {
      final raw = project['color'];
      if (raw is int) colorValue = raw;
      if (raw is String) colorValue = int.parse(raw);
    } catch (_) {}
    final color = Color(colorValue);

    // ✅ Safe icon
    final icon = project['icon']?.toString() ?? '📱';

    // ✅ Safe title/category/description
    final title = project['title']?.toString() ?? 'Untitled';
    final category =
        project['category']?.toString() ?? 'Other';
    final description =
        project['description']?.toString() ?? '';

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) {
            setState(() => _pressed = false);
            _openDetail();
          },
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: widget.cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _pressed
                    ? color.withOpacity(0.6)
                    : widget.dividerColor,
              ),
              boxShadow: _pressed
                  ? [
                BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2)
              ]
                  : [],
            ),
            child: Column(
              children: [
                // Color top bar
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      color,
                      color.withOpacity(0.5)
                    ]),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(icon,
                              style: const TextStyle(
                                  fontSize: 28)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Title + Category
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: widget.textColor)),
                            const SizedBox(height: 4),
                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3),
                              decoration: BoxDecoration(
                                color:
                                color.withOpacity(0.12),
                                borderRadius:
                                BorderRadius.circular(6),
                              ),
                              child: Text(category,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: color,
                                      fontWeight:
                                      FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                      // Edit + Delete buttons
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditProjectScreen(
                                      existing: widget.project,
                                      index: widget.realIndex,
                                    ),
                              ),
                            ),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppTheme.accent
                                    .withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                  Icons.edit_rounded,
                                  color: AppTheme.accent,
                                  size: 14),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: _deleteProject,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppTheme.error
                                    .withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                  Icons.delete_rounded,
                                  color: AppTheme.error,
                                  size: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Description + Tech chips
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(description,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppTheme.textMuted,
                              height: 1.6),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 12),
                      Wrap(
                        children: techs
                            .map((t) => TechChip(label: t))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}