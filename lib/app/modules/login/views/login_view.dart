import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patterns/app/modules/login/controllers/login_event.dart';
import 'package:patterns/app/modules/login/controllers/login_handler.dart';
import 'package:patterns/app/modules/login/value_objects/email_value_object.dart';
import 'package:patterns/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';
import '../value_objects/password_value_object.dart';
bool testMode= true;
class LoginView extends GetView<LoginController>
    implements LoginEvent, LoginViewHandler {
  LoginView({Key? key}) : super(key: key);
  final form = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgressHUD(
        inAsyncCall: controller.state.isLoading.value,
        child: Scaffold(
          floatingActionButton: Visibility(
            visible: testMode,
            child: FloatingActionButton(
              onPressed: () {
                emailController.text = 'admin@admin.com';
                passwordController.text = '123456';
              },
              child: Icon(Icons.home),
            ),
          ),
          appBar: AppBar(
            title: const Text('LoginView'),
            centerTitle: true,
          ),
          body: Form(
            key: form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      return controller.state.email.value
                          .fold((l) => 'Invalid Email', (r) => null);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    onChanged: (_) => onEmailChanged(EmailAddress(_)),
                  ),
                  TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      onChanged: (_) => onPasswordChanged(Password(_)),
                      validator: (value) {
                        return controller.state.password.value
                            .fold((l) => 'Invalid Password', (r) => null);
                      }),
                  ElevatedButton(
                    onPressed: () => onPressedLogin(
                        controller.state.email, controller.state.password),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void onEmailChanged(EmailAddress email) {
    controller.onEmailChanged(email);
  }

  @override
  void onPasswordChanged(Password password) {
    controller.onPasswordChanged(password);
  }

  @override
  Future<void> onPressedLogin(EmailAddress email, Password password) async {
    final isValid = form.currentState!.validate();
    if (isValid) {
      await controller.onPressedLogin(email, password);
    }
  }

  @override
  void onLoginFailed() {
    Get.snackbar('Error', 'Invalid Cred');
  }

  @override
  void onLoginSuccess() {
    Get.toNamed(Routes.HOME);
  }

  @override
  StatelessElement createElement() {
    print('LoginView createElement');
    controller.view = this;
    return super.createElement();
  }
}
