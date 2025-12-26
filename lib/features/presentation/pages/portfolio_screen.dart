import 'package:mini_chat/config/res/dims.dart';
import 'package:mini_chat/features/presentation/app_routes/app_navigators.dart';
import 'package:mini_chat/features/presentation/app_routes/app_routes.dart';
import 'package:mini_chat/features/presentation/pages/chats/chats_screen.dart';
import 'package:mini_chat/features/presentation/widgets/app_parent_widget.dart';
import 'package:mini_chat/features/presentation/widgets/extension_sizedbox_widget.dart';

import '../../../core/utils/imports_utils.dart';
import '../controller/portfolio_controller.dart';
import '../widgets/app_circular_indicator_widget.dart';
import '../widgets/app_custom_appbar_widget.dart';
import '../widgets/app_text_widget.dart';
import 'chat_history/chat_history_screen.dart';

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
                    AnimatedSize(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                      child: controller.isVisible.value
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
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
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: controller.scrollController,
                        padding: EdgeInsets.all(Dim.doubleZero),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final item = comments[index];
                          return controller.selectedIndex.value == 0
                              ? ListTile(
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
                                                  text: controller
                                                      .getFirstLetter(
                                                        item
                                                                .userEntity
                                                                ?.fullName ??
                                                            '',
                                                      ),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        Dim.doubleTen *
                                                        Dim.doubleTwo,
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
                                  title: AppRichTextWidget()
                                      .buildComplexRichText(
                                        textSpans: [
                                          TextSpan(
                                            text:
                                                item.userEntity?.fullName ?? '',
                                            style: TextStyle(
                                              fontSize:
                                                  Dim.doubleEight *
                                                  Dim.doubleTwo,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                  subtitle: Obx(
                                    () => AppRichTextWidget()
                                        .buildComplexRichText(
                                          textSpans: [
                                            TextSpan(
                                              text: controller.isOnline.value
                                                  ? 'Online'
                                                  : '2 minutes ago',
                                              style: TextStyle(
                                                fontSize:
                                                    Dim.doubleSix *
                                                    Dim.doubleTwo,
                                                color: controller.isOnline.value
                                                    ? Colors.green
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    AppNavigator().navigateToAndReplace(
                                      AppRoutes.chatScreen,
                                    );
                                    controller.receiveMessage(item.body ?? '');
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: ChatListItem(
                                    name: item.userEntity?.fullName ?? '',
                                    message: item.body ?? '',
                                    time: DateTime.now().toString(),
                                    unreadCount: 2,
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
            ChatsScreen(),
            const Center(child: Text('Profile')),
          ],
        );
      }),

      fab: Obx(() {
        return Visibility(
          visible: controller.selectedIndex.value == 0 ? true : false,
          child: Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF7F7CFF), Color(0xFF165DFC)],
              ),
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        );
      }),
    );
  }
}
