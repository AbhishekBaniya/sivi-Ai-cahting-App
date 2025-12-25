import 'package:mini_chat/features/presentation/widgets/app_parent_widget.dart';

import '../../../core/utils/imports_utils.dart';
import '../controller/portfolio_controller.dart';
import '../widgets/app_circular_indicator_widget.dart';
import '../widgets/app_text_widget.dart';

class PortfolioScreen extends StatelessWidget {
  PortfolioScreen({super.key});

  final PortfolioController controller = Get.put(
    PortfolioController(getPortfolio: Get.find()),
  );

  @override
  Widget build(BuildContext context) {
    //final List<int> colorCodes = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];

    return AppParentWidget(
      //appBar: AppBar(title: const Text('Portfolio'), centerTitle: false, leading: const Icon(Icons.list),),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: RandomColorProgressIndicator());
        } else if (controller.hasError.value) {
          return const Center(child: Text('Error loading portfolio'));
        } else {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: controller.portfolioItems.length,
            itemBuilder: (context, index) {
              final item = controller.portfolioItems[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    //color: Colors.amber[colorCodes[index]],
                    child: AppRichTextWidget().buildComplexRichText(
                      textSpans: [TextSpan(text: 'Entry ${item.name}')],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(color: Colors.transparent),
          );
        }
      }),
    );
  }
}
