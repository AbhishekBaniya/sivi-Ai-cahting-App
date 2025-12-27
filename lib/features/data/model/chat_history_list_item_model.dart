class ChatListModel {
  final String chatId;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  ChatListModel({
    required this.chatId,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
  });
}
