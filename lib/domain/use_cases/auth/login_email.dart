import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';

class LoginEmail {
  final UserRepository repository;

  LoginEmail(this.repository);

  Future<Either<String, Unit>> call(String email, String password) async {
    return repository.loginEmail(email, password);
  }
}
