import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/data/sources/local_user_data_source.dart';
import 'package:paddle_jakarta/data/sources/remote_user_data_source.dart';

abstract class UserRepository {
  Future<Either<String, Unit>> loginEmail(String email, String password);
  Future<Either<String, Unit>> loginGoogle();
  Future<Either<String, Unit>> registerEmail(String email, String password);
  Future<Either<String, Unit>> logout();
  Future<Either<String, Unit>> deleteAccount();
  Future<Either<String, Unit>> forgotPassword(String email);
}

class UserRepositoryImpl implements UserRepository {
  final RemoteUserDataSource remoteData;
  final LocalUserDataSource localData;

  UserRepositoryImpl(this.remoteData, this.localData);

  @override
  Future<Either<String, Unit>> loginEmail(String email, String password) async {
    try {
      await remoteData.loginEmail(email, password);
      return right(unit);
    } catch (e) {
      return left('Login failed');
    }
  }

  @override
  Future<Either<String, Unit>> loginGoogle() async {
    try {
      await remoteData.loginGoogle();
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> registerEmail(String email, String password) async {
    try {
      await remoteData.registerEmail(email, password);
      return right(unit);
    } catch (e) {
      return left('Registration failed');
    }
  }
  
  @override
  Future<Either<String, Unit>> deleteAccount() {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
  
  @override
  Future<Either<String, Unit>> forgotPassword(String email) async {
    try {
      await remoteData.forgotPassword(email);
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }
  
  @override
  Future<Either<String, Unit>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
