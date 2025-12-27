import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChatService {
  static final _db = FirebaseFirestore.instance;

  static Future<void> initUser(String uid) async {
    await _db.collection('users').doc(uid).set({
      'isOnline': true,
      'lastSeen': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> initChat(String chatId) async {
    await _db.collection('messages').doc(chatId).set({
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<void> initTyping(String chatId, String uid) async {
    await _db.collection('typing').doc(chatId).set({
      uid: false,
    }, SetOptions(merge: true));
  }
}
