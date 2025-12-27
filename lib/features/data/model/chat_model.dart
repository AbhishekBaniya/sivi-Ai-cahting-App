class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}

/*import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String text;
  final String senderId;
  final DateTime time;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.senderId,
    required this.time,
    required this.isMe,
  });

  factory ChatMessage.fromDoc(DocumentSnapshot doc, String myId) {
    final data = doc.data() as Map<String, dynamic>;

    return ChatMessage(
      text: data['text'] ?? '',
      senderId: data['senderId'] ?? '',
      time: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isMe: data['senderId'] == myId,
    );
  }*/

// factory ChatMessage.fromDoc(DocumentSnapshot doc, String myId) {
//   return ChatMessage(
//     text: doc['text'],
//     senderId: doc['senderId'],
//     time: (doc['timestamp'] as Timestamp).toDate(),
//     isMe: doc['senderId'] == myId,
//   );
// }}
