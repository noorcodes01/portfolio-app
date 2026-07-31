import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/firebase_service.dart';

class ProfileProvider extends ChangeNotifier {
  // Default values shown before Firestore loads
  String _name = 'Kainat Noor';
  String _title = 'Flutter Developer';
  String _subtitle = 'Computer Science Student | UI/UX Enthusiast';
  String _about =
      'I am a passionate Computer Science student with a growing expertise in '
      'Mobile App Development and UI/UX Design.';
  String _email = 'kainat.noor.dev@gmail.com';
  String _phone = '+92 XXX XXXXXXX';
  String _github = 'https://github.com/KainatNoor';
  String _linkedin = 'https://linkedin.com/in/kainat-noor';
  String _portfolio = 'https://github.com/KainatNoor';
  String _location = 'Mardan, Pakistan';
  String _education = 'BS Computer Science Student';
  String _profileImagePath = '';

  List<Map<String, dynamic>> _skills = [
    {'name': 'Flutter', 'icon': '📱', 'level': 0.85},
    {'name': 'Dart', 'icon': '🎯', 'level': 0.80},
    {'name': 'Firebase', 'icon': '🔥', 'level': 0.70},
    {'name': 'UI/UX Design', 'icon': '🎨', 'level': 0.75},
    {'name': 'Mobile App Dev', 'icon': '🚀', 'level': 0.82},
    {'name': 'Problem Solving', 'icon': '💡', 'level': 0.88},
  ];

  List<Map<String, String>> _experience = [
    {
      'role': 'Flutter Developer Intern',
      'company': 'Codiora Software House',
      'duration': '2026 - Present',
      'description':
      'Working on real-world Flutter projects and gaining professional experience.',
    },
    {
      'role': 'Banking Intern',
      'company': 'Bank of Khyber',
      'duration': 'Jun 2026 - Present',
      'description':
      'Learning banking operations, customer service, account opening procedures, banking documentation, ATM operations, compliance processes, and professional workplace practices while gaining practical exposure to the financial sector.',
    }
  ];

  bool _isLoading = false;

  // Getters
  String get name => _name;
  String get title => _title;
  String get subtitle => _subtitle;
  String get about => _about;
  String get email => _email;
  String get phone => _phone;
  String get github => _github;
  String get linkedin => _linkedin;
  String get portfolio => _portfolio;
  String get location => _location;
  String get education => _education;
  String get profileImagePath => _profileImagePath;
  List<Map<String, dynamic>> get skills =>
      List.unmodifiable(_skills);
  List<Map<String, String>> get experience =>
      List.unmodifiable(_experience);
  bool get isLoading => _isLoading;

  ProfileProvider() {
    _loadCached();
  }

  // Load local cache instantly on start
  Future<void> _loadCached() async {
    final prefs = await SharedPreferences.getInstance();
    _name = _v(prefs.getString('pf_name'), _name);
    _title = _v(prefs.getString('pf_title'), _title);
    _subtitle = _v(prefs.getString('pf_subtitle'), _subtitle);
    _about = _v(prefs.getString('pf_about'), _about);
    _email = _v(prefs.getString('pf_email'), _email);
    _phone = _v(prefs.getString('pf_phone'), _phone);
    _github = _v(prefs.getString('pf_github'), _github);
    _linkedin = _v(prefs.getString('pf_linkedin'), _linkedin);
    _portfolio = _v(prefs.getString('pf_portfolio'), _portfolio);
    _location = _v(prefs.getString('pf_location'), _location);
    _education = _v(prefs.getString('pf_education'), _education);
    _profileImagePath =
        prefs.getString('pf_image_path') ?? '';

    final sc = prefs.getString('pf_skills');
    if (sc != null) {
      try {
        _skills = (jsonDecode(sc) as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      } catch (_) {}
    }

    final ec = prefs.getString('pf_experience');
    if (ec != null) {
      try {
        _experience = (jsonDecode(ec) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();
      } catch (_) {}
    }

    notifyListeners();
  }

  // Refresh from Firestore after login
  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();

    try {
      final profile = await FirebaseService.fetchProfile();
      if (profile != null) {
        _name = _v(profile['name'], _name);
        _title = _v(profile['title'], _title);
        _subtitle = _v(profile['subtitle'], _subtitle);
        _about = _v(profile['about'], _about);
        _email = _v(profile['email'], _email);
        _phone = _v(profile['phone'], _phone);
        _github = _v(profile['github'], _github);
        _linkedin = _v(profile['linkedin'], _linkedin);
        _portfolio = _v(profile['portfolio'], _portfolio);
        _location = _v(profile['location'], _location);
        _education = _v(profile['education'], _education);
        await _cacheAll();
      }

      final skills = await FirebaseService.fetchSkills();
      if (skills != null && skills.isNotEmpty) {
        _skills = skills;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('pf_skills', jsonEncode(_skills));
      }

      final exp = await FirebaseService.fetchExperience();
      if (exp != null && exp.isNotEmpty) {
        _experience = exp;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'pf_experience', jsonEncode(_experience));
      }
    } catch (e) {
      debugPrint('ProfileProvider.refresh: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Clear cache on logout
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = [
      'pf_name', 'pf_title', 'pf_subtitle', 'pf_about',
      'pf_email', 'pf_phone', 'pf_github', 'pf_linkedin',
      'pf_portfolio', 'pf_location', 'pf_education',
      'pf_skills', 'pf_experience', 'pf_image_path',
    ];
    for (final k in keys) await prefs.remove(k);

    // Reset to defaults
    _name = 'Kainat Noor';
    _title = 'Flutter Developer';
    _subtitle = 'Computer Science Student | UI/UX Enthusiast';
    _about = 'I am a passionate Computer Science student...';
    _email = 'kainat.noor.dev@gmail.com';
    _phone = '+92 XXX XXXXXXX';
    _github = 'https://github.com/KainatNoor';
    _linkedin = 'https://linkedin.com/in/kainat-noor';
    _portfolio = 'https://github.com/KainatNoor';
    _location = 'Mardan, Pakistan';
    _education = 'BS Computer Science Student';
    _profileImagePath = '';
    _skills = [
      {'name': 'Flutter', 'icon': '📱', 'level': 0.85},
      {'name': 'Dart', 'icon': '🎯', 'level': 0.80},
      {'name': 'Firebase', 'icon': '🔥', 'level': 0.70},
      {'name': 'UI/UX Design', 'icon': '🎨', 'level': 0.75},
      {'name': 'Mobile App Dev', 'icon': '🚀', 'level': 0.82},
      {'name': 'Problem Solving', 'icon': '💡', 'level': 0.88},
    ];
    _experience = [
      {
        'role': 'Flutter Developer Intern',
        'company': 'Codiora Software House',
        'duration': '2024 - Present',
        'description': 'Working on real-world Flutter projects.',
      },
      {
        'role': 'Banking Intern',
        'company': 'Bank of Khyber',
        'duration': 'Jun 2026 - Present',
        'description':
        'Learning banking operations, customer service, account opening procedures, banking documentation, ATM operations, compliance processes, and professional workplace practices while gaining practical exposure to the financial sector.',

      },
    ];
    notifyListeners();
  }

  String _v(dynamic val, String fallback) {
    if (val == null || val.toString().trim().isEmpty) return fallback;
    return val.toString();
  }

  Future<void> _cacheAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pf_name', _name);
    await prefs.setString('pf_title', _title);
    await prefs.setString('pf_subtitle', _subtitle);
    await prefs.setString('pf_about', _about);
    await prefs.setString('pf_email', _email);
    await prefs.setString('pf_phone', _phone);
    await prefs.setString('pf_github', _github);
    await prefs.setString('pf_linkedin', _linkedin);
    await prefs.setString('pf_portfolio', _portfolio);
    await prefs.setString('pf_location', _location);
    await prefs.setString('pf_education', _education);
  }

  Map<String, dynamic> get _profileMap => {
    'name': _name, 'title': _title, 'subtitle': _subtitle,
    'about': _about, 'email': _email, 'phone': _phone,
    'github': _github, 'linkedin': _linkedin,
    'portfolio': _portfolio, 'location': _location,
    'education': _education,
  };

  Future<void> updateProfile({
    required String name, required String title,
    required String subtitle, required String about,
    required String location, required String education,
  }) async {
    _name = name.trim().isEmpty ? _name : name.trim();
    _title = title.trim().isEmpty ? _title : title.trim();
    _subtitle = subtitle.trim();
    _about = about.trim().isEmpty ? _about : about.trim();
    _location = location.trim();
    _education = education.trim();
    await _cacheAll();
    notifyListeners();
    await FirebaseService.saveProfile(_profileMap);
  }

  Future<void> updateContact({
    required String email, required String phone,
    required String github, required String linkedin,
    required String portfolio,
  }) async {
    _email = email.trim().isEmpty ? _email : email.trim();
    _phone = phone.trim().isEmpty ? _phone : phone.trim();
    _github = github.trim().isEmpty ? _github : github.trim();
    _linkedin = linkedin.trim().isEmpty ? _linkedin : linkedin.trim();
    _portfolio = portfolio.trim().isEmpty ? _portfolio : portfolio.trim();
    await _cacheAll();
    notifyListeners();
    await FirebaseService.saveProfile(_profileMap);
  }

  Future<void> updateProfileImage(String path) async {
    _profileImagePath = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pf_image_path', path);
    notifyListeners();
  }

  Future<void> addSkill(Map<String, dynamic> skill) async {
    _skills.add(skill);
    await _saveSkills();
    notifyListeners();
  }

  Future<void> updateSkill(int i, Map<String, dynamic> skill) async {
    if (i < 0 || i >= _skills.length) return;
    _skills[i] = skill;
    await _saveSkills();
    notifyListeners();
  }

  Future<void> deleteSkill(int i) async {
    if (i < 0 || i >= _skills.length) return;
    _skills.removeAt(i);
    await _saveSkills();
    notifyListeners();
  }

  Future<void> reorderSkills(int o, int n) async {
    if (n > o) n--;
    final item = _skills.removeAt(o);
    _skills.insert(n, item);
    await _saveSkills();
    notifyListeners();
  }

  Future<void> _saveSkills() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pf_skills', jsonEncode(_skills));
    await FirebaseService.saveSkills(_skills);
  }

  Future<void> addExperience(Map<String, String> exp) async {
    _experience.add(exp);
    await _saveExp();
    notifyListeners();
  }

  Future<void> updateExperience(int i, Map<String, String> exp) async {
    if (i < 0 || i >= _experience.length) return;
    _experience[i] = exp;
    await _saveExp();
    notifyListeners();
  }

  Future<void> deleteExperience(int i) async {
    if (i < 0 || i >= _experience.length) return;
    _experience.removeAt(i);
    await _saveExp();
    notifyListeners();
  }

  Future<void> _saveExp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pf_experience', jsonEncode(_experience));
    await FirebaseService.saveExperience(_experience);
  }
}