import '../../../../core/utils/app_logger.dart';
import '../../../../core/utils/imports_utils.dart';

class AppAuthController extends GetxController {
  var isSignUp = true.obs; // Switch between sign-up and sign-in
  var nameController = TextEditingController().obs;
  var userMobileNumberController = TextEditingController().obs;
  var userEmailIdController = TextEditingController().obs;
  var userPasswordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;

  //final _auth = FirebaseAuth.instance;
  //late final Rx<User?> firebaseUser;

  @override
  void onInit() {
    super.onInit();
    Logger().info("AppAuthController OnInit() Called");
  }

  @override
  void onReady() {
    super.onReady();
    /*firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    */
    Logger().info("AppAuthController onReady() Called");
  }

  @override
  void onClose() {
    super.onClose();
    Logger().info("AppAuthController onClose() Called");
  }

  void toggleAuthMode() {
    isSignUp.value = !isSignUp.value;
  }

  /*_setInitialScreen (User? user) {
    user == null ? Get.offAll(()=>const SignInScreen()) : Get.offAll(()=> PortfolioScreen());
  }

  Future<void> createUserWithPassEmail ({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {
    }
  }

  Future<void> loginUserWithPassEmail ({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {
    }
  }


  Future<void> loginOutl ({required String email, required String password}) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
    } catch (_) {
    }
  }*/
}
