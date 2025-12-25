import '../../../../core/utils/imports_utils.dart';
import '../../controller/auth/app_auth_controller.dart';
import '../../widgets/extension_sizedbox_widget.dart';

class AppSignInScreen extends StatelessWidget {
  final userNameController,
      userMobileNumberController,
      userEmailIdController,
      userPasswordController,
      confirmPasswordController;
  const AppSignInScreen({
    super.key,
    required this.userNameController,
    required this.userMobileNumberController,
    required this.userEmailIdController,
    required this.userPasswordController,
    required this.confirmPasswordController,
  });

  /*@override
  Widget build(BuildContext context) => AppParentWidget(
    resizeToAvoidBottomInset: true,
    body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      AppRichTextWidget().buildComplexRichText(textSpans: [TextSpan(text: Strings.signIn,),], textAlign: TextAlign.left,),
      20.heightBox,
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dim.padding, horizontal: Dim.padding,),
        child: Obx(()=> AppTextFormFieldWidget(
          controller: userNameController,
          keyboardType: TextInputType.name,
          readOnly: false,
          enabled: true,
          style: TextStyle(fontSize: Dim.paddingLarge, color: ColorManager.primaryTextColor,),
          textAlign: TextAlign.left,
          decoration: InputDecoration(label: AppRichTextWidget().buildComplexRichText(textSpans: [TextSpan(text: Strings.userName, style: TextStyle(color: ColorManager.primaryTextColor, fontSize: Dim.paddingLarge, backgroundColor: Colors.redAccent),),],),  border: const OutlineInputBorder(), ),
        ),),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dim.padding, horizontal: Dim.padding,),
        child: Obx(()=> AppTextFormFieldWidget(
          controller: userMobileNumberController,
          keyboardType: TextInputType.name,
          readOnly: false,
          enabled: true,
          style: TextStyle(fontSize: Dim.paddingLarge, color: ColorManager.primaryTextColor,),
          textAlign: TextAlign.left,
          decoration: InputDecoration(label: AppRichTextWidget().buildComplexRichText(textSpans: [TextSpan(text: Strings.userMobileNumber, style: TextStyle(color: ColorManager.primaryTextColor, fontSize: Dim.paddingLarge, backgroundColor: Colors.redAccent),),],),  border: const OutlineInputBorder(), ),
        ),),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dim.padding, horizontal: Dim.padding,),
        child: Obx(()=> AppTextFormFieldWidget(
          controller: userEmailIdController,
          keyboardType: TextInputType.name,
          readOnly: false,
          enabled: true,
          style: TextStyle(fontSize: Dim.paddingLarge, color: ColorManager.primaryTextColor,),
          textAlign: TextAlign.left,
          decoration: InputDecoration(label: AppRichTextWidget().buildComplexRichText(textSpans: [TextSpan(text: Strings.userEmailId, style: TextStyle(color: ColorManager.primaryTextColor, fontSize: Dim.paddingLarge, backgroundColor: Colors.redAccent),),],),  border: const OutlineInputBorder(), ),
        ),),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dim.padding, horizontal: Dim.padding,),
        child: Obx(()=> AppTextFormFieldWidget(
          controller: userPasswordController,
          keyboardType: TextInputType.name,
          readOnly: false,
          enabled: true,
          style: TextStyle(fontSize: Dim.paddingLarge, color: ColorManager.primaryTextColor,),
          textAlign: TextAlign.left,
          decoration: InputDecoration(label: AppRichTextWidget().buildComplexRichText(textSpans: [TextSpan(text: Strings.userPassword, style: TextStyle(color: ColorManager.primaryTextColor, fontSize: Dim.paddingLarge, backgroundColor: Colors.redAccent),),],),  border: const OutlineInputBorder(), ),
        ),),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dim.padding, horizontal: Dim.padding,),
        child: Obx(()=> AppTextFormFieldWidget(
          controller: confirmPasswordController,
          keyboardType: TextInputType.name,
          readOnly: false,
          enabled: true,
          style: TextStyle(fontSize: Dim.paddingLarge, color: ColorManager.primaryTextColor,),
          textAlign: TextAlign.left,
          decoration: InputDecoration(label: AppRichTextWidget().buildComplexRichText(textSpans: [TextSpan(text: Strings.confirmPassword, style: TextStyle(color: ColorManager.primaryTextColor, fontSize: Dim.paddingLarge, backgroundColor: Colors.redAccent),),],),  border: const OutlineInputBorder(), ),
        ),),
      ),
      20.heightBox,

    ],),
  );*/

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
            _buildTextField('Name'),
            _buildTextField('Mobile'),
            _buildTextField('Email'),
            _buildTextField('Password'),
            _buildTextField('Confirm Password'),
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

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
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
