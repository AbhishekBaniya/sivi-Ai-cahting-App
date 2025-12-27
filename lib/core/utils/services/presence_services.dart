import 'package:cloud_firestore/cloud_firestore.dart';

import '../imports_utils.dart';
import 'local_user_service.dart';

class PresenceService extends GetxService with WidgetsBindingObserver {
  late String uid;

  @override
  void onInit() async {
    uid = await LocalUserService.getUserId();
    WidgetsBinding.instance.addObserver(this);
    _update(true);
    super.onInit();
  }

  void _update(bool online) {
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'isOnline': online,
      'lastSeen': FieldValue.serverTimestamp(),
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _update(state == AppLifecycleState.resumed);
  }
}
