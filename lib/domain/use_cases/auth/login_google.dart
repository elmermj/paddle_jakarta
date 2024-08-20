import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';

class LoginGoogle {
  final UserRepository repository;

  LoginGoogle(this.repository);

  Future<Either<String, Unit>> call() async {
    return repository.loginGoogle();
  }
}
