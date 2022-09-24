import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:patterns/app/modules/login/controllers/login_event.dart';
import 'package:patterns/app/modules/login/controllers/login_state.dart';
import 'package:patterns/app/modules/login/value_objects/email_value_object.dart';
import 'package:patterns/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';
import '../value_objects/password_value_object.dart';

class LoginView extends GetView<LoginController> implements LoginEvent {
  LoginView({Key? key}) : super(key: key);
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.stateObs.listen((p0) {
      if (p0.validateStatus == ValidateStatus.inProgress) {
        final isValid = form.currentState!.validate();
        if (isValid) {
          onPressedLogin(controller.state.email, controller.state.password);
        } else {}
      }
    });
    return Obx(() {
      return ModalProgressHUD(
        inAsyncCall: controller.state.isLoading.value,
        child: Scaffold(
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
    // final isValid = form.currentState!.validate();
    // if (isValid) {
    final result = await controller.onPressedLogin(email, password);
    result.fold((l) => Get.snackbar('Error', 'Invalid Cred'),
        (r) => Get.toNamed(Routes.HOME));
    // }
  }
}
