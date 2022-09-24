import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:patterns/app/core/failures/failure.dart';
import 'package:patterns/app/modules/login/controllers/login_event.dart';
import 'package:patterns/app/modules/login/controllers/login_state.dart';
import 'package:patterns/app/modules/login/repos/login_repo.dart';
import 'package:patterns/app/modules/login/value_objects/email_value_object.dart';
import 'package:patterns/app/modules/login/value_objects/password_value_object.dart';

class LoginController extends GetxController implements LoginEvent {
  final stateObs = LoginState().obs;
  final ILoginRepo repo;
  LoginController(this.repo);

  LoginState get state => stateObs.value;
  @override
  void onEmailChanged(EmailAddress email) {
    state.email = email;
  }

  @override
  void onPasswordChanged(Password password) {
    state.password = password;
  }

// toggle loading
  void _toggleLoading() {
    state.isLoading.value = !state.isLoading.value;
  }

  @override
  Future<Either<Failure, Unit>> onPressedLogin(
      EmailAddress email, Password password) async {
    _toggleLoading();
    state.validateStatus = ValidateStatus.inProgress;
    final result = await repo.login(email, password);
    _toggleLoading();
    return result;
  }
}
