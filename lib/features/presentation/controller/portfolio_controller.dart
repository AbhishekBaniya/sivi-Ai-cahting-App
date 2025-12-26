import 'package:flutter/rendering.dart';

import '../../../core/utils/app_logger.dart';
import '../../../core/utils/imports_utils.dart';
import '../../data/model/chat_model.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/usecases/get_portfolio.dart';

class PortfolioController extends GetxController {
  final GetPortfolio getPortfolio;
  PortfolioController({required this.getPortfolio});

  final portfolio = Rxn<PortfolioEntity>();

  //var portfolioItems = <PortfolioEntity>[].obs;
  var isLoading = true.obs, isChatLoading = false.obs;
  var hasError = false.obs, hasErrorChat = false.obs;
  var selectedIndex = 0.obs;
  var bottomNavSelectedIndex = 0.obs;
  var isOnline = true.obs;

  final ScrollController scrollController = ScrollController();
  final RxBool isVisible = true.obs;

  var messages = <ChatMessage>[].obs;

  var lastSeen = DateTime.now().obs;
  var isTyping = false.obs;

  var textController = TextEditingController().obs;

  void sendMessage(String text) {
    messages.add(ChatMessage(text: text, isMe: true, time: DateTime.now()));
    isTyping(false);
  }

  void receiveMessage(String text) {
    messages.add(ChatMessage(text: text, isMe: false, time: DateTime.now()));
  }

  @override
  void onInit() {
    fetchPortfolio();
    scrollController.addListener(() {
      final direction = scrollController.position.userScrollDirection;

      if (direction == ScrollDirection.reverse) {
        if (isVisible.value) {
          isVisible.value = false;
        }
      } else if (direction == ScrollDirection.forward) {
        if (!isVisible.value) {
          isVisible.value = true;
        }
      }
    });
    super.onInit();
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

  void fetchPortfolio() async {
    isLoading(true);

    final result = await getPortfolio();

    result.fold(
      (error) {
        hasError(true);
      },
      (success) {
        portfolio.value = success;
      },
    );

    isLoading(false);
  }

  /*void fetchPortfolio() async {
    isLoading(true);
    final result = await getPortfolio();
    result.fold(
      (error) {
        hasError(true);
      },
      (success) {
        portfolioItems.assignAll(success);
      },
    );
    isLoading(false);
  }*/

  // String getFirstLetter(String text) {
  //   final trimmed = text.trimLeft();
  //   if (trimmed.isEmpty) return '?';
  //   return trimmed[0].toUpperCase();
  // }

  String getFirstLetter(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) return '?';

    return trimmed[0].toUpperCase();
  }
}
