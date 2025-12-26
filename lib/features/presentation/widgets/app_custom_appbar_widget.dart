import '../../../core/utils/imports_utils.dart';
import 'app_text_widget.dart';

PreferredSizeWidget segmentedAppBar({
  required int selectedIndex,
  required Function(int) onChanged,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    title: LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth > 400
            ? 360.0
            : constraints.maxWidth * 0.9;

        return Container(
          width: width,
          height: 56,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              _segmentItem(
                text: "Users",
                isSelected: selectedIndex == 0,
                onTap: () => onChanged(0),
              ),
              _segmentItem(
                text: "Chat History",
                isSelected: selectedIndex == 1,
                onTap: () => onChanged(1),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget _segmentItem({
  required String text,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        //duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: AppRichTextWidget().buildComplexRichText(
          textSpans: [
            TextSpan(
              text: text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.black : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
