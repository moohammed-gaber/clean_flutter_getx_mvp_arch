import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:patterns/app/core/failures/failure.dart';
import 'package:patterns/app/modules/login/controllers/login_event.dart';
import 'package:patterns/app/modules/login/controllers/login_handler.dart';
import 'package:patterns/app/modules/login/controllers/login_state.dart';
import 'package:patterns/app/modules/login/repos/login_repo.dart';
import 'package:patterns/app/modules/login/value_objects/email_value_object.dart';
import 'package:patterns/app/modules/login/value_objects/password_value_object.dart';

class LoginController extends GetxController implements LoginEvent {
  final LoginState state;
  final ILoginRepo repo;
  late final LoginViewHandler view;
  LoginController(
    this.state,
    this.repo,
  );

  @override
  void onEmailChanged(EmailAddress email) {
    state.email = email;
  }

  @override
  void onPasswordChanged(Password password) {
    state.password = password;
  }

  @override
  Future<void> onPressedLogin(EmailAddress email, Password password) async {
    state.isLoading.value = true;
    final result = await repo.login(email, password);
    state.isLoading.value = false;
    result.fold((l) => view.onLoginFailed(), (r) => view.onLoginSuccess());
  }
}
