import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parc/models/user.dart';

class UserRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _db = Firestore.instance;

  static Future<void> signIn(String email, String password) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signUp({
    String name,
    String email,
    String password,
    String license,
    String currentReservation
  }) async {
    // Account
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Profile
    var docRef = _db.collection('users').document();
    var user = User(
      id: docRef.documentID,
      name: name,
      email: email,
      license: license,
      currentReservation: ""
    );
    return await docRef.setData(user.toMap());
  }

  static Future<void> signOut() async {
    return await _auth.signOut();
  }

  static Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  static Future<User> getUser() async {
    var email = (await _auth.currentUser()).email;
    var query = await _db
        .collection('users')
        .where("email", isEqualTo: email)
        .getDocuments();
    var doc = query.documents[0];
    return User.fromDocument(doc);
  }
}
