import 'package:get/get.dart';

import 'chat_model.dart';

class ChatSessionModel {
  final String userId;
  final String userName;
  final RxList<ChatMessage> messages;

  ChatSessionModel({
    required this.userId,
    required this.userName,
    required this.messages,
  });
}
