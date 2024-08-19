import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/views/auth/auth_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/custom_text_field.dart';

class AuthForm extends StatelessWidget {
  final AuthViewModel viewModel;
  final int index;
  const AuthForm({
    super.key,
    required this.viewModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    switch(index){
      case 0:
       return ListView(
        shrinkWrap: true,
        children: [
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
            isPassword: true,
           ),
           verticalSpaceSmall,
           Align(
             alignment: Alignment.centerRight,
             child: TextButton(
               onPressed: () {},
               child: const Text('Forgot password?'),
             ),
           ),
           verticalSpaceSmall,
           ElevatedButton(
             onPressed: () => viewModel.onLogin(),
             child: const Text('Login'),
           ),
         ],
       );
      case 1:
        return ListView(
          shrinkWrap: true,
          children: [
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
              isPassword: true,
            ),
            verticalSpaceSmall,
            CustomTextField(
              labelText: 'Confirm Password',
              controller: viewModel.passwordConfirmController,
              hintText: 'Confirm Password',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            verticalSpaceSmall,
            ElevatedButton(
              onPressed: () => viewModel.onRegister(),
              child: const Text('Register'),
            ),
          ]
        );
      default: 
        return const CircularProgressIndicator();
    } 
  }
}
