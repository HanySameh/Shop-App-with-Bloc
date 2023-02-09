part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class PasswordVisibleEvent extends SignInEvent {}

class EmailValidationEvent extends SignInEvent {}

class PasswordValidationEvent extends SignInEvent {}

class RememberMeEvent extends SignInEvent {}

class SignInButtonEvent extends SignInEvent {}
