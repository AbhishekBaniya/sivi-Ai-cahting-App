import '../../../core/utils/imports_utils.dart';
import 'app_custom_navbar_widget.dart';

class AppParentWidget extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final bool? safeTop,
      safeBottom,
      safeLeft,
      safeRight,
      resizeToAvoidBottomInset;
  final Widget? body, bottomNavigationBar, fab;

  const AppParentWidget({
    super.key,
    this.appBar,
    this.safeTop,
    this.safeBottom,
    this.safeLeft,
    this.safeRight,
    this.resizeToAvoidBottomInset,
    this.body,
    this.bottomNavigationBar,
    this.fab,
  });

  @override
  State<AppParentWidget> createState() => _AppParentWidgetState();
}

class _AppParentWidgetState extends State<AppParentWidget> {
  int selectedIndex = 0, currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: widget.safeTop ?? false,
      bottom: widget.safeBottom ?? false,
      left: widget.safeLeft ?? false,
      right: widget.safeRight ?? false,
      //key: parentKey,
      child: Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        appBar: widget.appBar,
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.white,
        //   centerTitle: true,
        //   title: LayoutBuilder(
        //     builder: (context, constraints) {
        //       final width = constraints.maxWidth > 400
        //           ? 360.0
        //           : constraints.maxWidth * 0.9;
        //
        //       return CupertinoPageScaffold(
        //         // We use a Stack to display the tab bar in front of the tab content.
        //         child: Stack(
        //           children: [
        //             Center(
        //               child: CupertinoTabTransitionBuilder(
        //                 child: _pages.elementAt(selectedIndex),
        //               ),
        //             ),
        //             Align(
        //               alignment: Alignment.topCenter,
        //               child: SafeArea(
        //                 // [CupertinoFloatingTabBar] takes the nearest [DefaultTabController] as its controller.
        //                 // Alternately you can pass the controller explicitly.
        //                 child: DefaultTabController(
        //                   length: 1,
        //                   child: Builder(
        //                     builder: (context) {
        //                       return CupertinoFloatingTabBar(
        //                         // Use a material instead of a static color. This creates a blur effect behind the bar.
        //                         isVibrant: true,
        //                         onDestinationSelected: (value) {
        //                           // Update the selected index.
        //                           setState(() {
        //                             selectedIndex = value;
        //                           });
        //                         },
        //                         // A list of tabs to be displayed as the tab bar.
        //                         tabs: [
        //                           const CupertinoFloatingTab(
        //                             child: Text('Users'),
        //                           ),
        //                           const CupertinoFloatingTab(
        //                             child: Text('Chat History'),
        //                           ),
        //                         ],
        //                       );
        //                     },
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       );
        //       return Container(
        //         width: width,
        //         height: 44,
        //         padding: const EdgeInsets.all(4),
        //         decoration: BoxDecoration(
        //           color: Colors.grey.shade200,
        //           borderRadius: BorderRadius.circular(30),
        //         ),
        //         // child: Row(
        //         //   children: [
        //         //     _segmentItem(
        //         //       text: "Users",
        //         //       isSelected: selectedIndex == 0,
        //         //       onTap: () => onChanged(0),
        //         //     ),
        //         //     _segmentItem(
        //         //       text: "Chat History",
        //         //       isSelected: selectedIndex == 1,
        //         //       onTap: () => onChanged(1),
        //         //     ),
        //         //   ],
        //         // ),
        //       );
        //     },
        //   ),
        // ),
        body: widget.body,
        floatingActionButton: widget.fab,
        bottomNavigationBar: widget.bottomNavigationBar ?? CustomBottomNav(),
      ),
    );
  }
}

/*class AppParentWidget extends StatelessWidget {

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
              */ /*setState(() {
              selectedIndex = index;
            });*/ /*
            },
          ),
      body: body,
      bottomNavigationBar:
          bottomNavigationBar ??
          CustomBottomNav(
            currentIndex: 0,
            onTap: (index) {
              */ /*setState(() {
                currentIndex = index;
              });*/ /*
            },
          ),
    ),
  );
}*/
