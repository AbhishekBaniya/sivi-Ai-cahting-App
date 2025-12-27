import 'package:intl/intl.dart';

import '../../../../config/res/dims.dart';
import '../../../../core/utils/imports_utils.dart';
import '../../controller/chat_history/chat_history_controller.dart';
import '../../widgets/app_text_widget.dart';
import '../../widgets/extension_sizedbox_widget.dart';

class ChatHistoryScreen extends StatelessWidget {
  final String name, message;
  final int unreadCount;

  ChatHistoryScreen({
    super.key,
    required this.name,
    required this.message,
    required this.unreadCount,
  });

  final controller = Get.put(ChatHistoryController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
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
                  Color(0xFF02C570),
                  Color(0xFF02C381),
                  Color(0xFF02C18D),
                ],
              ),
            ),
            child: AppRichTextWidget().buildComplexRichText(
              textSpans: [
                TextSpan(
                  text: controller.getFirstLetter(name),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dim.doubleTen * Dim.doubleTwo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          12.widthBox,

          // Name & message
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppRichTextWidget().buildComplexRichText(
                  textSpans: [
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        fontSize: Dim.doubleEight * Dim.doubleTwo,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                Dim.doubleFour.heightBox,

                AppRichTextWidget().buildComplexRichText(
                  textSpans: [
                    TextSpan(
                      text: message,
                      style: TextStyle(
                        fontSize: Dim.doubleSix * Dim.doubleTwo,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          8.widthBox,

          // Time & unread badge
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('EEE h:mm a').format(DateTime.now()),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              6.heightBox,
              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF165DFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/*class ChatListItems extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadCount;

  ChatListItems({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.unreadCount,
  });

  final controller = Get.find<ChatListController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xFF02C570),
                  Color(0xFF02C381),
                  Color(0xFF02C18D),
                ],
              ),
            ),
            child: Text(
              controller.getFirstLetter(name),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 6),
              if (unreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF165DFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}*/
