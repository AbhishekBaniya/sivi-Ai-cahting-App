import '../../../core/utils/app_logger.dart';
import '../../../core/utils/imports_utils.dart';
import '../../domain/entities/portfolio_entity.dart';
import '../../domain/usecases/get_portfolio.dart';

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

  @override
  void onInit() {
    fetchPortfolio();
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
