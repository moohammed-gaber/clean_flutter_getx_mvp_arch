import 'package:get/get.dart';
import 'package:patterns/app/modules/login/repos/login_repo.dart';

import '../controllers/login_controller.dart';
import '../controllers/login_state.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(LoginState(),LoginRepo()),
    );
  }
}
