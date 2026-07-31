// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:provider/provider.dart';
// // import '../theme/app_theme.dart';
// // import '../providers/profile_provider.dart';
// // import '../widgets/common_widgets.dart';
// //
// // class EditProfileScreen extends StatefulWidget {
// //   const EditProfileScreen({super.key});
// //
// //   @override
// //   State<EditProfileScreen> createState() => _EditProfileScreenState();
// // }
// //
// // class _EditProfileScreenState extends State<EditProfileScreen>
// //     with SingleTickerProviderStateMixin {
// //   late TabController _tabController;
// //
// //   late TextEditingController _nameController;
// //   late TextEditingController _titleController;
// //   late TextEditingController _subtitleController;
// //   late TextEditingController _aboutController;
// //   late TextEditingController _locationController;
// //   late TextEditingController _educationController;
// //   late TextEditingController _emailController;
// //   late TextEditingController _phoneController;
// //   late TextEditingController _githubController;
// //   late TextEditingController _linkedinController;
// //   late TextEditingController _portfolioController;
// //
// //   bool _isSaving = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 2, vsync: this);
// //     final profile = Provider.of<ProfileProvider>(context, listen: false);
// //     _nameController = TextEditingController(text: profile.name);
// //     _titleController = TextEditingController(text: profile.title);
// //     _subtitleController = TextEditingController(text: profile.subtitle);
// //     _aboutController = TextEditingController(text: profile.about);
// //     _locationController = TextEditingController(text: profile.location);
// //     _educationController = TextEditingController(text: profile.education);
// //     _emailController = TextEditingController(text: profile.email);
// //     _phoneController = TextEditingController(text: profile.phone);
// //     _githubController = TextEditingController(text: profile.github);
// //     _linkedinController = TextEditingController(text: profile.linkedin);
// //     _portfolioController = TextEditingController(text: profile.portfolio);
// //   }
// //
// //   @override
// //   void dispose() {
// //     _tabController.dispose();
// //     _nameController.dispose();
// //     _titleController.dispose();
// //     _subtitleController.dispose();
// //     _aboutController.dispose();
// //     _locationController.dispose();
// //     _educationController.dispose();
// //     _emailController.dispose();
// //     _phoneController.dispose();
// //     _githubController.dispose();
// //     _linkedinController.dispose();
// //     _portfolioController.dispose();
// //     super.dispose();
// //   }
// //
// //   Future<void> _savePersonal() async {
// //     setState(() => _isSaving = true);
// //     await Provider.of<ProfileProvider>(context, listen: false).updateProfile(
// //       name: _nameController.text.trim(),
// //       title: _titleController.text.trim(),
// //       subtitle: _subtitleController.text.trim(),
// //       about: _aboutController.text.trim(),
// //       location: _locationController.text.trim(),
// //       education: _educationController.text.trim(),
// //     );
// //     setState(() => _isSaving = false);
// //     if (mounted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Personal info saved! ✅',
// //               style: GoogleFonts.poppins(fontSize: 13)),
// //           backgroundColor: AppTheme.success,
// //           behavior: SnackBarBehavior.floating,
// //           shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10)),
// //         ),
// //       );
// //     }
// //   }
// //
// //   Future<void> _saveContact() async {
// //     setState(() => _isSaving = true);
// //     await Provider.of<ProfileProvider>(context, listen: false).updateContact(
// //       email: _emailController.text.trim(),
// //       phone: _phoneController.text.trim(),
// //       github: _githubController.text.trim(),
// //       linkedin: _linkedinController.text.trim(),
// //       portfolio: _portfolioController.text.trim(),
// //     );
// //     setState(() => _isSaving = false);
// //     if (mounted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Contact info saved! ✅',
// //               style: GoogleFonts.poppins(fontSize: 13)),
// //           backgroundColor: AppTheme.success,
// //           behavior: SnackBarBehavior.floating,
// //           shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10)),
// //         ),
// //       );
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final isDark = Theme.of(context).brightness == Brightness.dark;
// //     final textColor = AppTheme.textColor(isDark);
// //
// //     return Scaffold(
// //       backgroundColor: AppTheme.bgColor(isDark),
// //       appBar: AppBar(
// //         backgroundColor: AppTheme.bgColor(isDark),
// //         title: Text(
// //           'Edit Profile',
// //           style: GoogleFonts.poppins(
// //               fontWeight: FontWeight.w600,
// //               fontSize: 18,
// //               color: textColor),
// //         ),
// //         centerTitle: false,
// //         leading: GestureDetector(
// //           onTap: () => Navigator.pop(context),
// //           child: Container(
// //             margin: const EdgeInsets.all(8),
// //             decoration: BoxDecoration(
// //               color: AppTheme.accent.withOpacity(0.1),
// //               shape: BoxShape.circle,
// //             ),
// //             child: const Icon(
// //               Icons.arrow_back_ios_new_rounded,
// //               size: 18,
// //               color: AppTheme.accent,
// //             ),
// //           ),
// //         ),
// //         bottom: TabBar(
// //           controller: _tabController,
// //           indicatorColor: AppTheme.accent,
// //           indicatorWeight: 3,
// //           labelColor: AppTheme.accent,
// //           unselectedLabelColor: AppTheme.textMuted,
// //           labelStyle: GoogleFonts.poppins(
// //               fontWeight: FontWeight.w600, fontSize: 13),
// //           unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
// //           tabs: const [
// //             Tab(text: 'Personal Info'),
// //             Tab(text: 'Contact Info'),
// //           ],
// //         ),
// //       ),
// //       body: TabBarView(
// //         controller: _tabController,
// //         children: [
// //           // ── Personal Info Tab ──
// //           SingleChildScrollView(
// //             padding: const EdgeInsets.all(24),
// //             physics: const ClampingScrollPhysics(),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const SizedBox(height: 8),
// //                 _buildField(
// //                   label: 'Full Name',
// //                   controller: _nameController,
// //                   isDark: isDark,
// //                   icon: Icons.person_outline_rounded,
// //                 ),
// //                 _buildField(
// //                   label: 'Professional Title',
// //                   controller: _titleController,
// //                   isDark: isDark,
// //                   icon: Icons.work_outline_rounded,
// //                 ),
// //                 _buildField(
// //                   label: 'Subtitle',
// //                   controller: _subtitleController,
// //                   isDark: isDark,
// //                   icon: Icons.text_fields_rounded,  // ✅ fixed icon
// //                 ),
// //                 _buildField(
// //                   label: 'Location',
// //                   controller: _locationController,
// //                   isDark: isDark,
// //                   icon: Icons.location_on_outlined,
// //                 ),
// //                 _buildField(
// //                   label: 'Education',
// //                   controller: _educationController,
// //                   isDark: isDark,
// //                   icon: Icons.school_outlined,
// //                 ),
// //                 _buildField(
// //                   label: 'About Me',
// //                   controller: _aboutController,
// //                   isDark: isDark,
// //                   icon: Icons.info_outline_rounded,
// //                   maxLines: 5,
// //                 ),
// //                 // _buildField(
// //                 //   label: 'About Me',
// //                 //   controller: _aboutController,
// //                 //   isDark: isDark,
// //                 //   icon: Icons.info_outline_rounded,
// //                 //   maxLines: 5,
// //                 // ),
// //                 const SizedBox(height: 24),
// //                 _isSaving
// //                     ? const Center(
// //                     child: CircularProgressIndicator(
// //                         color: AppTheme.accent))
// //                     : GradientButton(
// //                   text: 'Save Personal Info',
// //                   //icon: Icons.save_rounded,
// //                   onTap: _savePersonal,
// //                 ),
// //                 const SizedBox(height: 32),
// //               ],
// //             ),
// //           ),
// //
// //           // ── Contact Info Tab ──
// //           SingleChildScrollView(
// //             padding: const EdgeInsets.all(24),
// //             physics: const ClampingScrollPhysics(),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const SizedBox(height: 8),
// //                 _buildField(
// //                   label: 'Email',
// //                   controller: _emailController,
// //                   isDark: isDark,
// //                   icon: Icons.email_outlined,
// //                   keyboard: TextInputType.emailAddress,
// //                 ),
// //                 _buildField(
// //                   label: 'Phone',
// //                   controller: _phoneController,
// //                   isDark: isDark,
// //                   icon: Icons.phone_outlined,
// //                   keyboard: TextInputType.phone,
// //                 ),
// //                 _buildField(
// //                   label: 'GitHub URL',
// //                   controller: _githubController,
// //                   isDark: isDark,
// //                   icon: Icons.code_rounded,
// //                   keyboard: TextInputType.url,
// //                 ),
// //                 _buildField(
// //                   label: 'LinkedIn URL',
// //                   controller: _linkedinController,
// //                   isDark: isDark,
// //                   icon: Icons.link_rounded,
// //                   keyboard: TextInputType.url,
// //                 ),
// //                 _buildField(
// //                   label: 'Portfolio URL',
// //                   controller: _portfolioController,
// //                   isDark: isDark,
// //                   icon: Icons.language_rounded,
// //                   keyboard: TextInputType.url,
// //                 ),
// //                 const SizedBox(height: 24),
// //                 _isSaving
// //                     ? const Center(
// //                     child: CircularProgressIndicator(
// //                         color: AppTheme.accent))
// //                     : GradientButton(
// //                   text: 'Save Contact Info',
// //                   //icon: Icons.save_rounded,
// //                   onTap: _saveContact,
// //                 ),
// //                 const SizedBox(height: 32),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildField({
// //     required String label,
// //     required TextEditingController controller,
// //     required bool isDark,
// //     required IconData icon,
// //     int maxLines = 1,
// //     TextInputType keyboard = TextInputType.text,
// //   }) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 18),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             label,
// //             style: GoogleFonts.poppins(
// //               fontSize: 12,
// //               color: AppTheme.textMuted,
// //               fontWeight: FontWeight.w500,
// //             ),
// //           ),
// //           const SizedBox(height: 6),
// //           TextFormField(
// //             controller: controller,
// //             maxLines: maxLines,
// //             keyboardType: keyboard,
// //             style: GoogleFonts.poppins(
// //               color: AppTheme.textColor(isDark),
// //               fontSize: 14,
// //             ),
// //             decoration: InputDecoration(
// //               prefixIcon: maxLines == 1
// //                   ? Icon(icon, size: 18, color: AppTheme.textMuted)
// //                   : null,
// //               hintText: 'Enter $label',
// //               hintStyle: GoogleFonts.poppins(
// //                   fontSize: 13, color: AppTheme.textMuted),
// //               contentPadding: EdgeInsets.symmetric(
// //                 horizontal: maxLines > 1 ? 16 : 0,
// //                 vertical: maxLines > 1 ? 14 : 0,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import '../theme/app_theme.dart';
// import '../providers/profile_provider.dart';
// import '../widgets/common_widgets.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   final int initialTab;
//   const EditProfileScreen({super.key, this.initialTab=0});
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   late TextEditingController _nameController;
//   late TextEditingController _titleController;
//   late TextEditingController _subtitleController;
//   late TextEditingController _aboutController;
//   late TextEditingController _locationController;
//   late TextEditingController _educationController;
//   late TextEditingController _emailController;
//   late TextEditingController _phoneController;
//   late TextEditingController _githubController;
//   late TextEditingController _linkedinController;
//   late TextEditingController _portfolioController;
//
//   bool _isSaving = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialTab);
//     final profile =
//     Provider.of<ProfileProvider>(context, listen: false);
//     _nameController = TextEditingController(text: profile.name);
//     _titleController = TextEditingController(text: profile.title);
//     _subtitleController =
//         TextEditingController(text: profile.subtitle);
//     _aboutController = TextEditingController(text: profile.about);
//     _locationController =
//         TextEditingController(text: profile.location);
//     _educationController =
//         TextEditingController(text: profile.education);
//     _emailController = TextEditingController(text: profile.email);
//     _phoneController = TextEditingController(text: profile.phone);
//     _githubController = TextEditingController(text: profile.github);
//     _linkedinController =
//         TextEditingController(text: profile.linkedin);
//     _portfolioController =
//         TextEditingController(text: profile.portfolio);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _nameController.dispose();
//     _titleController.dispose();
//     _subtitleController.dispose();
//     _aboutController.dispose();
//     _locationController.dispose();
//     _educationController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _githubController.dispose();
//     _linkedinController.dispose();
//     _portfolioController.dispose();
//     super.dispose();
//   }
//
//   void _showSnack(String msg, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content:
//       Text(msg, style: GoogleFonts.poppins(fontSize: 13)),
//       backgroundColor:
//       isError ? AppTheme.error : AppTheme.success,
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10)),
//     ));
//   }
//
//   Future<void> _savePersonal() async {
//     setState(() => _isSaving = true);
//     await Provider.of<ProfileProvider>(context, listen: false)
//         .updateProfile(
//       name: _nameController.text.trim(),
//       title: _titleController.text.trim(),
//       subtitle: _subtitleController.text.trim(),
//       about: _aboutController.text.trim(),
//       location: _locationController.text.trim(),
//       education: _educationController.text.trim(),
//     );
//     setState(() => _isSaving = false);
//     _showSnack('Personal info saved! ✅');
//   }
//
//   Future<void> _saveContact() async {
//     setState(() => _isSaving = true);
//     await Provider.of<ProfileProvider>(context, listen: false)
//         .updateContact(
//       email: _emailController.text.trim(),
//       phone: _phoneController.text.trim(),
//       github: _githubController.text.trim(),
//       linkedin: _linkedinController.text.trim(),
//       portfolio: _portfolioController.text.trim(),
//     );
//     setState(() => _isSaving = false);
//     _showSnack('Contact info saved! ✅');
//   }
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final picked =
//     await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       await Provider.of<ProfileProvider>(context, listen: false)
//           .updateProfileImage(picked.path);
//       _showSnack('Profile image updated! ✅');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final textColor = AppTheme.textColor(isDark);
//
//     return Scaffold(
//       backgroundColor: AppTheme.bgColor(isDark),
//       appBar: AppBar(
//         backgroundColor: AppTheme.bgColor(isDark),
//         title: Text('Edit Profile',
//             style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18,
//                 color: textColor)),
//         centerTitle: false,
//         leading: GestureDetector(
//           onTap: () => Navigator.pop(context),
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppTheme.accent.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(Icons.arrow_back_ios_new_rounded,
//                 size: 18, color: AppTheme.accent),
//           ),
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: AppTheme.accent,
//           indicatorWeight: 3,
//           labelColor: AppTheme.accent,
//           unselectedLabelColor: AppTheme.textMuted,
//           isScrollable: true,
//           labelStyle: GoogleFonts.poppins(
//               fontWeight: FontWeight.w600, fontSize: 13),
//           unselectedLabelStyle:
//           GoogleFonts.poppins(fontSize: 13),
//           tabs: const [
//             Tab(text: 'Personal'),
//             Tab(text: 'Contact'),
//             Tab(text: 'Skills'),
//             Tab(text: 'Experience'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _PersonalTab(
//             nameController: _nameController,
//             titleController: _titleController,
//             subtitleController: _subtitleController,
//             aboutController: _aboutController,
//             locationController: _locationController,
//             educationController: _educationController,
//             isSaving: _isSaving,
//             onSave: _savePersonal,
//             onPickImage: _pickImage,
//             isDark: isDark,
//           ),
//           _ContactTab(
//             emailController: _emailController,
//             phoneController: _phoneController,
//             githubController: _githubController,
//             linkedinController: _linkedinController,
//             portfolioController: _portfolioController,
//             isSaving: _isSaving,
//             onSave: _saveContact,
//             isDark: isDark,
//           ),
//           _SkillsTab(isDark: isDark),
//           _ExperienceTab(isDark: isDark),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Personal Tab ──
// class _PersonalTab extends StatelessWidget {
//   final TextEditingController nameController,
//       titleController,
//       subtitleController,
//       aboutController,
//       locationController,
//       educationController;
//   final bool isSaving, isDark;
//   final VoidCallback onSave, onPickImage;
//
//   const _PersonalTab({
//     required this.nameController,
//     required this.titleController,
//     required this.subtitleController,
//     required this.aboutController,
//     required this.locationController,
//     required this.educationController,
//     required this.isSaving,
//     required this.isDark,
//     required this.onSave,
//     required this.onPickImage,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final profile = Provider.of<ProfileProvider>(context);
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       physics: const ClampingScrollPhysics(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 8),
//           // Profile image picker
//           Center(
//             child: GestureDetector(
//               onTap: onPickImage,
//               child: Stack(
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       gradient: const LinearGradient(
//                         colors: [
//                           AppTheme.accent,
//                           AppTheme.accentSecondary
//                         ],
//                       ),
//                     ),
//                     child: ClipOval(
//                       child: profile.profileImagePath.isNotEmpty
//                           ? Image.file(
//                           File(profile.profileImagePath),
//                           fit: BoxFit.cover)
//                           : Image.asset(
//                           'assets/icon/profile_icon.png',
//                           fit: BoxFit.cover),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       width: 30,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: AppTheme.accent,
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                             color: Colors.white, width: 2),
//                       ),
//                       child: const Icon(Icons.camera_alt_rounded,
//                           color: Colors.white, size: 14),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Center(
//             child: Text('Tap to change photo',
//                 style: GoogleFonts.poppins(
//                     fontSize: 12, color: AppTheme.textMuted)),
//           ),
//           const SizedBox(height: 24),
//           _Field(label: 'Full Name', controller: nameController,
//               icon: Icons.person_outline_rounded, isDark: isDark),
//           _Field(label: 'Professional Title', controller: titleController,
//               icon: Icons.work_outline_rounded, isDark: isDark),
//           _Field(label: 'Subtitle', controller: subtitleController,
//               icon: Icons.text_fields_rounded, isDark: isDark),
//           _Field(label: 'Location', controller: locationController,
//               icon: Icons.location_on_outlined, isDark: isDark),
//           _Field(label: 'Education', controller: educationController,
//               icon: Icons.school_outlined, isDark: isDark),
//           _Field(label: 'About Me', controller: aboutController,
//               icon: Icons.info_outline_rounded,
//               isDark: isDark, maxLines: 5),
//           const SizedBox(height: 24),
//           isSaving
//               ? const Center(child: CircularProgressIndicator(color: AppTheme.accent))
//               : GradientButton(text: 'Save Personal Info',
//               //icon: Icons.save_rounded,
//               onTap: onSave),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Contact Tab ──
// class _ContactTab extends StatelessWidget {
//   final TextEditingController emailController,
//       phoneController,
//       githubController,
//       linkedinController,
//       portfolioController;
//   final bool isSaving, isDark;
//   final VoidCallback onSave;
//
//   const _ContactTab({
//     required this.emailController,
//     required this.phoneController,
//     required this.githubController,
//     required this.linkedinController,
//     required this.portfolioController,
//     required this.isSaving,
//     required this.isDark,
//     required this.onSave,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       physics: const ClampingScrollPhysics(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 8),
//           _Field(label: 'Email', controller: emailController,
//               icon: Icons.email_outlined, isDark: isDark,
//               keyboard: TextInputType.emailAddress),
//           _Field(label: 'Phone', controller: phoneController,
//               icon: Icons.phone_outlined, isDark: isDark,
//               keyboard: TextInputType.phone),
//           _Field(label: 'GitHub URL', controller: githubController,
//               icon: Icons.code_rounded, isDark: isDark,
//               keyboard: TextInputType.url),
//           _Field(label: 'LinkedIn URL', controller: linkedinController,
//               icon: Icons.link_rounded, isDark: isDark,
//               keyboard: TextInputType.url),
//           _Field(label: 'Portfolio URL', controller: portfolioController,
//               icon: Icons.language_rounded, isDark: isDark,
//               keyboard: TextInputType.url),
//           const SizedBox(height: 24),
//           isSaving
//               ? const Center(child: CircularProgressIndicator(color: AppTheme.accent))
//               : GradientButton(text: 'Save Contact Info',
//               //icon: Icons.save_rounded,
//                onTap: onSave),
//           const SizedBox(height: 32),
//         ],
//       ),
//     );
//   }
// }
//
// // ── Skills Tab ──
// class _SkillsTab extends StatelessWidget {
//   final bool isDark;
//   const _SkillsTab({required this.isDark});
//
//   void _showSkillDialog(BuildContext context,
//       {Map<String, dynamic>? existing, int? index}) {
//     final nameCtrl =
//     TextEditingController(text: existing?['name'] ?? '');
//     // final iconCtrl =
//     // TextEditingController(text: existing?['icon'] ?? '');
//     double level = existing?['level'] ?? 0.5;
//
//     showDialog(
//       context: context,
//       builder: (ctx) => StatefulBuilder(
//         builder: (ctx, setS) => AlertDialog(
//           backgroundColor:
//           AppTheme.cardColor(isDark),
//           title: Text(
//               existing == null ? 'Add Skill' : 'Edit Skill',
//               style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.w600,
//                   color: AppTheme.textColor(isDark))),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _DialogField('Skill Name', nameCtrl, isDark),
//               const SizedBox(height: 12),
//               //_DialogField('Icon (emoji)', iconCtrl, isDark),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Level',
//                       style: GoogleFonts.poppins(
//                           fontSize: 13,
//                           color: AppTheme.textMuted)),
//                   Text('${(level * 100).toInt()}%',
//                       style: GoogleFonts.poppins(
//                           fontSize: 13,
//                           color: AppTheme.accent,
//                           fontWeight: FontWeight.w600)),
//                 ],
//               ),
//               Slider(
//                 value: level,
//                 min: 0.1,
//                 max: 1.0,
//                 divisions: 18,
//                 activeColor: AppTheme.accent,
//                 inactiveColor:
//                 AppTheme.accent.withOpacity(0.2),
//                 onChanged: (v) => setS(() => level = v),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(ctx),
//               child: Text('Cancel',
//                   style: GoogleFonts.poppins(
//                       color: AppTheme.textMuted)),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: AppTheme.accent),
//               onPressed: () async {
//                 if (nameCtrl.text.trim().isEmpty) return;
//                 final skill = {
//                   'name': nameCtrl.text.trim(),
//                   // 'icon': iconCtrl.text.trim().isEmpty
//                   //     ? '⭐'
//                   //     : iconCtrl.text.trim(),
//                   'level': level,
//                 };
//                 final provider = Provider.of<ProfileProvider>(
//                     context,
//                     listen: false);
//                 if (index == null) {
//                   await provider.addSkill(skill);
//                 } else {
//                   await provider.updateSkill(index, skill);
//                 }
//                 if (ctx.mounted) Navigator.pop(ctx);
//               },
//               child: Text('Save',
//                   style: GoogleFonts.poppins(
//                       color: Colors.white)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final profile = Provider.of<ProfileProvider>(context);
//     final cardColor = AppTheme.cardColor(isDark);
//     final dividerColor = AppTheme.dividerColor(isDark);
//     final textColor = AppTheme.textColor(isDark);
//
//     return Column(
//         children: [
//     Padding(
//     padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
//     child: Row(
//     mainAxisAlignment:
//     MainAxisAlignment.spaceBetween,
//     children: [
//     Text('${profile.skills.length} Skills',
//     style: GoogleFonts.poppins(
//     fontSize: 14,
//     color: AppTheme.textMuted)),
//     GestureDetector(
//     onTap: () => _showSkillDialog(context),
//     child: Container(
//     padding: const EdgeInsets.symmetric(
//     horizontal: 16, vertical: 8),
//     decoration: BoxDecoration(
//     gradient: const LinearGradient(
//     colors: [
//     AppTheme.accent,
//     Color(0xFF8B83FF)
//     ]),
//     borderRadius: BorderRadius.circular(20),
//     ),
//     child: Row(
//     children: [
//     const Icon(Icons.add_rounded,
//     color: Colors.white, size: 16),
//     const SizedBox(width: 4),
//     Text('Add Skill',
//     style: GoogleFonts.poppins(
//     fontSize: 12,
//     color: Colors.white,
//     fontWeight: FontWeight.w600)),
//     ],
//     ),
//     ),
//     ),
//     ],
//     ),
//     ),
//     Expanded(
//     child: profile.skills.isEmpty
//     ? Center(
//     child: Text('No skills yet. Tap + to add.',
//     style: GoogleFonts.poppins(
//     color: AppTheme.textMuted)))
//         : ReorderableListView.builder(
//     padding:
//     const EdgeInsets.fromLTRB(24, 0, 24, 24),
//     itemCount: profile.skills.length,
//     onReorder: (oldIndex, newIndex) =>
//     Provider.of<ProfileProvider>(context,
//     listen: false)
//         .reorderSkills(oldIndex, newIndex),
//     itemBuilder: (context, index) {
//     final skill = profile.skills[index];
//     final level =
//     (skill['level'] as num).toDouble();
//     return Container(
//     key: ValueKey(index),
//     margin:
//     const EdgeInsets.only(bottom: 10),
//     padding: const EdgeInsets.symmetric(
//     horizontal: 16, vertical: 14),
//     decoration: BoxDecoration(
//     color: cardColor,
//     borderRadius:
//     BorderRadius.circular(12),
//       border:
//       Border.all(color: dividerColor),
//     ),
//       child: Row(
//         children: [
//           // Text(skill['icon'],
//           //     style: const TextStyle(
//           //         fontSize: 22)),
//           // const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment:
//               CrossAxisAlignment.start,
//               children: [
//                 Text(skill['name'],
//                     style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight:
//                         FontWeight.w600,
//                         color: textColor)),
//                 const SizedBox(height: 6),
//                 ClipRRect(
//                   borderRadius:
//                   BorderRadius.circular(3),
//                   child:
//                   LinearProgressIndicator(
//                     value: level,
//                     minHeight: 5,
//                     backgroundColor: AppTheme
//                         .accent
//                         .withOpacity(0.15),
//                     valueColor:
//                     const AlwaysStoppedAnimation(
//                         AppTheme.accent),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                     '${(level * 100).toInt()}%',
//                     style: GoogleFonts.poppins(
//                         fontSize: 11,
//                         color: AppTheme.accent,
//                         fontWeight:
//                         FontWeight.w500)),
//               ],
//             ),
//           ),
//           const SizedBox(width: 8),
//           IconButton(
//             icon: const Icon(
//                 Icons.edit_rounded,
//                 color: AppTheme.accent,
//                 size: 18),
//             onPressed: () => _showSkillDialog(
//                 context,
//                 existing: skill,
//                 index: index),
//           ),
//           IconButton(
//             icon: Icon(Icons.delete_rounded,
//                 color: AppTheme.error,
//                 size: 18),
//             onPressed: () async {
//               final confirm =
//               await showDialog<bool>(
//                 context: context,
//                 builder: (ctx) => AlertDialog(
//                   backgroundColor:
//                   cardColor,
//                   title: Text(
//                       'Delete Skill?',
//                       style:
//                       GoogleFonts.poppins(
//                           color:
//                           textColor)),
//                   content: Text(
//                       'Remove "${skill['name']}"?',
//                       style:
//                       GoogleFonts.poppins(
//                           color: AppTheme
//                               .textMuted)),
//                   actions: [
//                     TextButton(
//                         onPressed: () =>
//                             Navigator.pop(
//                                 ctx, false),
//                         child: Text('Cancel',
//                             style: GoogleFonts
//                                 .poppins(
//                                 color: AppTheme
//                                     .textMuted))),
//                     TextButton(
//                         onPressed: () =>
//                             Navigator.pop(
//                                 ctx, true),
//                         child: Text('Delete',
//                             style: GoogleFonts
//                                 .poppins(
//                                 color: AppTheme
//                                     .error))),
//                   ],
//                 ),
//               );
//               if (confirm == true) {
//                 await Provider.of<
//                     ProfileProvider>(
//                     context,
//                     listen: false)
//                     .deleteSkill(index);
//               }
//             },
//           ),
//           const Icon(Icons.drag_handle_rounded,
//               color: AppTheme.textMuted,
//               size: 18),
//         ],
//       ),
//     );
//     },
//     ),
//     ),
//         ],
//     );
//   }
// }
//
// // ── Experience Tab ──
// class _ExperienceTab extends StatelessWidget {
//   final bool isDark;
//   const _ExperienceTab({required this.isDark});
//
//   void _showExpDialog(BuildContext context,
//       {Map<String, String>? existing, int? index}) {
//     final roleCtrl =
//     TextEditingController(text: existing?['role'] ?? '');
//     final companyCtrl =
//     TextEditingController(text: existing?['company'] ?? '');
//     final durationCtrl =
//     TextEditingController(text: existing?['duration'] ?? '');
//     final descCtrl =
//     TextEditingController(text: existing?['description'] ?? '');
//
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         backgroundColor: AppTheme.cardColor(isDark),
//         title: Text(
//             existing == null
//                 ? 'Add Experience'
//                 : 'Edit Experience',
//             style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.w600,
//                 color: AppTheme.textColor(isDark))),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _DialogField('Job Title / Role', roleCtrl, isDark),
//               const SizedBox(height: 12),
//               _DialogField('Company Name', companyCtrl, isDark),
//               const SizedBox(height: 12),
//               _DialogField('Duration (e.g. 2024 - Present)',
//                   durationCtrl, isDark),
//               const SizedBox(height: 12),
//               _DialogField('Description', descCtrl, isDark,
//                   maxLines: 3),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(ctx),
//             child: Text('Cancel',
//                 style: GoogleFonts.poppins(
//                     color: AppTheme.textMuted)),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: AppTheme.accent),
//             onPressed: () async {
//               if (roleCtrl.text.trim().isEmpty ||
//                   companyCtrl.text.trim().isEmpty) return;
//               final exp = {
//                 'role': roleCtrl.text.trim(),
//                 'company': companyCtrl.text.trim(),
//                 'duration': durationCtrl.text.trim(),
//                 'description': descCtrl.text.trim(),
//               };
//               final provider = Provider.of<ProfileProvider>(
//                   context,
//                   listen: false);
//               if (index == null) {
//                 await provider.addExperience(exp);
//               } else {
//                 await provider.updateExperience(index, exp);
//               }
//               if (ctx.mounted) Navigator.pop(ctx);
//             },
//             child: Text('Save',
//                 style:
//                 GoogleFonts.poppins(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final profile = Provider.of<ProfileProvider>(context);
//     final cardColor = AppTheme.cardColor(isDark);
//     final dividerColor = AppTheme.dividerColor(isDark);
//     final textColor = AppTheme.textColor(isDark);
//
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
//           child: Row(
//             mainAxisAlignment:
//             MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                   '${profile.experience.length} Experience(s)',
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: AppTheme.textMuted)),
//               GestureDetector(
//                 onTap: () => _showExpDialog(context),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                         colors: [
//                           AppTheme.accent,
//                           Color(0xFF8B83FF)
//                         ]),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.add_rounded,
//                           color: Colors.white, size: 16),
//                       const SizedBox(width: 4),
//                       Text('Add',
//                           style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: profile.experience.isEmpty
//               ? Center(
//               child: Text(
//                   'No experience yet. Tap + to add.',
//                   style: GoogleFonts.poppins(
//                       color: AppTheme.textMuted)))
//               : ListView.builder(
//             padding:
//             const EdgeInsets.fromLTRB(24, 0, 24, 24),
//             physics: const ClampingScrollPhysics(),
//             itemCount: profile.experience.length,
//             itemBuilder: (context, index) {
//               final exp = profile.experience[index];
//               return Container(
//                 margin:
//                 const EdgeInsets.only(bottom: 12),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: cardColor,
//                   borderRadius:
//                   BorderRadius.circular(14),
//                   border:
//                   Border.all(color: dividerColor),
//                 ),
//                 child: Row(
//                   crossAxisAlignment:
//                   CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 42,
//                       height: 42,
//                       decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             colors: [
//                               AppTheme.accent,
//                               AppTheme.accentSecondary
//                             ]),
//                         borderRadius:
//                         BorderRadius.circular(10),
//                       ),
//                       child: const Icon(
//                           Icons.business_center_rounded,
//                           color: Colors.white,
//                           size: 20),
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                         children: [
//                           Text(exp['role'] ?? '',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14,
//                                   fontWeight:
//                                   FontWeight.w600,
//                                   color: textColor)),
//                           Text(exp['company'] ?? '',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 12,
//                                   color: AppTheme.accent,
//                                   fontWeight:
//                                   FontWeight.w500)),
//                           Text(exp['duration'] ?? '',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 11,
//                                   color: AppTheme
//                                       .textMuted)),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                           Icons.edit_rounded,
//                           color: AppTheme.accent,
//                           size: 18),
//                       onPressed: () => _showExpDialog(
//                           context,
//                           existing: exp,
//                           index: index),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete_rounded,
//                           color: AppTheme.error,
//                           size: 18),
//                       onPressed: () async {
//                         final confirm =
//                         await showDialog<bool>(
//                           context: context,
//                           builder: (ctx) => AlertDialog(
//                             backgroundColor: cardColor,
//                             title: Text(
//                                 'Delete Experience?',
//                                 style:
//                                 GoogleFonts.poppins(
//                                     color:
//                                     textColor)),
//                             content: Text(
//                                 'Remove "${exp['role']}"?',
//                                 style:
//                                 GoogleFonts.poppins(
//                                     color: AppTheme
//                                         .textMuted)),
//                             actions: [
//                               TextButton(
//                                   onPressed: () =>
//                                       Navigator.pop(
//                                           ctx, false),
//                                   child: Text('Cancel',
//                                       style: GoogleFonts
//                                           .poppins(
//                                           color: AppTheme
//                                               .textMuted))),
//                               TextButton(
//                                   onPressed: () =>
//                                       Navigator.pop(
//                                           ctx, true),
//                                   child: Text('Delete',
//                                       style: GoogleFonts
//                                           .poppins(
//                                           color: AppTheme
//                                               .error))),
//                             ],
//                           ),
//                         );
//                         if (confirm == true) {
//                           await Provider.of<
//                               ProfileProvider>(
//                               context,
//                               listen: false)
//                               .deleteExperience(index);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ── Shared dialog field ──
// class _DialogField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final bool isDark;
//   final int maxLines;
//   const _DialogField(this.label, this.controller, this.isDark,
//       {this.maxLines = 1});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       maxLines: maxLines,
//       style: GoogleFonts.poppins(
//           color: AppTheme.textColor(isDark), fontSize: 13),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle:
//         GoogleFonts.poppins(color: AppTheme.textMuted, fontSize: 12),
//         contentPadding:
//         const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//                 color: AppTheme.dividerColor(isDark))),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(
//                 color: AppTheme.dividerColor(isDark))),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(
//                 color: AppTheme.accent, width: 2)),
//       ),
//     );
//   }
// }
//
// // ── Shared text field ──
// class _Field extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final IconData icon;
//   final bool isDark;
//   final int maxLines;
//   final TextInputType keyboard;
//   const _Field({
//     required this.label,
//     required this.controller,
//     required this.icon,
//     required this.isDark,
//     this.maxLines = 1,
//     this.keyboard = TextInputType.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label,
//               style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: AppTheme.textMuted,
//                   fontWeight: FontWeight.w500)),
//           const SizedBox(height: 6),
//           TextFormField(
//             controller: controller,
//             maxLines: maxLines,
//             keyboardType: keyboard,
//             style: GoogleFonts.poppins(
//                 color: AppTheme.textColor(isDark), fontSize: 14),
//             decoration: InputDecoration(
//               prefixIcon: maxLines == 1
//                   ? Icon(icon, size: 18, color: AppTheme.textMuted)
//                   : null,
//               hintText: 'Enter $label',
//               hintStyle: GoogleFonts.poppins(
//                   fontSize: 13, color: AppTheme.textMuted),
//               contentPadding: EdgeInsets.symmetric(
//                 horizontal: maxLines > 1 ? 16 : 0,
//                 vertical: maxLines > 1 ? 14 : 0,
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
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../providers/profile_provider.dart';
import '../widgets/common_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late TextEditingController _nameCtrl;
  late TextEditingController _titleCtrl;
  late TextEditingController _subtitleCtrl;
  late TextEditingController _aboutCtrl;
  late TextEditingController _locationCtrl;
  late TextEditingController _educationCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _githubCtrl;
  late TextEditingController _linkedinCtrl;
  late TextEditingController _portfolioCtrl;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final p = Provider.of<ProfileProvider>(context, listen: false);
    _nameCtrl = TextEditingController(text: p.name);
    _titleCtrl = TextEditingController(text: p.title);
    _subtitleCtrl = TextEditingController(text: p.subtitle);
    _aboutCtrl = TextEditingController(text: p.about);
    _locationCtrl = TextEditingController(text: p.location);
    _educationCtrl = TextEditingController(text: p.education);
    _emailCtrl = TextEditingController(text: p.email);
    _phoneCtrl = TextEditingController(text: p.phone);
    _githubCtrl = TextEditingController(text: p.github);
    _linkedinCtrl = TextEditingController(text: p.linkedin);
    _portfolioCtrl = TextEditingController(text: p.portfolio);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameCtrl.dispose();
    _titleCtrl.dispose();
    _subtitleCtrl.dispose();
    _aboutCtrl.dispose();
    _locationCtrl.dispose();
    _educationCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _githubCtrl.dispose();
    _linkedinCtrl.dispose();
    _portfolioCtrl.dispose();
    super.dispose();
  }

  void _snack(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: GoogleFonts.poppins(fontSize: 13)),
      backgroundColor: error ? AppTheme.error : AppTheme.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
    ));
  }

  Future<void> _savePersonal() async {
    setState(() => _isSaving = true);
    await Provider.of<ProfileProvider>(context, listen: false)
        .updateProfile(
      name: _nameCtrl.text.trim(),
      title: _titleCtrl.text.trim(),
      subtitle: _subtitleCtrl.text.trim(),
      about: _aboutCtrl.text.trim(),
      location: _locationCtrl.text.trim(),
      education: _educationCtrl.text.trim(),
    );
    setState(() => _isSaving = false);
    // _snack('Personal info saved! ✅');

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 18),
            const SizedBox(width: 4),
            Text('Personal info saved successfully!',
                style: GoogleFonts.poppins(fontSize: 13)),
          ]),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _saveContact() async {
    setState(() => _isSaving = true);
    await Provider.of<ProfileProvider>(context, listen: false)
        .updateContact(
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      github: _githubCtrl.text.trim(),
      linkedin: _linkedinCtrl.text.trim(),
      portfolio: _portfolioCtrl.text.trim(),
    );
    setState(() => _isSaving = false);
    _snack('Contact info saved! ✅');
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked =
    await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      await Provider.of<ProfileProvider>(context, listen: false)
          .updateProfileImage(picked.path);
      _snack('Profile photo updated! ✅');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);

    return Scaffold(
      backgroundColor: AppTheme.bgColor(isDark),
      appBar: AppBar(
        backgroundColor: AppTheme.bgColor(isDark),
        title: Text('Edit Profile',
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accent,
          indicatorWeight: 3,
          labelColor: AppTheme.accent,
          unselectedLabelColor: AppTheme.textMuted,
          labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600, fontSize: 13),
          tabs: const [
            Tab(text: 'Personal Info'),
            Tab(text: 'Contact Info'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ── Personal ──
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 8),
                // Photo picker
                Consumer<ProfileProvider>(
                  builder: (context, profile, _) => GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              AppTheme.accent,
                              AppTheme.accentSecondary
                            ]),
                          ),
                          child: ClipOval(
                            child: profile.profileImagePath
                                .isNotEmpty
                                ? Image.file(
                                File(profile.profileImagePath),
                                fit: BoxFit.cover)
                                : Image.asset(
                                'assets/icon/profile_icon.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppTheme.accent,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text('Tap to change photo',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppTheme.textMuted)),
                const SizedBox(height: 24),
                _Field(label: 'Full Name', ctrl: _nameCtrl,
                    icon: Icons.person_outline_rounded,
                    isDark: isDark),
                _Field(label: 'Professional Title',
                    ctrl: _titleCtrl,
                    icon: Icons.work_outline_rounded,
                    isDark: isDark),
                _Field(label: 'Subtitle', ctrl: _subtitleCtrl,
                    icon: Icons.text_fields_rounded,
                    isDark: isDark),
                _Field(label: 'Location', ctrl: _locationCtrl,
                    icon: Icons.location_on_outlined,
                    isDark: isDark),
                _Field(label: 'Education', ctrl: _educationCtrl,
                    icon: Icons.school_outlined,
                    isDark: isDark),
                _Field(label: 'About Me', ctrl: _aboutCtrl,
                    icon: Icons.info_outline_rounded,
                    isDark: isDark, maxLines: 5),
                const SizedBox(height: 24),
                _isSaving
                    ? const CircularProgressIndicator(
                    color: AppTheme.accent)
                    : GradientButton(
                    text: 'Save Personal Info',
                    //icon: Icons.save_rounded,
                    onTap: _savePersonal),
                const SizedBox(height: 32),
              ],
            ),
          ),
          // ── Contact ──
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 8),
                _Field(label: 'Email', ctrl: _emailCtrl,
                    icon: Icons.email_outlined, isDark: isDark,
                    keyboard: TextInputType.emailAddress),
                _Field(label: 'Phone', ctrl: _phoneCtrl,
                    icon: Icons.phone_outlined, isDark: isDark,
                    keyboard: TextInputType.phone),
                _Field(label: 'GitHub URL', ctrl: _githubCtrl,
                    icon: Icons.code_rounded, isDark: isDark,
                    keyboard: TextInputType.url),
                _Field(label: 'LinkedIn URL',
                    ctrl: _linkedinCtrl,
                    icon: Icons.link_rounded, isDark: isDark,
                    keyboard: TextInputType.url),
                _Field(label: 'Portfolio URL',
                    ctrl: _portfolioCtrl,
                    icon: Icons.language_rounded, isDark: isDark,
                    keyboard: TextInputType.url),
                const SizedBox(height: 24),
                _isSaving
                    ? const CircularProgressIndicator(
                    color: AppTheme.accent)
                    : GradientButton(
                    text: 'Save Contact Info',
                    //icon: Icons.save_rounded,
                    onTap: _saveContact),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController ctrl;
  final IconData icon;
  final bool isDark;
  final int maxLines;
  final TextInputType keyboard;

  const _Field({
    required this.label,
    required this.ctrl,
    required this.icon,
    required this.isDark,
    this.maxLines = 1,
    this.keyboard = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textMuted,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          TextFormField(
            controller: ctrl,
            maxLines: maxLines,
            keyboardType: keyboard,
            style: GoogleFonts.poppins(
                color: AppTheme.textColor(isDark), fontSize: 14),
            decoration: InputDecoration(
              prefixIcon: maxLines == 1
                  ? Icon(icon, size: 18, color: AppTheme.textMuted)
                  : null,
              hintText: 'Enter $label',
              hintStyle: GoogleFonts.poppins(
                  fontSize: 13, color: AppTheme.textMuted),
              contentPadding: EdgeInsets.symmetric(
                horizontal: maxLines > 1 ? 16 : 0,
                vertical: maxLines > 1 ? 14 : 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}