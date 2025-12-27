import 'package:mini_chat/features/presentation/app_routes/app_navigators.dart';
import 'package:mini_chat/features/presentation/widgets/extension_sizedbox_widget.dart';

import '../../../core/utils/imports_utils.dart';
import '../controller/portfolio_controller.dart';

class AnimatedInputDialog extends StatelessWidget {
  AnimatedInputDialog({super.key});

  final controller = Get.put(PortfolioController(getPortfolio: Get.find()));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        tween: Tween(begin: 0.8, end: 1),
        builder: (_, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: Get.width * 0.85,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: child,
              ),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            16.heightBox,
            const Text(
              'Add Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            16.heightBox,

            /// TextField 1
            TextField(
              controller: controller.name.value,
              style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Type a Full Name',
                border: OutlineInputBorder(),
              ),
            ),

            16.heightBox,

            /// Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => AppNavigator().goBack(isBack: true),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.addUser(
                      fullName: controller.name.value.text,
                    ),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
