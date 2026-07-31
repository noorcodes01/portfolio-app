import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;
  static bool get isLoggedIn => _auth.currentUser != null;
  static String? get userId => _auth.currentUser?.uid;

  // ── Auth ──
  static Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'An account already exists with this email.\nPlease sign in instead.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'network-request-failed':
          return 'No internet connection. Please try again.';
        default:
          return 'Sign up failed (${e.code}). Please try again.';
      }
    } catch (e) {
      return 'Something went wrong. Please try again.';
    }
  }

  // Add this method to FirebaseService class
  static Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null; // success
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'invalid-email':
          return 'Please enter a valid email address.';
        default:
          return 'Failed to send reset email. Try again.';
      }
    }
  }

  static Future<String?> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return 'Not logged in.';
      if (user.email == null) return 'No email found.';

      // Re-authenticate first
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(cred);

      // Now change password
      await user.updatePassword(newPassword);
      return null; // success
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          return 'Current password is incorrect.';
        case 'weak-password':
          return 'New password is too weak.';
        default:
          return 'Failed to change password. Try again.';
      }
    }
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
        case 'invalid-credential':
          return 'Incorrect password. Please try again.';
        case 'invalid-email':
          return 'Invalid email address.';
        case 'too-many-requests':
          return 'Too many attempts. Try again later.';
        default:
          return 'Sign in failed. Please try again.';
      }
    }
  }

  static Future<void> signOut() async => _auth.signOut();

  // ── Profile ──
  static Future<Map<String, dynamic>?> fetchProfile() async {
    try {
      if (userId == null) return null;
      final doc = await _db
          .collection('users')
          .doc(userId)
          .collection('portfolio')
          .doc('profile')
          .get();
      return doc.exists ? doc.data() : null;
    } catch (e) {
      debugPrint('fetchProfile: $e');
      return null;
    }
  }

  static Future<void> saveProfile(Map<String, dynamic> data) async {
    try {
      if (userId == null) return;
      await _db
          .collection('users')
          .doc(userId)
          .collection('portfolio')
          .doc('profile')
          .set(data, SetOptions(merge: true));
    } catch (e) {
      debugPrint('saveProfile: $e');
    }
  }

  // ── Skills ──
  static Future<List<Map<String, dynamic>>?> fetchSkills() async {
    try {
      if (userId == null) return null;
      final doc = await _db
          .collection('users')
          .doc(userId)
          .collection('portfolio')
          .doc('skills')
          .get();
      if (!doc.exists || doc.data() == null) return null;
      final List list = doc.data()!['items'] ?? [];
      return list.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      debugPrint('fetchSkills: $e');
      return null;
    }
  }

  static Future<void> saveSkills(List<Map<String, dynamic>> skills) async {
    try {
      if (userId == null) return;
      await _db
          .collection('users')
          .doc(userId)
          .collection('portfolio')
          .doc('skills')
          .set({'items': skills});
    } catch (e) {
      debugPrint('saveSkills: $e');
    }
  }

  // ── Experience ──
  static Future<List<Map<String, String>>?> fetchExperience() async {
    try {
      if (userId == null) return null;
      final doc = await _db
          .collection('users')
          .doc(userId)
          .collection('portfolio')
          .doc('experience')
          .get();
      if (!doc.exists || doc.data() == null) return null;
      final List list = doc.data()!['items'] ?? [];
      return list.map((e) => Map<String, String>.from(e)).toList();
    } catch (e) {
      debugPrint('fetchExperience: $e');
      return null;
    }
  }

  static Future<void> saveExperience(
      List<Map<String, String>> experience) async {
    try {
      if (userId == null) return;
      await _db
          .collection('users')
          .doc(userId)
          .collection('portfolio')
          .doc('experience')
          .set({'items': experience});
    } catch (e) {
      debugPrint('saveExperience: $e');
    }
  }

  // ── Projects ──
  static Future<List<Map<String, dynamic>>?> fetchProjects() async {
    try {
      if (userId == null) return null;
      final snap = await _db
          .collection('users')
          .doc(userId)
          .collection('projects')
          .orderBy('order')
          .get();
      if (snap.docs.isEmpty) return null;
      return snap.docs
          .map((d) => {'docId': d.id, ...d.data()})
          .toList();
    } catch (e) {
      debugPrint('fetchProjects: $e');
      return null;
    }
  }

  static Future<String?> addProject(Map<String, dynamic> project) async {
    try {
      if (userId == null) return null;
      final ref = await _db
          .collection('users')
          .doc(userId)
          .collection('projects')
          .add(project);
      return ref.id;
    } catch (e) {
      debugPrint('addProject: $e');
      return null;
    }
  }

  static Future<void> updateProject(
      String docId, Map<String, dynamic> project) async {
    try {
      if (userId == null) return;
      await _db
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(docId)
          .set(project);
    } catch (e) {
      debugPrint('updateProject: $e');
    }
  }

  static Future<void> deleteProject(String docId) async {
    try {
      if (userId == null) return;
      await _db
          .collection('users')
          .doc(userId)
          .collection('projects')
          .doc(docId)
          .delete();
    } catch (e) {
      debugPrint('deleteProject: $e');
    }
  }

  // ── Init default data for new users ──
  static Future<void> initDefaultData() async {
    if (userId == null) return;
    try {
      await saveProfile({
        'name': 'Kainat Noor',
        'title': 'Flutter Developer',
        'subtitle': 'Computer Science Student | UI/UX Enthusiast',
        'about':
        'I am a passionate Computer Science student with a growing expertise in '
            'Mobile App Development and UI/UX Design. Currently pursuing hands-on '
            'experience through professional training and internships.',
        'email': 'kainat.noor.dev@gmail.com',
        'phone': '+92 XXX XXXXXXX',
        'github': 'https://github.com/KainatNoor',
        'linkedin': 'https://linkedin.com/in/kainat-noor',
        'portfolio': 'https://github.com/KainatNoor',
        'location': 'Mardan, Pakistan',
        'education': 'BS Computer Science Student',
      });

      await saveSkills([
        {'name': 'Flutter', 'icon': '📱', 'level': 0.85},
        {'name': 'Dart', 'icon': '🎯', 'level': 0.80},
        {'name': 'Firebase', 'icon': '🔥', 'level': 0.70},
        {'name': 'UI/UX Design', 'icon': '🎨', 'level': 0.75},
        {'name': 'Mobile App Dev', 'icon': '🚀', 'level': 0.82},
        {'name': 'Problem Solving', 'icon': '💡', 'level': 0.88},
      ]);

      await saveExperience([
        {
          'role': 'Flutter Developer Intern',
          'company': 'Codiora Software House',
          'duration': '2024 - Present',
          'description':
          'Working on real-world Flutter projects and gaining professional experience.',
        },
        {
          'role': 'Banking Intern',
          'company': 'Bank of Khyber',
          'duration': 'Jun 2026 - Present',
          'description':
          'Learning banking operations, customer service, account opening procedures, banking documentation, ATM operations, compliance processes, and professional workplace practices while gaining practical exposure to the financial sector.',

        },
      ]);

      final projects = [
        {
          'title': 'Todo Management Application',
          'category': 'Mobile App',
          'tech': ['Flutter', 'Dart', 'Firebase'],
          'description': 'A modern task management app.',
          'fullDescription':
          'This Todo Management Application was built with Flutter and Firebase, '
              'featuring real-time data sync, task categorization, priority levels, '
            'and due date tracking. Users can create, edit, delete, and mark tasks '
            'as complete with all data persisted in Firebase Firestore.',
          'icon': '✅',
          'color': 0xFF6C63FF,
          'github': 'https://github.com/KainatNoor',
          'liveLink': '',
          'features': ['Create, edit, and delete tasks', 'Firebase sync', 'Clean intuitive  UI', 'Task completion tracking'],
          'imagePaths': <String>[],
          'order': 0,
        },
        {
          'title': 'Pipeline Visualization Tool',
          'category': 'Visualization App',
          'tech': ['Flutter', 'Dart'],
          'description': 'Workflow visualization app.',
          'fullDescription':
          'The Pipeline Visualization Tool helps users understand project stages, '
              'task progression, and system workflows through clear visual representation. '
              'Features interactive pipeline stages, real-time status updates, and '
              'workflow analytics.',
          'icon': '🔄',
          'color': 0xFF00D4AA,
          'github': 'https://github.com/KainatNoor',
          'liveLink': '',
          'features': ['Pipeline stages', 'Progress tracking', 'Real-time status updates'],
          'imagePaths': <String>[],
          'order': 1,
        },
        {
          'title': 'MindSpark — Wellness App',
          'category': 'UI/UX Design',
          'tech': ['Balsamiq', 'Wireframing'],
          'description': 'Wellness companion wireframes.',
          'fullDescription':
          'MindSpark is an emotional and psychological well-being companion app '
              'designed entirely in Balsamiq. Covers complete user onboarding flows, '
              'mood tracking screens, guided meditation journeys, habit tracker, '
              'journal entries, and personalized mental health insights.',
          'icon': '🧠',
          'color': 0xFFFF6B9D,
          'github': 'https://github.com/KainatNoor',
          'liveLink': '',
          'features': ['Mood tracking', 'Meditation'],
          'imagePaths': <String>[],
          'order': 2,
        },
        {
          // ✅ NEW — Flashcard Quiz App
          'title': 'Flashcard Quiz App',
          'category': 'Mobile App',
          'tech': ['Flutter', 'Dart', 'Provider'],
          'description':
          'An interactive flashcard quiz app featuring 3D card flip animations, '
              'CRUD operations, and a glassmorphism UI.',
          'fullDescription':
          'Built during the CodeAlpha internship, this Flashcard Quiz App features '
              '3D card flip animations, full CRUD operations for managing flashcard decks, '
              'Provider state management, and a modern glassmorphism UI design. '
              'Users can create custom quiz decks, flip through cards, and track their progress.',
          'icon': '🃏',
          'color': 0xFFFF9500,
          'github': 'https://github.com/KainatNoor',
          'liveLink': '',
          'features': [
            '3D card flip animation',
            'Create & manage decks',
            'CRUD operations',
            'Provider state management',
            'Glassmorphism UI design',
          ],
          'imagePaths': <String>[],
          'order': 3,
        },
      ];

      for (final p in projects) {
        await addProject(p);
      }

  //     debugPrint('✅ Default data initialized with all projects');
  //   } catch (e) {
  //     debugPrint('initDefaultData error: $e');
  //   }
  // }

      debugPrint('✅ Default data initialized');
    } catch (e) {
      debugPrint('initDefaultData: $e');
    }
  }
}