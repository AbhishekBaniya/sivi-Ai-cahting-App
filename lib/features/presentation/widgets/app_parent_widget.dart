import '../../../core/utils/imports_utils.dart';
import 'app_custom_appbar_widget.dart';

class AppParentWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final bool? safeTop,
      safeBottom,
      safeLeft,
      safeRight,
      resizeToAvoidBottomInset;
  final Widget? body, bottomNavigationBar;
  const AppParentWidget({
    super.key,
    this.appBar,
    this.resizeToAvoidBottomInset,
    this.body,
    this.bottomNavigationBar,
    this.safeTop,
    this.safeBottom,
    this.safeLeft,
    this.safeRight,
  });
  //final parentKey = GlobalKey();

  @override
  Widget build(BuildContext context) => SafeArea(
    top: safeTop ?? false,
    bottom: safeBottom ?? false,
    left: safeLeft ?? false,
    right: safeRight ?? false,
    //key: parentKey,
    child: Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar:
          appBar ??
          segmentedAppBar(
            selectedIndex: 1,
            onChanged: (int index) {
              /*setState(() {
              selectedIndex = index;
            });*/
            },
          ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    ),
  );
}
