import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {

  String userName;
  String semester;
  int moduleCount;
  double credits;

  Profile({required this.userName, required this.moduleCount, required this.semester, required this.credits});

  factory Profile.fromFireStore(DocumentSnapshot doc) {
    return Profile(
      userName: doc.id,
      moduleCount: doc.get('moduleCount'),
      credits: doc.get('credits'),
      semester: doc.get('semester')
    );
  }
  
}