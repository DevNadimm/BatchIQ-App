import 'package:batchiq_app/features/auth/screens/sign_up_screen.dart';
import 'package:batchiq_app/features/auth/widgets/auth_divider.dart';
import 'package:batchiq_app/features/auth/widgets/social_button.dart';
import 'package:batchiq_app/features/auth/widgets/auth_footer.dart'; // Import the AuthFooter widget
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Text(
                "Welcome back!",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "It's great to have you back with us again!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const AuthDivider(
                label: 'or sign in with',
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: SocialButton(
                      onTap: () {},
                      imgPath: 'assets/logos/google.png',
                      label: 'Google',
                      context: context,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SocialButton(
                      onTap: () {},
                      imgPath: 'assets/logos/facebook.png',
                      label: 'Facebook',
                      context: context,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              AuthFooter(
                label: "Don't have an account? ",
                actionText: "Sign Up",
                onTap: () {
                  Get.to(const SignUpScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
