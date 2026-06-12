import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // إنشاء نسخة (Instance) من Firebase Auth للتعامل مع السيرفر
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // دالة إنشاء حساب جديد باستخدام البريد الإلكتروني وكلمة المرور
  Future<UserCredential?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // تمرير رسالة الخطأ القادمة من Firebase ليتم عرضها في الواجهة
      throw Exception(e.message ?? 'An error occurred during registration.');
    } catch (e) {
      throw Exception('An unexpected error occurred.');
    }
  }

  // دالة تسجيل الدخول للحسابات الحالية
  Future<UserCredential?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // تمرير رسالة الخطأ القادمة من Firebase ليتم عرضها في الواجهة
      throw Exception(e.message ?? 'An error occurred during login.');
    } catch (e) {
      throw Exception('An unexpected error occurred.');
    }
  }

  // دالة تسجيل الخروج
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
