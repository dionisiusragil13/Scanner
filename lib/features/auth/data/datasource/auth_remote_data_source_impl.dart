import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scanner/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:scanner/features/auth/data/models/user_models.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModels> signUp(String email, String password, String name, String phoneNumber) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      final String uid = cred.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'name': name,
        'phone_number': phoneNumber,
      });

      return UserModels(id: uid, email: email, name: name, phoneNumber: phoneNumber);
    } catch (e) {
      throw Exception('Gagal Daftar: ${e.toString()}');
    }
  }

  @override
  Future<UserModels> signIn(String email, String password) async {
    final cred = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final doc = await _firestore.collection('users').doc(cred.user!.uid).get();
    final data = doc.data()!;

    return UserModels(
      id: cred.user!.uid,
      email: email,
      name: data['name'] ?? "",
      phoneNumber: data['phone_number'] ?? "",
    );
  }

  @override
  Future<UserModels?> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    final doc = await _firestore.collection('users').doc(user.uid).get();
    
    if (doc.exists) {
      final data = doc.data()!;
      return UserModels(
        id: user.uid,
        email: user.email ?? "",
        name: data['name'] ?? "",
        phoneNumber: data['phone_number'] ?? "",
      );
    }
    return null;
  }
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}