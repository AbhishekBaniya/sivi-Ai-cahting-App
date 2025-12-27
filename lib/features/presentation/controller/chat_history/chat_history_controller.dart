import 'package:get/get.dart';

import '../../../../core/utils/app_logger.dart';

class ChatHistoryController extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
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
    Logger().info("PortfolioController onClose() Called");
  }

  String getFirstLetter(String text) {
    final trimmed = text.trimLeft();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }
}
