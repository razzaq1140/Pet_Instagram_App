import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/utils/validation.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';
import 'package:pet_project/src/router/routes.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "email".tr(),
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 20,
              color: colorScheme(context).onSurface // Customize color

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
              const SizedBox(
                height: 30,
              ),
              Text(
                'enter_email'.tr(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: colorScheme(context).onSurface),
              ),
              // const SizedBox(height:),

              const SizedBox(height: 5),
              Text(
                'verification_email_message'.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme(context).outline.withOpacity(0.7)),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                controller: emailController,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(0.5),
                hint: 'email@official.com',
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(0.5),
                validator: Validation.emailValidation,
                keyboardType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
              ),

              const SizedBox(height: 20),
              CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.pushNamed(AppRoute.verifyEmailPage);
                    emailController.clear();
                  }
                },
                text: 'next'.tr(),
              ),
              const SizedBox(
                height: 20,
              ),
              // const Text("Back to Login")
            ],
          ),
        ),
      ),
    );
  }
}
