import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/utils/custom_snackbar.dart';
import 'package:pet_project/src/common/utils/validation.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';
import 'package:pet_project/src/router/routes.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Reset Password",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 20,
                color: colorScheme(context).onSurface,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Password",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: colorScheme(context).onSurface),
              ),
              const SizedBox(height: 5),
              Text(
                'password_instruction'.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme(context).outline.withOpacity(0.7)),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: newPassword,
                validator: (value) => Validation.passwordValidation(value),
                fillColor: colorScheme(context).surface,
                inputAction: TextInputAction.next,
                borderColor: colorScheme(context).onSurface.withOpacity(0.5),
                hint: 'enter_password'.tr(),
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(0.5),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: confirmPassword,
                validator: (value) =>
                    Validation.confirmPassword(value, newPassword.text),
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(0.5),
                hint: 'enter_confirm_password'.tr(),
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(0.5),
              ),
              const SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    showSnackbar(message: "Message reset successfully");
                    MyAppRouter.clearAndNavigate(context, AppRoute.signIn);
                    newPassword.clear();
                    confirmPassword.clear();
                  }
                },
                text: 'next'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
