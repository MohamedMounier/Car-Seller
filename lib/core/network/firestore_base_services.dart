import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppBaseFireBaseServices {

  FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _fireStore=FirebaseFirestore.instance;
  get userUid=>_auth.currentUser!.uid;

  Future<DocumentSnapshot<Map<String,dynamic>>>getFireStoreDocument({required String collectionPath, required String docId})async{
   return await _fireStore.collection(collectionPath).doc(docId).get();
  }
  Future<void>addFireStoreDocument({required String collectionPath, required String docId ,required Map<String,dynamic> data})async{
    return await _fireStore.collection(collectionPath).doc(docId).set(data);
  }
}