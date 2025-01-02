import 'package:batchiq_app/features/auth/screens/sign_in_screen.dart';
import 'package:batchiq_app/features/auth/widgets/auth_divider.dart';
import 'package:batchiq_app/features/auth/widgets/social_button.dart';
import 'package:batchiq_app/features/auth/widgets/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                "Create an Account",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "Join us and get started today!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  labelText: "Name",
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const AuthDivider(
                label: 'or sign up with',
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
                label: "Already have an account? ",
                actionText: "Sign In",
                onTap: () {
                  Get.to(const SignInScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
