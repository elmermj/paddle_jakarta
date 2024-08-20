import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';

class RegisterEmail {
  final UserRepository repository;

  RegisterEmail(this.repository);

  Future<Either<String, Unit>> call(String email, String password) async {
    return repository.registerEmail(email, password);
  }
}
