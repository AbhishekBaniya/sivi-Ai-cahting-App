import 'package:flutter/rendering.dart';
import 'package:mini_chat/features/presentation/app_routes/app_navigators.dart';

import '../../../core/utils/app_logger.dart';
import '../../../core/utils/imports_utils.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/usecases/get_portfolio.dart';
import '../widgets/animated_dialog_widget.dart';

class PortfolioController extends GetxController {
  final GetPortfolio getPortfolio;
  PortfolioController({required this.getPortfolio});

  final portfolio = Rxn<PortfolioEntity>();

  //var portfolioItems = <PortfolioEntity>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;
  var selectedIndex = 0.obs;
  var bottomNavSelectedIndex = 0.obs;
  var isOnline = true.obs;
  var name = TextEditingController().obs;

  final ScrollController scrollController = ScrollController();
  final RxBool isVisible = true.obs;

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

  String getFirstLetter(String text) {
    final trimmed = text.trimLeft();
    if (trimmed.isEmpty) return '?';
    return trimmed[0].toUpperCase();
  }

  void addUser({required String fullName}) {
    AppNavigator().goBack(isBack: true);

    portfolio.value = PortfolioEntity(
      comments: [
        ...?portfolio.value?.comments,
        CommentsEntity(userEntity: UserEntity(fullName: fullName)),
      ],
    );

    Get.snackbar(
      'User added',
      'User added successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }

  void openInputDialog() {
    Get.dialog(AnimatedInputDialog(), barrierDismissible: true);
  }
}
