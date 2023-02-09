import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/utilities/regex_validation.dart';

part 'sign_in_events.dart';
part 'sign_in_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();
  bool _showPassword = true, _rememberMe = false;
  String _emailErrorMsg = "", _passwordErrorMsg = "";

  SignInBloc() : super(const SignInState()) {
    on<PasswordValidationEvent>(_onPasswordValidateEvent);
    on<PasswordVisibleEvent>(_onPasswordVisibleEvent);
    on<RememberMeEvent>(_onRememberMeEvent);
    on<EmailValidationEvent>(_onEmailValidateEvent);
    on<SignInButtonEvent>(_onSignInButtonEvent);
  }

  void removeFocus() {
    if (passwordFocusNode.hasFocus) {
      passwordFocusNode.unfocus();
    } else if (emailFocusNode.hasFocus) {
      emailFocusNode.unfocus();
    }
  }

  bool _validateEmail() {
    if (emailController.text.isEmpty) {
      _emailErrorMsg = "Email is required";
    } else if (!(RegexValidation.isEmail(emailController.text))) {
      _emailErrorMsg = "Invalid email address";
    } else {
      _emailErrorMsg = "";
    }
    return _emailErrorMsg.isEmpty;
  }

  bool _validatePassword() {
    if (passwordController.text.isEmpty) {
      _passwordErrorMsg = "Password is required";
    } else if (passwordController.text.length < 8) {
      _passwordErrorMsg = "Password is too short";
    } else {
      _passwordErrorMsg = "";
    }
    return _passwordErrorMsg.isEmpty;
  }

  void _onPasswordValidateEvent(
      PasswordValidationEvent event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        passwordErrorMsg: _validatePassword() ? "" : _passwordErrorMsg,
      ),
    );
  }

  void _onPasswordVisibleEvent(
      PasswordVisibleEvent event, Emitter<SignInState> emit) {
    _showPassword = !_showPassword;
    emit(
      state.copyWith(
        isPasswordVisible: _showPassword,
      ),
    );
  }

  void _onRememberMeEvent(RememberMeEvent event, Emitter<SignInState> emit) {
    _rememberMe = !_rememberMe;
    emit(
      state.copyWith(
        isRememberMe: _rememberMe,
      ),
    );
  }

  void _onEmailValidateEvent(
      EmailValidationEvent event, Emitter<SignInState> emit) {
    emit(
      state.copyWith(
        emailErrorMsg: _validateEmail() ? "" : _emailErrorMsg,
      ),
    );
  }

  void _onSignInButtonEvent(
      SignInButtonEvent event, Emitter<SignInState> emit) async {
    if (_validateEmail() & _validatePassword()) {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      await Future.delayed(const Duration(seconds: 5), () {});
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          passwordErrorMsg: _passwordErrorMsg,
          emailErrorMsg: _emailErrorMsg,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    return super.close();
  }
}
