import 'package:get/get.dart';
import 'package:patterns/app/modules/login/value_objects/email_value_object.dart';
import 'package:patterns/app/modules/login/value_objects/password_value_object.dart';
enum ValidateStatus { inProgress,none, valid, invalid }
class LoginState {
  EmailAddress email = EmailAddress('');
  Password password = Password('');
  final isLoading = false.obs;
   ValidateStatus validateStatus = ValidateStatus.none;

}
