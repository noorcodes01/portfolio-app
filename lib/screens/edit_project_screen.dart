import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../theme/app_theme.dart';
import '../providers/projects_provider.dart';
import '../widgets/common_widgets.dart';

class EditProjectScreen extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final int? index;

  const EditProjectScreen({super.key, this.existing, this.index});

  @override
  State<EditProjectScreen> createState() =>
      _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _fullDescCtrl;
  late TextEditingController _githubCtrl;
  late TextEditingController _liveLinkCtrl;
  late TextEditingController _iconCtrl;
  late TextEditingController _techCtrl;

  String _selectedCategory = 'Mobile App';
  int _selectedColor = 0xFF6C63FF;
  List<String> _techs = [];
  List<String> _features = [];
  List<String> _imagePaths = [];
  bool _isSaving = false;

  final List<String> _categories = [
    'Mobile App',
    'Visualization App',
    'UI/UX Design',
    'Web App',
    'Other',
  ];

  final List<Map<String, dynamic>> _colorOptions = [
    {'name': 'Purple', 'value': 0xFF6C63FF},
    {'name': 'Teal', 'value': 0xFF00D4AA},
    {'name': 'Pink', 'value': 0xFFFF6B9D},
    {'name': 'Orange', 'value': 0xFFFF9500},
    {'name': 'Blue', 'value': 0xFF0A66C2},
    {'name': 'Green', 'value': 0xFF10B981},
  ];

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _titleCtrl = TextEditingController(text: e?['title'] ?? '');
    _descCtrl =
        TextEditingController(text: e?['description'] ?? '');
    _fullDescCtrl =
        TextEditingController(text: e?['fullDescription'] ?? '');
    _githubCtrl = TextEditingController(text: e?['github'] ?? '');
    _liveLinkCtrl =
        TextEditingController(text: e?['liveLink'] ?? '');
    _iconCtrl = TextEditingController(text: e?['icon'] ?? '📱');
    _techCtrl = TextEditingController();

    if (e != null) {
      _selectedCategory = e['category'] ?? 'Mobile App';
      _selectedColor = e['color'] ?? 0xFF6C63FF;
      _techs = List<String>.from(e['tech'] ?? []);
      _features = List<String>.from(e['features'] ?? []);
      _imagePaths = List<String>.from(e['imagePaths'] ?? []);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _fullDescCtrl.dispose();
    _githubCtrl.dispose();
    _liveLinkCtrl.dispose();
    _iconCtrl.dispose();
    _techCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_imagePaths.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Maximum 3 images allowed',
            style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }
    final picker = ImagePicker();
    final picked =
    await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imagePaths.add(picked.path));
    }
  }

  Future<void> _save() async {
    if (_titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Project title is required',
            style: GoogleFonts.poppins(fontSize: 13)),
        backgroundColor: AppTheme.error,
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    setState(() => _isSaving = true);

    final project = {
      'title': _titleCtrl.text.trim(),
      'category': _selectedCategory,
      'description': _descCtrl.text.trim(),
      'fullDescription': _fullDescCtrl.text.trim(),
      'icon': _iconCtrl.text.trim().isEmpty
          ? '📱'
          : _iconCtrl.text.trim(),
      'color': _selectedColor,
      'tech': _techs,
      'features': _features,
      'github': _githubCtrl.text.trim(),
      'liveLink': _liveLinkCtrl.text.trim(),
      'imagePaths': _imagePaths,
    };

    final provider =
    Provider.of<ProjectsProvider>(context, listen: false);
    if (widget.index == null) {
      await provider.addProject(project);
    } else {
      await provider.updateProject(widget.index!, project);
    }

    setState(() => _isSaving = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = AppTheme.textColor(isDark);
    final cardColor = AppTheme.cardColor(isDark);
    final dividerColor = AppTheme.dividerColor(isDark);
    final isEdit = widget.index != null;

    return Scaffold(
      backgroundColor: AppTheme.bgColor(isDark),
      appBar: AppBar(
        backgroundColor: AppTheme.bgColor(isDark),
        title: Text(isEdit ? 'Edit Project' : 'Add Project',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Info
            _sectionLabel('Basic Info'),
            const SizedBox(height: 12),
            _field('Project Title *', _titleCtrl, textColor,
                icon: Icons.title_rounded),
            _field('Short Description', _descCtrl, textColor,
                icon: Icons.short_text_rounded),
            _field('Full Description', _fullDescCtrl, textColor,
                maxLines: 4),
            const SizedBox(height: 8),

            // Icon
            _field('Icon (emoji)', _iconCtrl, textColor,
                icon: Icons.emoji_emotions_outlined),
            const SizedBox(height: 8),

            // Category
            _sectionLabel('Category'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.map((cat) {
                final selected = _selectedCategory == cat;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedCategory = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppTheme.accent
                          : cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: selected
                              ? AppTheme.accent
                              : dividerColor),
                    ),
                    child: Text(cat,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: selected
                                ? Colors.white
                                : AppTheme.textMuted,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w400)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Color
            _sectionLabel('Card Color'),
            const SizedBox(height: 10),
            Row(
              children: _colorOptions.map((c) {
                final selected = _selectedColor == c['value'];
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedColor = c['value']),
                  child: Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Color(c['value']),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? Colors.white
                            : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: selected
                          ? [
                        BoxShadow(
                          color:
                          Color(c['value']).withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ]
                          : [],
                    ),
                    child: selected
                        ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 16)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Technologies
            _sectionLabel('Technologies'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _techCtrl,
                    style: GoogleFonts.poppins(
                        color: textColor, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Add technology (e.g. Flutter)',
                      hintStyle: GoogleFonts.poppins(
                          color: AppTheme.textMuted, fontSize: 13),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (_techCtrl.text.trim().isNotEmpty) {
                      setState(() {
                        _techs.add(_techCtrl.text.trim());
                        _techCtrl.clear();
                      });
                    }
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: AppTheme.accent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
            if (_techs.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _techs.asMap().entries.map((e) {
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _techs.removeAt(e.key)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color:
                            AppTheme.accent.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(e.value,
                              style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppTheme.accent,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(width: 6),
                          const Icon(Icons.close_rounded,
                              color: AppTheme.accent, size: 14),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 20),

            // Features
            _sectionLabel('Key Features'),
            const SizedBox(height: 10),
            ..._features.asMap().entries.map((e) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: dividerColor),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline_rounded,
                      color: AppTheme.accent, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(e.value,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: textColor))),
                  GestureDetector(
                    onTap: () => setState(
                            () => _features.removeAt(e.key)),
                    child: const Icon(Icons.close_rounded,
                        color: AppTheme.error, size: 16),
                  ),
                ],
              ),
            )),
            GestureDetector(
              onTap: () async {
                final ctrl = TextEditingController();
                final result = await showDialog<String>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: cardColor,
                    title: Text('Add Feature',
                        style: GoogleFonts.poppins(
                            color: textColor,
                            fontWeight: FontWeight.w600)),
                    content: TextField(
                      controller: ctrl,
                      style: GoogleFonts.poppins(
                          color: textColor, fontSize: 13),
                      decoration: const InputDecoration(
                          hintText: 'Feature description'),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text('Cancel',
                              style: GoogleFonts.poppins(
                                  color: AppTheme.textMuted))),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accent),
                          onPressed: () =>
                              Navigator.pop(ctx, ctrl.text.trim()),
                          child: Text('Add',
                              style: GoogleFonts.poppins(
                                  color: Colors.white))),
                    ],
                  ),
                );
                if (result != null && result.isNotEmpty) {
                  setState(() => _features.add(result));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.accent.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppTheme.accent.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add_rounded,
                        color: AppTheme.accent, size: 16),
                    const SizedBox(width: 6),
                    Text('Add Feature',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppTheme.accent,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Links
            _sectionLabel('Project Links'),
            const SizedBox(height: 10),
            _field('GitHub URL', _githubCtrl, textColor,
                icon: Icons.code_rounded,
                keyboard: TextInputType.url),
            _field('Live Demo URL', _liveLinkCtrl, textColor,
                icon: Icons.open_in_new_rounded,
                keyboard: TextInputType.url),

            // Images
            _sectionLabel('Project Images (max 3)'),
            const SizedBox(height: 10),
            Row(
              children: [
                ..._imagePaths.asMap().entries.map((e) => Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10),
                        border:
                        Border.all(color: dividerColor),
                      ),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(10),
                        child: Image.file(File(e.value),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 12,
                      child: GestureDetector(
                        onTap: () => setState(
                                () => _imagePaths.removeAt(e.key)),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: AppTheme.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 12),
                        ),
                      ),
                    ),
                  ],
                )),
                if (_imagePaths.length < 3)
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppTheme.accent.withOpacity(0.3)),
                      ),
                      child: const Icon(Icons.add_photo_alternate_rounded,
                          color: AppTheme.accent, size: 28),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 32),

            // Save Button
            _isSaving
                ? const Center(
                child: CircularProgressIndicator(
                    color: AppTheme.accent))
                : GradientButton(
              text: isEdit
                  ? 'Update Project'
                  : 'Add Project',
              //icon: Icons.save_rounded,
              onTap: _save,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(text,
        style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.accent));
  }

  Widget _field(
      String hint,
      TextEditingController ctrl,
      Color textColor, {
        IconData? icon,
        int maxLines = 1,
        TextInputType keyboard = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: keyboard,
        style:
        GoogleFonts.poppins(color: textColor, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
              color: AppTheme.textMuted, fontSize: 13),
          prefixIcon: icon != null && maxLines == 1
              ? Icon(icon, size: 18, color: AppTheme.textMuted)
              : null,
          contentPadding: EdgeInsets.symmetric(
            horizontal: maxLines > 1 ? 16 : 0,
            vertical: maxLines > 1 ? 14 : 0,
          ),
        ),
      ),
    );
  }
}