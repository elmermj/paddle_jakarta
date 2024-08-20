import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/views/auth/auth_forgot_view.dart';
import 'package:paddle_jakarta/presentation/views/auth/auth_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/custom_text_field.dart';

class AuthForm extends StatelessWidget {
  final AuthViewModel viewModel;
  final int index;
  final Widget emailLoginWidget;
  final Widget emailRegisterWidget;
  final Widget googleLoginWidget;
  final List<IconButton> suffixIcons;
  final List<bool> isPasswords;
  const AuthForm({
    super.key,
    required this.viewModel,
    required this.index,
    required this.googleLoginWidget,
    required this.emailLoginWidget,
    required this.emailRegisterWidget,
    required this.suffixIcons,
    required this.isPasswords,
  });

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return ListView(
          shrinkWrap: true,
          children: [
            Text(
              'Login',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            verticalSpaceMedium,
            CustomTextField(
              labelText: 'Email',
              controller: viewModel.emailController,
              hintText: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            verticalSpaceSmall,
            CustomTextField(
              labelText: 'Password',
              controller: viewModel.passwordController,
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              isPassword: !isPasswords[0],
              suffixIcon: suffixIcons[0],
            ),
            verticalSpaceSmall,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthForgotView(),
                  ),
                ),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
            ),
            verticalSpaceSmall,
            ...[emailLoginWidget],
            verticalSpaceSmall,
            const Align(alignment: Alignment.center, child: Text('or')),
            verticalSpaceSmall,
            ...[googleLoginWidget]
          ],
        );
      case 1:
        return Scrollbar(
          thumbVisibility: true,
          child: ListView(
            primary: true,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(right: 16),
            children: [
              Text(
                'Register',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              verticalSpaceMedium,
              CustomTextField(
                labelText: 'Name',
                controller: viewModel.nameController,
                hintText: 'Name',
                keyboardType: TextInputType.name,
              ),
              verticalSpaceSmall,
              CustomTextField(
                labelText: 'Email',
                controller: viewModel.emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              verticalSpaceSmall,
              CustomTextField(
                labelText: 'Confirm Email',
                controller: viewModel.emailConfirmController,
                hintText: 'Confirm Your Email',
                keyboardType: TextInputType.emailAddress,
              ),
              verticalSpaceSmall,
              CustomTextField(
                labelText: 'Phone Number',
                controller: viewModel.phoneNumberController,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              verticalSpaceSmall,
              CustomTextField(
                labelText: 'Password',
                controller: viewModel.passwordController,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                isPassword: !isPasswords[0],
                suffixIcon: suffixIcons[0],
              ),
              verticalSpaceSmall,
              CustomTextField(
                  labelText: 'Confirm Password',
                  controller: viewModel.passwordConfirmController,
                  hintText: 'Confirm Password',
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: !isPasswords[1],
                  suffixIcon: suffixIcons[1]),
              verticalSpaceSmall,
              ...[emailRegisterWidget],
              verticalSpaceSmall,
              const Align(alignment: Alignment.center, child: Text('or')),
              verticalSpaceSmall,
              ...[googleLoginWidget]
            ]
          ),
        );
      default:
        return const CircularProgressIndicator();
    }
  }
}
