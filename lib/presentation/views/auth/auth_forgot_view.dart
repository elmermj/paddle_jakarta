import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/views/auth/auth_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/custom_app_bar.dart';
import 'package:paddle_jakarta/presentation/widgets/custom_text_field.dart';
import 'package:paddle_jakarta/utils/themes/sporty_elegant_minimal_theme.dart';
import 'package:stacked/stacked.dart';

class AuthForgotView extends StackedView<AuthViewModel> {
  const AuthForgotView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: SportyElegantMinimalTheme.appBackgroundGradient(
          Theme.of(context).colorScheme.surface,
        ),
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Forgot Password',
          onBackFunction: ()=> viewModel.initializeVariables(true),
        ),
        body: _buildBody(viewModel: viewModel, context: context),
      ),
    );
  }

  _buildBody({required AuthViewModel viewModel, required BuildContext context}) {
    final Color iconColor = Theme.of(context).brightness == Brightness.dark 
                          ? Colors.white 
                          : Colors.black;
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width < 480 ? MediaQuery.of(context).size.width : 480,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: viewModel.isBouncing ? const AlignmentDirectional(0, -0.9) : const AlignmentDirectional(0, -0.7),
              child: SvgPicture.asset(
                'icons/question_marks.svg',
                width: MediaQuery.of(context).size.height < 700 ? 480 * 0.6 : 480,
                height: MediaQuery.of(context).size.height < 700 ? 480 * 0.6 : 480,
                fit: BoxFit.fitHeight,
                color: iconColor,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter your email to reset your password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  verticalSpaceMedium,
                  CustomTextField(
                    controller: viewModel.emailController, 
                    hintText: 'Your email', 
                    labelText: 'Email'
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(viewModel.isForgotEmailSent)...[
                    verticalSpaceMedium,
                    Text(
                      'We have sent you an email with a link to reset your password',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceLarge
                  ],
                  if(viewModel.isLoading)...[
                    verticalSpaceMedium,
                    const CircularProgressIndicator(),
                    verticalSpaceSmall,
                    Text(
                      'Sending email...',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceLarge
                  ],
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(bottom: 32),
                    child: IgnorePointer(
                      ignoring: viewModel.emailController.text.isEmpty || viewModel.isLoading || viewModel.isForgotEmailSent,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: viewModel.emailController.text.isEmpty || viewModel.isLoading || viewModel.isForgotEmailSent
                        ? Colors.grey
                        : null,
                          foregroundColor: viewModel.emailController.text.isEmpty || viewModel.isLoading || viewModel.isForgotEmailSent
                        ? Colors.white
                        : null
                        ),
                        onPressed: () => viewModel.onForgotPassword(),
                        child: Text(
                          !viewModel.isForgotEmailSent
                        ? 'Send'
                        : 'You will be redirected to Login page in ${viewModel.countdown} seconds'
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  @override
  AuthViewModel viewModelBuilder(
    BuildContext context,
  ) => AuthViewModel();

  @override
  void onViewModelReady(AuthViewModel viewModel) {
    super.onViewModelReady(viewModel);
    void startBounceAnimation() {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Future.delayed(const Duration(milliseconds: 850), () {
          viewModel.forgotIconBounce();
          Future.delayed(const Duration(milliseconds: 250), () async {
            viewModel.forgotIconBounce();
            startBounceAnimation();
          });
        });
      });
    }

    startBounceAnimation();
  }
}


