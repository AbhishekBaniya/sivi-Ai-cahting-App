import 'package:mini_chat/features/presentation/widgets/app_parent_widget.dart';
import 'package:mini_chat/features/presentation/widgets/app_text_widget.dart';

import '../../../../core/utils/imports_utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppParentWidget(
      resizeToAvoidBottomInset: true,
      fab: SizedBox.shrink(),
      bottomNavigationBar: SizedBox.shrink(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AppRichTextWidget().buildComplexRichText(
              textSpans: [
                TextSpan(
                  text: 'Settings',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
