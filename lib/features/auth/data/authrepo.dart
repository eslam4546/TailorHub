import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth;
  // تعريف الـ Firestore عشان نحفظ فيه بيانات المستخدم (الاسم والدور)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthRepo(this._firebaseAuth);

  // 1. دالة إنشاء الحساب (Sign Up)
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role, // 'customer' أو 'tailor'
  }) async {
    try {
      // أ. إنشاء الحساب في Firebase Auth
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // ب. حفظ باقي البيانات في Firestore (زي الاسم والدور)
      if (credential.user != null) {
        await _firestore.collection('Users').doc(credential.user!.uid).set({
          'uid': credential.user!.uid,
          'fullName': fullName,
          'email': email,
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return credential;
    } catch (e) {
      // لو حصل خطأ بنرجعه عشان نعرضه في الـ UI
      rethrow;
    }
  }

  // 2. دالة تسجيل الدخول (Login)
  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  // 3. دالة لمعرفة دور المستخدم بعد تسجيل الدخول
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return doc.get('role') as String?;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
  // 4. دالة تسجيل الخروج (Sign Out)
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
