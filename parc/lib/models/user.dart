import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String license;
  double balance;
  String currentReservation;

  User({
    this.id,
    this.name,
    this.email,
    this.license,
    this.balance,
    this.currentReservation,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      license: doc['license'],
      balance: doc['balance'].toDouble(),
      currentReservation: doc['currentReservation']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'license': license,
      'balance': balance,
      'currentReservation': ""
    };
  }

  @override
  String toString() {
    return '''User{
      id: $id,
      name: $name,
      email: $email,
      license: $license,
      balance: $balance,
      currentReservation: $currentReservation
    }''';
  }
}
