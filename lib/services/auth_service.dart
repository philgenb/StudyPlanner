import 'package:firebase_auth/firebase_auth.dart';
import 'package:studyplanner/models/user.dart';

import 'database.dart';


class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Return Current Firebase User
  User? getCurrentFirebaseUser() {
    User? user = _auth.currentUser;
    return user;
  }

  /// Converts Firebase User object into own user Object -> only relevant information to deal with
  CustomUser? getCurrentUser() {
    User? user = _auth.currentUser;
    return _getUserFromFirebaseUser(user!);
  }

  CustomUser? _getUserFromFirebaseUser(User? user) {
    if(user != null) {
      return CustomUser(user.displayName!, userID: user.uid);
    }
    return null;
  }

  /// Stream - Auth Change User
  Stream<CustomUser?> get user {
    return _auth.userChanges().map(_getUserFromFirebaseUser);
  }


  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authresult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = authresult.user!;
      return _getUserFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<CustomUser?> registerWithEmailAndPassword(String email, String password, String displayName) async {
    try {
      UserCredential authresult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = authresult.user;
      await user!.updateProfile(displayName: displayName);
      await DataBaseService(uid: user.uid).createUser(displayName);
      await user.reload();

      user = _auth.currentUser;

      return _getUserFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }



  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}