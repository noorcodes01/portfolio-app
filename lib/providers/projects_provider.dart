import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/firebase_service.dart';

class ProjectsProvider extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  List<Map<String, dynamic>> _projects = [];
  bool _isLoading = false;

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get allProjects => _projects;

  final List<String> categories = [
    'All', 'Mobile App', 'Visualization App',
    'UI/UX Design', 'Web App', 'Other',
  ];

  ProjectsProvider() {
    _loadCached();
  }

  Future<void> _loadCached() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('proj_cache');
    if (json != null) {
      try {
        _projects = (jsonDecode(json) as List)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        notifyListeners();
      } catch (_) {}
    }
    _selectedCategory =
        prefs.getString('proj_category') ?? 'All';
  }

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await FirebaseService.fetchProjects();
      if (data != null) {
        _projects = data;
        await _cache();
      }
    } catch (e) {
      debugPrint('ProjectsProvider.refresh: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('proj_cache');
    _projects = [];
    notifyListeners();
  }

  void setSearch(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  void setCategory(String cat) async {
    _selectedCategory = cat;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('proj_category', cat);
    notifyListeners();
  }

  List<Map<String, dynamic>> get filteredProjects {
    var list = List<Map<String, dynamic>>.from(_projects);
    if (_selectedCategory != 'All') {
      list = list
          .where((p) => p['category'] == _selectedCategory)
          .toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      list = list.where((p) =>
      p['title'].toString().toLowerCase().contains(q) ||
          p['description'].toString().toLowerCase().contains(q) ||
          (p['tech'] as List? ?? [])
              .any((t) => t.toString().toLowerCase().contains(q)))
          .toList();
    }
    return list;
  }

  Future<void> addProject(Map<String, dynamic> p) async {
    final withOrder = {...p, 'order': _projects.length};
    final docId = await FirebaseService.addProject(withOrder);
    if (docId != null) {
      _projects.add({'docId': docId, ...withOrder});
      await _cache();
      notifyListeners();
    }
  }

  Future<void> updateProject(int i, Map<String, dynamic> p) async {
    if (i < 0 || i >= _projects.length) return;
    final docId = _projects[i]['docId'] as String?;
    _projects[i] = {'docId': docId, ...p};
    await _cache();
    notifyListeners();
    if (docId != null) await FirebaseService.updateProject(docId, p);
  }

  Future<void> deleteProject(int i) async {
    if (i < 0 || i >= _projects.length) return;
    final docId = _projects[i]['docId'] as String?;
    _projects.removeAt(i);
    await _cache();
    notifyListeners();
    if (docId != null) await FirebaseService.deleteProject(docId);
  }

  Future<void> _cache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('proj_cache', jsonEncode(_projects));
  }
}