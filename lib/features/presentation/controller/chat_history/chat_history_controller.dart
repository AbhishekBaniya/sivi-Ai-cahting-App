import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/imports_utils.dart';
import '../../../data/model/chat_history_list_item_model.dart';

class ChatHistoryController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;

  /// 🔥 chat list
  final RxList<ChatHistoryListItemModel> chats =
      <ChatHistoryListItemModel>[].obs;

  /// 🔥 scroll controller (PRESERVED)
  late final ScrollController scrollController;

  double _lastOffset = 0;

  @override
  void onInit() {
    super.onInit();
    //loadChats();
    Logger().info("PortfolioController OnInit() Called");
  }

  @override
  void onReady() {
    super.onReady();
    Logger().info("PortfolioController onReady() Called");
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
    Logger().info("PortfolioController onClose() Called");
  }

  String getFirstLetter(String text) {
    final trimmed = text.trimLeft();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }

  void loadChats() async {
    isLoading(true);

    await Future.delayed(const Duration(milliseconds: 300));

    chats.assignAll([
      ChatHistoryListItemModel(
        chatId: '1',
        name: 'Abhishek',
        lastMessage: 'Hello',
        time: '${DateTime.now().subtract(const Duration(hours: 1))}',
        unreadCount: 1,
      ),
      /*ChatHistory(
        userId: '2',
        name: 'Rahul',
        lastMessage: 'See you tomorrow',
        lastTime: DateTime.now().subtract(const Duration(hours: 1)),
        unreadCount: 0,
      ),*/
    ]);

    isLoading(false);

    /// restore scroll
    Future.delayed(const Duration(milliseconds: 50), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(_lastOffset);
      }
    });
  }

  void addOrUpdateChat({
    required String chatId,
    required String name,
    required String message,
    required String time,
    required int unreadCount,
  }) {
    final index = chats.indexWhere((c) => c.chatId == chatId);

    final chat = ChatHistoryListItemModel(
      chatId: chatId,
      name: name,
      lastMessage: message,
      time: time,
      unreadCount: unreadCount,
    );

    if (index == -1) {
      // 🆕 new chat → add on top
      chats.insert(0, chat);
    } else {
      // 🔁 existing chat → update & move to top
      chats.removeAt(index);
      chats.insert(0, chat);
    }
  }
}
