import '../../../../config/res/dims.dart';
import '../../../../config/res/strings.dart';
import '../../../../core/utils/imports_utils.dart';
import '../../controller/auth/app_auth_controller.dart';
import '../../widgets/app_parent_widget.dart';
import '../../widgets/app_text_widget.dart';
import '../../widgets/app_textformfield_widget.dart';
import '../../widgets/extension_sizedbox_widget.dart';

class AppSignUpScreen extends StatelessWidget {
  const AppSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => AppParentWidget(
    resizeToAvoidBottomInset: true,
    body: Column(
      children: <Widget>[
        AppRichTextWidget().buildComplexRichText(
          textSpans: [TextSpan(text: Strings.signIn)],
          textAlign: TextAlign.left,
        ),
        20.heightBox,
        _buildTextField(Strings.userName),
        _buildTextField(Strings.userMobileNumber),
        _buildTextField(Strings.userEmailId),
        _buildTextField(Strings.userPassword),
        _buildTextField(Strings.confirmPassword),
        20.heightBox,
      ],
    ),
  );

  Widget _buildTextField(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dim.padding,
        horizontal: Dim.padding,
      ),
      child: AppTextFormFieldWidget(
        controller: Get.find<AppAuthController>().nameController.value,
        keyboardType: TextInputType.name,
        readOnly: false,
        style: TextTheme.of(Get.context!).titleMedium,
        decoration: InputDecoration(
          label: AppRichTextWidget().buildRichText(text1: label),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
