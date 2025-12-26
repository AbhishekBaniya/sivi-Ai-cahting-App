import '../../../core/utils/imports_utils.dart';
import '../controller/portfolio_controller.dart';

class CustomBottomNav extends StatelessWidget {
  // final int currentIndex;
  // final Function(int) onTap;

  CustomBottomNav({
    super.key,
    //required this.currentIndex,
    //required this.onTap,
  });

  final PortfolioController controller = Get.put(
    PortfolioController(getPortfolio: Get.find()),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(
                icon: Icons.chat_bubble_outline,
                label: "Home",
                index: 0,
                isActive: controller.bottomNavSelectedIndex.value == 0,
              ),
              _navItem(
                icon: Icons.local_offer_outlined,
                label: "Offers",
                index: 1,
                isActive: controller.bottomNavSelectedIndex.value == 1,
              ),
              _navItem(
                icon: Icons.settings_outlined,
                label: "Settings",
                index: 2,
                isActive: controller.bottomNavSelectedIndex.value == 2,
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isActive,
  }) {
    return GestureDetector(
      //onTap: () => onTap(index),
      onTap: () => controller.bottomNavSelectedIndex.value = index,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? Colors.blue : Colors.grey.shade500,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.blue : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
