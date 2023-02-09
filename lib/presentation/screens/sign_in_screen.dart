import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/business_logics/bloc/sign_in/sign_in_bloc.dart';

import '../components/custom_button.dart';
import '../components/custom_scaffold.dart';
import '../components/custom_text_field.dart';
import '../components/custom_text_widget.dart';
import '../route_management/routes.dart';
import '../utilities/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignInBloc signInBloc = context.watch<SignInBloc>();
    return CustomScaffold(
      onScreenTap: signInBloc.removeFocus,
      child: SingleChildScrollView(
        primary: false,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "assets/icons/app-icon.png",
                height: 50,
                width: 50,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 0.0,
              ),
              child: CustomTextWidget(
                text: "Sign In",
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                textColor: ColorConstant.kBlackColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomTextWidget(
                  text: "Email:",
                  fontSize: 18.0,
                ),
              ),
            ),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return CustomTextField(
                  focusNode: signInBloc.emailFocusNode,
                  textEditingController: signInBloc.emailController,
                  isEnabled: !state.isLoading,
                  borderColor: state.emailErrorMessage.isNotEmpty
                      ? ColorConstant.kRedColor
                      : null,
                  onInputText: (value) {
                    signInBloc.add(EmailValidationEvent());
                  },
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  elevation: 0.0,
                );
              },
            ),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.emailErrorMessage.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextWidget(
                        text: state.emailErrorMessage,
                        textColor: ColorConstant.kRedColor,
                      ),
                    ),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomTextWidget(
                  text: "Password:",
                  fontSize: 18.0,
                ),
              ),
            ),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return CustomTextField(
                  isEnabled: !state.isLoading,
                  borderColor: state.passwordErrorMessage.isNotEmpty
                      ? ColorConstant.kRedColor
                      : null,
                  onInputText: (text) {
                    signInBloc.add(PasswordValidationEvent());
                  },
                  isObscure: state.isPasswordFieldObscure,
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  suffixIcon: Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        signInBloc.add(PasswordVisibleEvent());
                      },
                      child: Icon(
                        state.isPasswordFieldObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: ColorConstant.kBlackColor,
                      ),
                    );
                  }),
                  inputType: TextInputType.visiblePassword,
                  inputAction: TextInputAction.done,
                  elevation: 0.0,
                  textEditingController: signInBloc.passwordController,
                  focusNode: signInBloc.passwordFocusNode,
                );
              },
            ),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.passwordErrorMessage.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextWidget(
                        text: state.passwordErrorMessage,
                        textColor: ColorConstant.kRedColor,
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomTextWidget(
                      text: "remember me",
                      fontSize: 14.0,
                    ),
                    BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 5.0,
                          ),
                          child: SizedBox(
                            height: 25.0,
                            width: 25.0,
                            child: Checkbox(
                              activeColor: ColorConstant.kBlackColor,
                              value: state.isRememberMeEnable,
                              onChanged: (v) {
                                if (state.isLoading) {
                                  return;
                                }
                                signInBloc.add(RememberMeEvent());
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 10.0,
              ),
              child: BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  return CustomButton(
                    isLoading: state.isLoading,
                    buttonText: "Sign In",
                    onButtonPressed: () => signInBloc.add(SignInButtonEvent()),
                  );
                },
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomTextWidget(
                  text: "Don't have an account?",
                  fontSize: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.kSignUpScreenRoute);
                    },
                    child: const CustomTextWidget(
                      text: "Sign Up",
                      fontSize: 12.0,
                      textColor: ColorConstant.kPrimaryColor,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
