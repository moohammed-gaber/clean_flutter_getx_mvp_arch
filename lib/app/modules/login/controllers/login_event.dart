import 'package:patterns/app/modules/login/value_objects/email_value_object.dart';
import 'package:patterns/app/modules/login/value_objects/password_value_object.dart';

abstract class LoginEvent {
  void onEmailChanged(EmailAddress email);
  void onPasswordChanged(Password password);
  void onPressedLogin(EmailAddress email, Password password);
}
