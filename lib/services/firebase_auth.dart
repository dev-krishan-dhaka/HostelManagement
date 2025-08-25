import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email/password
  Future<User?> signUp({
    required String email,
    required String password,
    required String role,
    String? hostelName,
    String? roomNumber,
    String? fullName,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user data in Firestore
      await _firestore.collection('users').doc(credential.user?.uid).set({
        'uid': credential.user?.uid,
        'email': email,
        'role': role,
        'hostelName': hostelName,
        'roomNumber': roomNumber,
        'fullName': fullName,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return credential.user;
    } catch (e) {
      print("Error during signup: $e");
      return null;
    }
  }

  // Sign in with email/password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }

  // Get user role
  Future<String> getUserRole(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc['role'];
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}