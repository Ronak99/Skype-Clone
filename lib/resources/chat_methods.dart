import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/constants/strings.dart';
import 'package:skype_clone/models/contact.dart';
import 'package:skype_clone/models/message.dart';
import 'package:skype_clone/models/user.dart';
import 'package:meta/meta.dart';

class ChatMethods {
  static final Firestore _firestore = Firestore.instance;

  final CollectionReference _messagesCollection =
      _firestore.collection(MESSAGES_COLLECTION);

  final CollectionReference _userCollection =
      _firestore.collection(USERS_COLLECTION);

  Future<void> addMessageToDb(
    Message message,
  ) async {
    var map = message.toMap();

    await _messagesCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    addToContacts(senderId: message.senderId, receiverId: message.receiverId);

    return await _messagesCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  DocumentReference getContactsDocument({
    @required String of,
    @required String forContact,
  }) =>
      _userCollection
          .document(of)
          .collection(CONTACTS_COLLECTION)
          .document(forContact);

  // Add to contacts
  void addToContacts({String senderId, String receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSendersContacts(
      senderId: senderId,
      receiverId: receiverId,
      currentTime: currentTime,
    );
    await addToReceiversContacts(
      senderId: senderId,
      receiverId: receiverId,
      currentTime: currentTime,
    );
  }

  Future<void> addToSendersContacts({
    @required String senderId,
    @required String receiverId,
    @required currentTime,
  }) async {
    DocumentSnapshot sendersDocument =
        await getContactsDocument(of: senderId, forContact: receiverId).get();

    if (!sendersDocument.exists) {
      Contact receiverContact = Contact(
        uid: receiverId,
        addedOn: currentTime,
      );
      var receiverMap = receiverContact.toMap(receiverContact);

      getContactsDocument(of: senderId, forContact: receiverId)
          .setData(receiverMap);
    }
  }

  Future<void> addToReceiversContacts({
    @required String senderId,
    @required String receiverId,
    @required currentTime,
  }) async {
    DocumentSnapshot receiversDocument =
        await getContactsDocument(of: receiverId, forContact: senderId).get();

    if (!receiversDocument.exists) {
      Contact senderContact = Contact(
        uid: senderId,
        addedOn: currentTime,
      );
      var senderMap = senderContact.toMap(senderContact);

      getContactsDocument(of: receiverId, forContact: senderId)
          .setData(senderMap);
    }
  }

  void setImageMsg(String url, String receiverId, String senderId) async {
    Message message;

    message = Message.imageMessage(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');

    // create imagemap
    var map = message.toImageMap();

    // var map = Map<String, dynamic>();
    await _messagesCollection
        .document(message.senderId)
        .collection(message.receiverId)
        .add(map);

    _messagesCollection
        .document(message.receiverId)
        .collection(message.senderId)
        .add(map);
  }

  Stream<QuerySnapshot> fetchContacts({String userId}) => _userCollection
      .document(userId)
      .collection(CONTACTS_COLLECTION)
      .snapshots();

  Stream fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      _firestore
          .collection(MESSAGES_COLLECTION)
          .document(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();
}
