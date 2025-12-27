import 'package:mini_chat/features/presentation/widgets/app_text_widget.dart';

import '../../../../config/res/dims.dart';
import '../../../../core/utils/imports_utils.dart';
import '../../../data/model/chat_model.dart';
import '../../app_routes/app_navigators.dart';
import '../../controller/chats/chat_controller.dart';
import '../../widgets/app_circular_indicator_widget.dart';
import '../../widgets/app_parent_widget.dart';
import '../../widgets/extension_sizedbox_widget.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  final controller = Get.put(ChatController());
  final args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return AppParentWidget(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SizedBox.shrink(),
      // appBar: AppBar(
      //   title: const Text('Portfolio'),
      //   centerTitle: false,
      //   leading: const Icon(Icons.list),
      // ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: RandomColorProgressIndicator());
        } else if (controller.hasError.value) {
          return const Center(child: Text('Error loading Chats'));
        } else {
          //final comments = controller.portfolio.value?.comments ?? [];
          return SafeArea(
            child: Column(
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                  child: controller.isVisible.value
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            16.heightBox,
                            chatHeader(name: "${args['name']}", isOnline: true),
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
                  child: Obx(
                    () => ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: controller.messages.length,
                      itemBuilder: (_, index) {
                        final msg = controller.messages[index];
                        return msg.isMe ? senderTile(msg) : receiverTile(msg);
                      },
                    ),
                  ),
                ),

                typingIndicator(),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.textController.value,
                          onChanged: (v) => controller.onChanged(v),
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          controller.sendMessage(
                            controller.textController.value.text,
                          );
                          controller.textController.value.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget chatHeader({
    required String name,
    required bool isOnline,
    VoidCallback? onBack,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Row(
        children: [
          // Back Arrow
          GestureDetector(
            onTap: () {
              AppNavigator().goBack(isBack: true);
            },
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.keyboard_backspace, size: 24),
            ),
          ),

          8.widthBox,
          // Avatar with Gradient
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF7F7CFF), Color(0xFF9B59B6)],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),

          12.widthBox,
          // Name + Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isOnline ? 'Online' : 'Last seen recently',
                  style: TextStyle(
                    fontSize: 12,
                    color: isOnline ? Colors.green : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget receiverTile(ChatMessage message) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF7F7CFF), Color(0xFF9B59B6)],
          ),
        ),
        child: Text(
          controller.getFirstLetter('${args['name']}'),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Get.width * 0.7),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRichTextWidget().buildComplexRichText(
                  textSpans: [
                    TextSpan(
                      text: message.text,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: AppRichTextWidget().buildComplexRichText(
          textSpans: [
            TextSpan(
              text: TimeOfDay.fromDateTime(message.time).format(Get.context!),
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget senderTile(ChatMessage message) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      trailing: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFC04AEC), Color(0xFFDC47C3)],
          ),
        ),
        child: Text(
          'Y',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Get.width * 0.5),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4F7CFF), Color(0xFF165DFC)],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppRichTextWidget().buildComplexRichText(
                  textSpans: [
                    TextSpan(
                      text: message.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      subtitle: Align(
        alignment: Alignment.centerRight,
        child: AppRichTextWidget().buildComplexRichText(
          textSpans: [
            TextSpan(
              text: TimeOfDay.fromDateTime(message.time).format(Get.context!),
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget onlineStatus() {
    return Obx(() {
      if (controller.isOnline.value) {
        return const Text(
          'Online',
          style: TextStyle(color: Colors.green, fontSize: 12),
        );
      } else {
        return Text(
          'Last seen ${TimeOfDay.fromDateTime(controller.lastSeen.value).format(Get.context!)}',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        );
      }
    });
  }

  Widget typingIndicator() {
    return Obx(
      () => controller.isTyping.value
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Typing...',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
