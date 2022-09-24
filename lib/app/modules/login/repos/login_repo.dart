import 'package:dartz/dartz.dart';
import 'package:patterns/app/core/failures/failure.dart';
import 'package:patterns/app/modules/login/failures/login_failures.dart';
import 'package:patterns/app/modules/login/value_objects/email_value_object.dart';
import 'package:patterns/app/modules/login/value_objects/password_value_object.dart';

abstract class ILoginRepo {
  Future<Either<Failure, Unit>> login(EmailAddress email, Password password);
}

class LoginRepo implements ILoginRepo {
  Future<Either<Failure, Unit>> login(
      EmailAddress email, Password password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email.getOrCrash() == 'admin@admin.com' &&
        password.getOrCrash() == '123456') {
      return right(unit);
    }
    return left(InvalidLoginCredentialsFailure());
  }
}
