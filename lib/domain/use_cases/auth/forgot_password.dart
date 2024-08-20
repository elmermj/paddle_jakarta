import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';

class ForgotPassword {
  final UserRepository repository;

  ForgotPassword(this.repository);

  Future<Either<String, Unit>> call(String email) async {
    return repository.forgotPassword(email);
  }
}