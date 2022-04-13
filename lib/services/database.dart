import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyplanner/models/user.dart';

import '../models/module.dart';

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

  CollectionReference getModuleCollection() {
    return getUserDocument().collection('modules');
  }


  /// creates a new user with a given profile name.
  Future createUser(String profileName) async {
    await getUserDocument().set({
      'name': profileName,
      'moduleCount': 0,
      'credits': 0
    });
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

  Future addModule(Module module) async {
    await getModuleCollection().doc(module.moduleName).set({
      'name': module.moduleName,
      'examTimeStamp': module.examTimeStamp,
      'zoom': module.zoomURL,
      'color': module.color.toString(),
      'credits': double.parse(module.creditPoints)
    }, SetOptions(merge: true));
    await incrementUserCredits(double.parse(module.creditPoints));
    await incrementModuleCounter();
  }

  Future incrementUserCredits(double credits) async{
    await getUserDocument().update({
      'credits': FieldValue.increment(credits)
    });
  }

  Future decrementUserCredits(double credits) async{
    await getUserDocument().update({
    'credits': FieldValue.increment(-credits)
    });
  }

  Future<double> getUserCredits() async{
    DocumentSnapshot userDoc = await getUserDocument().get();
    return userDoc.get('credits');
  }

  Future incrementModuleCounter() async {
    await getUserDocument().update({
      'moduleCount': FieldValue.increment(1)
    });
  }

  Future decrementModuleCounter() async {
    await getUserDocument().update({
      'moduleCount': FieldValue.increment(-1)
    });
  }

  Future<int> getModuleCount() async {
    DocumentSnapshot userDoc = await getUserDocument().get();
    return userDoc.get('moduleCount');
  }

  Future removeModule(Module module) async {
    await getModuleCollection().doc(module.moduleName).delete();
    await decrementModuleCounter();
    await decrementUserCredits(double.parse(module.creditPoints));
  }

  void testPrintModules() {
    print("Print Modules");
    getModuleCollection().snapshots().forEach((element) {
      element.docs.forEach((elem) {
        Module module = Module.fromFireStore(elem);
        print("test: ${module.moduleName}");
      });
    });
  }

  
  Stream<List<Module>> streamModules() {
    return getModuleCollection().orderBy('examTimeStamp').snapshots()
        .map((query) => query.docs
        .map((doc) => Module.fromFireStore(doc))
        .toList());
  }

}