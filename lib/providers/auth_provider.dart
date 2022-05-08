import 'package:cargo/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

final uid = FirebaseAuth.instance.currentUser!.uid;

class AuthProvider with ChangeNotifier {
  bool isOnline = false;
  UserModel? _user;
  UserModel? get user => _user;

  Future<void> signIn(String email, String password) async {
    UserCredential signUpUser;
    try {
      signUpUser = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      getUser(signUpUser.user!.uid);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  void setUserNull() {
    _user = null;
    notifyListeners();
  }

  Future<void> getUser(String userId) async {
    try {
      final userResults = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      _user = UserModel(
        email: userResults['email'],
        fullName: userResults['fullName'],
        phoneNumber: userResults['phone'],
        password: userResults['password'],
        branch: userResults['branch'],
        createdAt: userResults['createdAt'],
        profilePic: userResults['profilePic'],
        role: userResults['role'],
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> updateProfile(UserModel update) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'fullName': update.fullName,
      'email': update.email,
      'phone': update.phoneNumber,
      'updatedAt': Timestamp.now(),
    });
    notifyListeners();
  }

  Future<void> createAgent(UserModel agent) async {
    final createdUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: agent.email!.trim(), password: agent.password!.trim());

    final upload = await FirebaseStorage.instance
        .ref('agents/${createdUser.user!.uid}')
        .putFile(agent.imageFile!);
    final downloadUrl = await upload.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(createdUser.user!.uid)
        .set({
      'fullName': agent.fullName,
      'email': agent.email,
      'profilePic': downloadUrl.toString(),
      'phone': agent.phoneNumber,
      'password': agent.password,
      'createdAt': Timestamp.now(),
      'role': agent.role,
      'createdBy': uid,
      'branch': agent.branch,
    });
  }
}
