import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String license;

  User({
    this.id,
    this.name,
    this.email,
    this.license,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        id: doc['id'],
        name: doc['name'],
        email: doc['email'],
        license: doc['license']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'license': license};
  }

  @override
  String toString() {
    return '''User{
      id: $id,
      name: $name,
      email: $email,
      license: $license
    }''';
  }
}
