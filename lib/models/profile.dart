import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {

  String userName;
  int moduleCount;
  double credits;

  Profile({required this.userName, required this.moduleCount, required this.credits});

  factory Profile.fromFireStore(DocumentSnapshot doc) {
    return Profile(
      userName: doc.id,
      moduleCount: doc.get('moduleCount'),
      credits: doc.get('credits')
    );
  }
  
}