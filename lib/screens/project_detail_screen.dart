// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../theme/app_theme.dart';
// import '../widgets/common_widgets.dart';
//
// class ProjectDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> project;
//   const ProjectDetailScreen({super.key, required this.project});
//
//   @override
//   State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
// }
//
// class _ProjectDetailScreenState extends State<ProjectDetailScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnim;
//   late Animation<Offset> _slideAnim;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 600));
//     _fadeAnim = Tween<double>(begin: 0, end: 1)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//     _slideAnim = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   Future<void> _launchUrl(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final project = widget.project;
//     final color = Color(project['color'] as int);
//     final techs = project['tech'] as List<String>;
//     final hasFeatures = project.containsKey('features');
//     final hasFullDesc = project.containsKey('fullDescription');
//     final hasGithub = project.containsKey('github');
//     final textColor = AppTheme.textColor(isDark);
//     final textSub = AppTheme.textSubColor(isDark);
//     final cardColor = AppTheme.cardColor(isDark);
//     final dividerColor = AppTheme.dividerColor(isDark);
//
//     return Scaffold(
//       backgroundColor: isDark ? AppTheme.bgDark : AppTheme.lightBg,
//       body: CustomScrollView(
//         physics: const ClampingScrollPhysics(),
//         slivers: [
//           SliverAppBar(
//             expandedHeight: 220,
//             pinned: true,
//             backgroundColor: isDark ? AppTheme.bgDark : AppTheme.lightBg,
//             leading: GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: Container(
//                 margin: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.15),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(Icons.arrow_back_ios_new_rounded,
//                     color: color, size: 18),
//               ),
//             ),
//             flexibleSpace: FlexibleSpaceBar(
//               collapseMode: CollapseMode.pin,
//               background: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [color.withOpacity(0.3), color.withOpacity(0.05)],
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: -30,
//                       right: -30,
//                       child: Container(
//                         width: 180,
//                         height: 180,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: color.withOpacity(0.1),
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SizedBox(height: 40),
//                           Container(
//                             width: 90,
//                             height: 90,
//                             decoration: BoxDecoration(
//                               color: color.withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(24),
//                               border: Border.all(
//                                   color: color.withOpacity(0.3), width: 2),
//                             ),
//                             child: Center(
//                               child: Text(project['icon'],
//                                   style: const TextStyle(fontSize: 40)),
//                             ),
//                           ),
//                           const SizedBox(height: 14),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 5),
//                             decoration: BoxDecoration(
//                               color: color.withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(project['category'],
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     color: color,
//                                     fontWeight: FontWeight.w500)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: FadeTransition(
//               opacity: _fadeAnim,
//               child: SlideTransition(
//                 position: _slideAnim,
//                 child: Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(project['title'],
//                           style: GoogleFonts.poppins(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: textColor,
//                               height: 1.3)),
//                       const SizedBox(height: 16),
//                       Wrap(
//                           children:
//                           techs.map((t) => TechChip(label: t)).toList()),
//
//                       // Add project images if available
//                       if (project.containsKey('imagePaths') &&
//                           (project['imagePaths'] as List).isNotEmpty) ...[
//                         const SizedBox(height: 20),
//                         Container(
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: cardColor,
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(color: dividerColor),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(children: [
//                                 Icon(Icons.photo_library_outlined, color: color, size: 20),
//                                 const SizedBox(width: 8),
//                                 Text('Project Screenshots',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: textColor)),
//                               ]),
//                               const SizedBox(height: 14),
//                               SizedBox(
//                                 height: 180,
//                                 child: ListView.separated(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: (project['imagePaths'] as List).length,
//                                   separatorBuilder: (_, __) => const SizedBox(width: 10),
//                                   itemBuilder: (context, i) {
//                                     final path = (project['imagePaths'] as List)[i];
//                                     return ClipRRect(
//                                       borderRadius: BorderRadius.circular(12),
//                                       child: Image.file(
//                                         File(path),
//                                         width: 140,
//                                         height: 180,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//
//                       const SizedBox(height: 24),
//                       // About
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: cardColor,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: dividerColor),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(children: [
//                               Icon(Icons.description_outlined,
//                                   color: color, size: 20),
//                               const SizedBox(width: 8),
//                               Text('About this Project',
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: textColor)),
//                             ]),
//                             const SizedBox(height: 12),
//                             Text(
//                                 hasFullDesc
//                                     ? project['fullDescription']
//                                     : project['description'],
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 13.5,
//                                     color: textSub,
//                                     height: 1.8)),
//                           ],
//                         ),
//                       ),
//                       // Features (only if available)
//                       if (hasFeatures) ...[
//                         const SizedBox(height: 20),
//                         Container(
//                           padding: const EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             color: cardColor,
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(color: dividerColor),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(children: [
//                                 Icon(Icons.star_outline_rounded,
//                                     color: color, size: 20),
//                                 const SizedBox(width: 8),
//                                 Text('Key Features',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: textColor)),
//                               ]),
//                               const SizedBox(height: 16),
//                               ...List<String>.from(project['features']).map(
//                                       (f) => Padding(
//                                     padding:
//                                     const EdgeInsets.only(bottom: 12),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           width: 28,
//                                           height: 28,
//                                           decoration: BoxDecoration(
//                                             color: color.withOpacity(0.12),
//                                             shape: BoxShape.circle,
//                                           ),
//                                           child: Icon(Icons.check_rounded,
//                                               color: color, size: 16),
//                                         ),
//                                         const SizedBox(width: 12),
//                                         Expanded(
//                                           child: Text(f,
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 14,
//                                                   color: textSub)),
//                                         ),
//                                       ],
//                                     ),
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ],
//                       const SizedBox(height: 24),
//                       // GitHub Button (only if available)
//                       if (hasGithub)
//                         GestureDetector(
//                           onTap: () => _launchUrl(project['github']),
//                           child: Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   colors: [color, color.withOpacity(0.7)]),
//                               borderRadius: BorderRadius.circular(14),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: color.withOpacity(0.4),
//                                   blurRadius: 20,
//                                   offset: const Offset(0, 8),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(Icons.code_rounded,
//                                     color: Colors.white, size: 20),
//                                 const SizedBox(width: 8),
//                                 Text('View on GitHub',
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 15)),
//                               ],
//                             ),
//                           ),
//                         ),
//
//                       // Add after GitHub button
//                       if (project['liveLink'] != null &&
//                           project['liveLink'].toString().isNotEmpty) ...[
//                         const SizedBox(height: 12),
//                         GestureDetector(
//                           onTap: () => _launchUrl(project['liveLink']),
//                           child: Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             decoration: BoxDecoration(
//                               color: AppTheme.accentSecondary.withOpacity(0.15),
//                               borderRadius: BorderRadius.circular(14),
//                               border: Border.all(
//                                   color: AppTheme.accentSecondary.withOpacity(0.4)),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(Icons.open_in_new_rounded,
//                                     color: AppTheme.accentSecondary, size: 20),
//                                 const SizedBox(width: 8),
//                                 Text('View Live',
//                                     style: GoogleFonts.poppins(
//                                         color: AppTheme.accentSecondary,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 15)),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                       const SizedBox(height: 36),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class ProjectDetailScreen extends StatefulWidget {
  final Map<String, dynamic> project;
  const ProjectDetailScreen({super.key, required this.project});

  @override
  State<ProjectDetailScreen> createState() =>
      _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(CurvedAnimation(
            parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('launchUrl error: $e');
    }
  }

  // ✅ Safe color extraction
  Color _getColor() {
    try {
      final raw = widget.project['color'];
      if (raw is int) return Color(raw);
      if (raw is String) return Color(int.parse(raw));
    } catch (_) {}
    return AppTheme.accent;
  }

  // ✅ Safe list extraction
  List<String> _getList(String key) {
    try {
      final raw = widget.project[key];
      if (raw == null) return [];
      if (raw is List) return raw.map((e) => e.toString()).toList();
    } catch (_) {}
    return [];
  }

  // ✅ Safe string extraction
  String _getString(String key, [String fallback = '']) {
    try {
      return widget.project[key]?.toString() ?? fallback;
    } catch (_) {
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    final color = _getColor();
    final techs = _getList('tech');
    final features = _getList('features');
    final imagePaths = _getList('imagePaths');
    final textColor = AppTheme.textColor(isDark);
    final cardColor = AppTheme.cardColor(isDark);
    final dividerColor = AppTheme.dividerColor(isDark);

    final title = _getString('title', 'Project');
    final category = _getString('category', 'Other');
    final icon = _getString('icon', '📱');
    final github = _getString('github');
    final liveLink = _getString('liveLink');
    final fullDescription = _getString('fullDescription',
        _getString('description', 'No description available.'));

    return Scaffold(
      backgroundColor: AppTheme.bgColor(isDark),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          // ── Header ──
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppTheme.bgColor(isDark),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: color, size: 18),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.3),
                      color.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -30, right: -30,
                      child: Container(
                        width: 180, height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Container(
                            width: 90, height: 90,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              borderRadius:
                              BorderRadius.circular(24),
                              border: Border.all(
                                  color: color.withOpacity(0.3),
                                  width: 2),
                            ),
                            child: Center(
                              child: Text(icon,
                                  style: const TextStyle(
                                      fontSize: 40)),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.15),
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: Text(category,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: color,
                                    fontWeight:
                                    FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Content ──
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(title,
                          style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                              height: 1.3)),
                      const SizedBox(height: 16),

                      // Tech chips
                      if (techs.isNotEmpty)
                        Wrap(
                          children: techs
                              .map((t) => TechChip(label: t))
                              .toList(),
                        ),
                      const SizedBox(height: 24),

                      // About
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius:
                          BorderRadius.circular(16),
                          border:
                          Border.all(color: dividerColor),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(
                                  Icons.description_outlined,
                                  color: color, size: 20),
                              const SizedBox(width: 8),
                              Text('About this Project',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.w600,
                                      color: textColor)),
                            ]),
                            const SizedBox(height: 12),
                            Text(fullDescription,
                                style: GoogleFonts.poppins(
                                    fontSize: 13.5,
                                    color: AppTheme
                                        .textSubColor(isDark),
                                    height: 1.8)),
                          ],
                        ),
                      ),

                      // Features
                      if (features.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius:
                            BorderRadius.circular(16),
                            border: Border.all(
                                color: dividerColor),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(
                                    Icons.star_outline_rounded,
                                    color: color, size: 20),
                                const SizedBox(width: 8),
                                Text('Key Features',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: textColor)),
                              ]),
                              const SizedBox(height: 16),
                              ...features.map((f) =>
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        bottom: 12),
                                    child: Row(children: [
                                      Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: color
                                              .withOpacity(0.12),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                            Icons.check_rounded,
                                            color: color,
                                            size: 16),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(f,
                                            style: GoogleFonts
                                                .poppins(
                                                fontSize: 14,
                                                color: AppTheme
                                                    .textSubColor(
                                                    isDark))),
                                      ),
                                    ]),
                                  )),
                            ],
                          ),
                        ),
                      ],

                      // Images
                      if (imagePaths.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius:
                            BorderRadius.circular(16),
                            border: Border.all(
                                color: dividerColor),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Icon(
                                    Icons
                                        .photo_library_outlined,
                                    color: color, size: 20),
                                const SizedBox(width: 8),
                                Text('Screenshots',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w600,
                                        color: textColor)),
                              ]),
                              const SizedBox(height: 14),
                              SizedBox(
                                height: 180,
                                child: ListView.separated(
                                  scrollDirection:
                                  Axis.horizontal,
                                  itemCount: imagePaths.length,
                                  separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                                  itemBuilder: (ctx, i) {
                                    final path = imagePaths[i];
                                    return ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(
                                          12),
                                      child: File(path).existsSync()
                                          ? Image.file(
                                          File(path),
                                          width: 140,
                                          height: 180,
                                          fit: BoxFit.cover)
                                          : Container(
                                          width: 140,
                                          height: 180,
                                          color: color.withOpacity(0.1),
                                          child: Icon(Icons.image_outlined,
                                              color: color)),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // GitHub button
                      if (github.isNotEmpty)
                        GestureDetector(
                          onTap: () => _launchUrl(github),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                color,
                                color.withOpacity(0.7)
                              ]),
                              borderRadius:
                              BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.code_rounded,
                                    color: Colors.white,
                                    size: 20),
                                const SizedBox(width: 8),
                                Text('View on GitHub',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: 15)),
                              ],
                            ),
                          ),
                        ),

                      // Live link button
                      if (liveLink.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => _launchUrl(liveLink),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius:
                              BorderRadius.circular(14),
                              border: Border.all(
                                  color: color.withOpacity(0.4)),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(Icons.open_in_new_rounded,
                                    color: color, size: 20),
                                const SizedBox(width: 8),
                                Text('View Live Demo',
                                    style: GoogleFonts.poppins(
                                        color: color,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
