import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/constants/strings.dart';
import 'package:skype_clone/models/call.dart';
import 'package:meta/meta.dart';

class CallMethods {
  CollectionReference callCollection =
      Firestore.instance.collection(CALL_COLLECTION);

  Stream<DocumentSnapshot> callStream({@required String uid}) =>
      callCollection.document(uid).snapshots();

  Future<bool> makeCall({@required Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      // joke about the fact that anyone can join your calls.

      await callCollection.document(call.callerId).setData(hasDialledMap);
      await callCollection.document(call.receiverId).setData(hasNotDialledMap);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


  Future<bool> endCall({@required Call call}) async {
    try {
      await callCollection.document(call.callerId).delete();
      await callCollection.document(call.receiverId).delete();

      return true;
    } catch (e) {
      return false;
    }
  }
}
