import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';

class Logout {
  final UserRepository _userRepository;

  Logout(this._userRepository);

  Future<Either<String, Unit>> call() async {
    return await _userRepository.logout();
  }
}