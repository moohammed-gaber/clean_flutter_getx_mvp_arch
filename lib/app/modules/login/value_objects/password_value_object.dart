import 'package:dartz/dartz.dart';
import 'package:patterns/app/core/domain/value_object.dart';

import 'package:dartz/dartz.dart';

class Password extends ValueObject<String> {
  static Either<ValueFailure<String>, String> validatePassword(String input) {
    if (input.length >= 6) {
      return right(input);
    } else {
      return left(ValueFailure());
    }
  }

  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);
}