import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyplanner/models/user.dart';

class DataBaseService {
  final String? uid;

  DataBaseService({this.uid});

  // Data Stored of Each User - USER DATA
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");
  final CollectionReference missionCollection =
  FirebaseFirestore.instance.collection("partys");

  Stream<DocumentSnapshot> getUserSnapshot() {
    return getUserDocument().snapshots();
  }

  DocumentReference getUserDocument() {
    return userCollection.doc(this.uid);
  }


  /// creates a new user with a given profile name.
  Future createUser(String profileName) async {
    await getUserDocument().set({'name': profileName});
  }

  /// gets the profile name of the user.
  Future<String> getProfileName() async {
    DocumentSnapshot documentSnapshot = await getUserDocument().get();
    return documentSnapshot.get('name');
  }

  Future<CustomUser> getUserByProfileName(String username) async {
    QuerySnapshot users = await userCollection.get();
    DocumentSnapshot user =
    users.docs.firstWhere((element) => element.get('name') == username);
    return CustomUser(user['name'], userID: user.id);
  }

}