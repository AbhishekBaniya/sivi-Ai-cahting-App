import '../../../../core/utils/imports_utils.dart';
import '../../controller/auth/app_auth_controller.dart';
import '../../widgets/app_text_widget.dart';
import '../../widgets/app_textformfield_widget.dart';
import '../../widgets/extension_sizedbox_widget.dart';

class AppAuthScreen extends StatelessWidget {
  AppAuthScreen({super.key});
  final authController = Get.put(AppAuthController()); // Initialize controller

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Center(
        child: Obx(() {
          return authController.isSignUp.value
              ? const SignUpScreen()
              : const SignInScreen();
        }),
      ),
    ),
  );
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            20.heightBox,
            _buildTextField(
              'Name',
              Get.find<AppAuthController>().nameController.value,
            ),
            _buildTextField(
              'Mobile',
              Get.find<AppAuthController>().userMobileNumberController.value,
            ),
            _buildTextField(
              'Email',
              Get.find<AppAuthController>().userEmailIdController.value,
            ),
            _buildTextField(
              'Password',
              Get.find<AppAuthController>().userPasswordController.value,
            ),
            _buildTextField(
              'Confirm Password',
              Get.find<AppAuthController>().confirmPasswordController.value,
            ),
            20.heightBox,
            _buildButton('Sign Up'),
            10.heightBox,
            GestureDetector(
              onTap: () {
                Get.find<AppAuthController>()
                    .toggleAuthMode(); // Toggle between SignUp and SignIn
              },
              child: const Text(
                'Already have an account? Sign In',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget _buildTextField(String label, controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }*/
  Widget _buildTextField(String label, controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AppTextFormFieldWidget(
        controller: controller,
        keyboardType: TextInputType.name,
        readOnly: false,
        style: TextTheme.of(Get.context!).titleMedium,
        decoration: InputDecoration(
          label: AppRichTextWidget().buildRichText(text1: label),
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press for sign up
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            20.heightBox,
            _buildTextField(
              'Email',
              Get.find<AppAuthController>().userEmailIdController.value,
            ),
            _buildTextField(
              'Password',
              Get.find<AppAuthController>().userPasswordController.value,
            ),
            20.heightBox,
            _buildButton('Sign In'),
            10.heightBox,
            GestureDetector(
              onTap: () {
                Get.find<AppAuthController>()
                    .toggleAuthMode(); // Toggle between SignUp and SignIn
              },
              child: const Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AppTextFormFieldWidget(
        controller: controller,
        keyboardType: TextInputType.name,
        readOnly: false,
        style: TextTheme.of(Get.context!).titleMedium,
        decoration: InputDecoration(
          label: AppRichTextWidget().buildRichText(text1: label),
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press for sign in
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(text),
    );
  }
}
