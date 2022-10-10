import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {

  String userName;
  String semester;
  int moduleCount;
  double credits;

  Profile({required this.userName, required this.moduleCount, required this.semester, required this.credits});

  factory Profile.fromFireStore(DocumentSnapshot doc) {
    String semester = doc.get('semester');
    return Profile(
      userName: doc.id,
      moduleCount: doc.get('moduleCount')[semester] ?? 0,
      credits: (doc.get('credits')[semester] ?? 0).toDouble(),
      semester: semester
    );
  }
  
}