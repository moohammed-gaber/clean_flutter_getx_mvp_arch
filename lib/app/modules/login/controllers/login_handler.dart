abstract class LoginViewContract {
  bool validate();
  void onLoginSuccess();
  void onLoginFailed();
}
