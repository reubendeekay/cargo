import 'package:cargo/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  bool isOnline = false;
  UserModel? _user;
  UserModel get user => _user!;

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

  Future<void> signUp(UserModel user) async {
    UserCredential signUpUser;
    try {
      signUpUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(signUpUser.user?.uid)
          .set({
        'email': user.email,
        'uid': signUpUser.user?.uid,
        'name': user.fullName,
        'phone': user.phoneNumber,
        'address': '',
        'password': user.password,
        'profilePic':
            'https://www.theupcoming.co.uk/wp-content/themes/topnews/images/tucuser-avatar-new.png',
        'isAdmin': false,
        'isActive': false,
        'isVerified': false,
        'isBlocked': false,
        'lastSeen': Timestamp.now(),
        'isOnline': true,
        'isDeleted': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      await getUser(signUpUser.user!.uid);
    } catch (e) {
      rethrow;
    }
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
        fullName: userResults['name'],
        phoneNumber: userResults['phone'],
        password: userResults['password'],
        userId: userId,
      );
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> updateProfile(UserModel update) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'name': update.fullName,
      'email': update.email,
      'phone': update.phoneNumber,
      'updatedAt': Timestamp.now(),
    });
    notifyListeners();
  }
}
