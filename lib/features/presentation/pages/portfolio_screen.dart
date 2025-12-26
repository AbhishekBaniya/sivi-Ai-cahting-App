import 'package:mini_chat/config/res/dims.dart';
import 'package:mini_chat/features/presentation/widgets/app_parent_widget.dart';
import 'package:mini_chat/features/presentation/widgets/extension_sizedbox_widget.dart';

import '../../../core/utils/imports_utils.dart';
import '../controller/portfolio_controller.dart';
import '../widgets/app_circular_indicator_widget.dart';
import '../widgets/app_custom_appbar_widget.dart';
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
        return IndexedStack(
          index: controller.bottomNavSelectedIndex.value,
          children: <Widget>[
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: RandomColorProgressIndicator());
              } else if (controller.hasError.value) {
                return const Center(child: Text('Error loading portfolio'));
              } else {
                final comments = controller.portfolio.value?.comments ?? [];
                return Column(
                  children: [
                    16.heightBox,
                    segmentedAppBar(
                      selectedIndex: controller.selectedIndex.value,
                      onChanged: (int index) {
                        controller.selectedIndex.value = index;
                      },
                    ),
                    16.heightBox,
                    Divider(
                      color: Colors.black26,
                      thickness: Dim.doubleOne,
                      height: Dim.doubleOne,
                      indent: 1,
                    ),

                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(Dim.doubleZero),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final item = comments[index];
                          return ListTile(
                            leading: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF7F7CFF),
                                        Color(0xFF9B59B6),
                                      ],
                                    ),
                                  ),
                                  child: AppRichTextWidget()
                                      .buildComplexRichText(
                                        textSpans: [
                                          TextSpan(
                                            text: controller.getFirstLetter(
                                              item.userEntity?.fullName ?? '',
                                            ),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  Dim.doubleTen * Dim.doubleTwo,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                ),
                                if (controller.isOnline.value)
                                  Positioned(
                                    bottom: -1,
                                    right: -1,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            title: AppRichTextWidget().buildComplexRichText(
                              textSpans: [
                                TextSpan(
                                  text: item?.userEntity?.fullName ?? '',
                                  style: TextStyle(
                                    fontSize: Dim.doubleEight * Dim.doubleTwo,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Obx(
                              () => AppRichTextWidget().buildComplexRichText(
                                textSpans: [
                                  TextSpan(
                                    text: controller.isOnline.value
                                        ? 'Online'
                                        : '2 minutes ago',
                                    style: TextStyle(
                                      fontSize: Dim.doubleSix * Dim.doubleTwo,
                                      color: controller.isOnline.value
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(color: Colors.transparent),
                      ),
                    ),
                  ],
                );
              }
            }),
            const Center(child: Text('Chat')),
            const Center(child: Text('Profile')),
          ],
        );
      }),
    );
  }
}

class UserHeader extends StatelessWidget {
  final String name;
  final bool isOnline;

  const UserHeader({super.key, required this.name, this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /*const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.trim(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                fontSize: 12,
                color: isOnline ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),*/
      ],
    );
  }
}
