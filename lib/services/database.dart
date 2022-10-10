import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyplanner/models/user.dart';
import 'package:studyplanner/utils/semesterutil.dart';

import '../models/module.dart';
import '../models/profile.dart';

class DataBaseService {
  final String? uid;

  DataBaseService({this.uid});

  // Data Stored of Each User - USER DATA
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");

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
      'credits': 0,
      'semester': "SS22"
    });
  }

  /// gets the profile name of the user.
  Future<String> getProfileName() async {
    DocumentSnapshot documentSnapshot = await getUserDocument().get();
    return documentSnapshot.get('name');
  }

  /// gets the active semester of a student
  Future<String> getSemester() async {
    DocumentSnapshot docSnap = await getUserDocument().get();
    return docSnap.get('semester');
  }

  /// sets the active semester of a student
  Future setSemester(String semester) async {
    await getUserDocument().update({
      'semester': semester
    });
  }

  Future<CustomUser> getUserByProfileName(String username) async {
    QuerySnapshot users = await userCollection.get();
    DocumentSnapshot user =
    users.docs.firstWhere((element) => element.get('name') == username);
    return CustomUser(user['name'], userID: user.id);
  }

  @Deprecated("Old Firebase Hierarchy")
  Future addModule(Module module) async {
    await getModuleCollection().doc(module.moduleName).set({
      'name': module.moduleName,
      'examTimeStamp': module.examTimeStamp,
      'zoom': module.zoomURL,
      'color': module.color.toString(),
      'credits': double.parse(module.creditPoints),
      'room': module.room,
      'time': module.time
    }, SetOptions(merge: true));
    await incrementUserCredits(double.parse(module.creditPoints));
    await incrementModuleCounter();
  }

  Future addModuleToSemester(Module module) async {
    String semester = await getSemester();
    await getModuleCollection().doc(module.moduleName).set({
      'semester': semester,
      'name': module.moduleName,
      'examTimeStamp': module.examTimeStamp,
      'zoom': module.zoomURL,
      'color': module.color.toString(),
      'credits': double.parse(module.creditPoints),
      'room': module.room,
      'time': module.time
    }, SetOptions(merge: true));
    await incrementUserCredits(double.parse(module.creditPoints));
    await incrementModuleCounter();
  }

  /// increments the user credits by the given amount
  Future incrementUserCredits(double credits) async{
    await getUserDocument().update({
      'credits': FieldValue.increment(credits)
    });
  }

  /// decrements the user credits by the given amount
  Future decrementUserCredits(double credits) async{
    await getUserDocument().update({
    'credits': FieldValue.increment(-credits)
    });
  }

  // gets the credits amount of the taken user courses
  Future<double> getUserCredits() async{
    DocumentSnapshot userDoc = await getUserDocument().get();
    return userDoc.get('credits');
  }

  /// increments the module count of the user
  Future incrementModuleCounter() async {
    await getUserDocument().update({
      'moduleCount': FieldValue.increment(1)
    });
  }

  /// decrements the module count of the user
  Future decrementModuleCounter() async {
    await getUserDocument().update({
      'moduleCount': FieldValue.increment(-1)
    });
  }

  /// gets the amount of modules taken by the user
  Future<int> getModuleCount() async {
    DocumentSnapshot userDoc = await getUserDocument().get();
    return userDoc.get('moduleCount');
  }

  Future removeModule(Module module) async {
    await getModuleCollection().doc(module.moduleName).delete();
    // CollectionReference semesterModules = await getSemesterModuleCollection();
    // semesterModules.doc(module.moduleName).delete();
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

  Stream<List<Module>> streamSemesterModules(String semester) {
    return getModuleCollection()
        .where('semester', isEqualTo: semester)
        .orderBy('examTimeStamp').snapshots()
        .map((query) => query.docs
        .map((doc) => Module.fromFireStore(doc))
        .toList());
  }

  Stream<Profile> get streamProfile {
    return getUserDocument().snapshots().map((snap) => Profile.fromFireStore(snap));
  }

}