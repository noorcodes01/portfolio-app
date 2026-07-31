import 'package:flutter/material.dart';
import 'firebase_service.dart';

class AuthService extends ChangeNotifier {
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => FirebaseService.isLoggedIn;
  String get userEmail =>
      FirebaseService.currentUser?.email ?? '';

  AuthService() {
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoading = false;
    notifyListeners();
  }

  Future<String?> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final error = await FirebaseService.signUp(email, password);
    if (error == null) {
      await FirebaseService.initDefaultData();
    }
    _isLoading = false;
    notifyListeners();
    return error;
  }

  Future<String?> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final error = await FirebaseService.signIn(email, password);
    _isLoading = false;
    notifyListeners();
    return error;
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    await FirebaseService.signOut();
    _isLoading = false;
    notifyListeners();
  }
}