import 'package:flutter/material.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/router/routes.dart';

class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Verify Email",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 20,
              color: colorScheme(context).onSurface // Customize color

              ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.email_outlined,
                size: 80,
                color: colorScheme(context).onSurface,
              ),
              const SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                "Verify your email address",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: colorScheme(context).onSurface),
              ),
              const SizedBox(height: 12),
              Text(
                "We have just sent a verification link to your email. "
                "Please check your email and click on that link to verify "
                "your email address.",
                textAlign: TextAlign.center,
                style: textTheme(context).bodyLarge?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.6)
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(onTap: () {
                MyAppRouter.clearAndNavigate(context, AppRoute.resetPasswordPage);
              }, text: "Verify"),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // Handle resend email link press
                },
                child: Text(
                  "Resend Email Link",
                  style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).primary
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
