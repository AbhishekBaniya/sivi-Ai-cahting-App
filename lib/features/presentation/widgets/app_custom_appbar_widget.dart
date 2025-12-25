import '../../../config/res/dims.dart';
import '../../../core/utils/imports_utils.dart';

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
          height: 44,
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

PreferredSizeWidget customAppBar() => PreferredSize(
  preferredSize: Size(double.infinity, kToolbarHeight),
  child: SizedBox(
    height: Dim.doubleEight * Dim.doubleSeven,
    child: Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(Dim.doubleFive * Dim.doubleTen),
        //color: Colors.amberAccent,
      ),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dim.doubleFive * Dim.doubleTen),
          color: Colors.pink,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    Dim.doubleFive * Dim.doubleTen,
                  ),
                ),
                height: 50,
                child: Text("Users"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(
                  Dim.doubleFive * Dim.doubleTen,
                ),
              ),
              height: 50,
              child: Text("Chat History"),
            ),
          ],
        ),
      ),
    ),
  ),
);

Widget _segmentItem({
  required String text,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
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
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.black : Colors.grey.shade600,
          ),
        ),
      ),
    ),
  );
}
