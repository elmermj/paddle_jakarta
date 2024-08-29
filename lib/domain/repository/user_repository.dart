import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';
import 'package:paddle_jakarta/data/sources/user_data_sources.dart/local_user_data_source.dart';
import 'package:paddle_jakarta/data/sources/user_data_sources.dart/remote_user_data_source.dart';

abstract class UserRepository {
  Future<Either<String, Unit>> loginEmail(String email, String password);
  Future<Either<String, Unit>> loginGoogle();
  Future<Either<String, Unit>> registerEmail(String email, String password, String name);
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
      final userCredential = await remoteData.loginEmail(email, password);
      await toSaveUserData(userCredential);
      return right(unit);
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> loginGoogle() async {
    try {
      final userCredential = await remoteData.loginGoogle();
      await toSaveUserData(userCredential);
      return right(unit);
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> registerEmail(String email, String password, String name) async {
    try {
      await remoteData.registerEmail(email, password, name);
      return right(unit);
    } on Exception catch (e) {
      return left(e.toString());
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
    } on Exception catch (e) {
      return left(e.toString());
    }
  }
  
  @override
  Future<Either<String, Unit>> logout() async {
    try {
      await remoteData.logout();
      await localData.clearUserData();
      return right(unit);
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  
}

extension on UserRepositoryImpl {
  toSaveUserData(UserCredential userCredential) async {
    // Save user data to local data source
    await localData.saveUserData(
      UserModel(
        displayName: userCredential.user?.displayName,
        email: userCredential.user?.email,
        photoUrl: userCredential.user?.photoURL,
        creationTime: Timestamp.fromDate(userCredential.user?.metadata.creationTime ?? DateTime.now()),
      )
    );
  }
}
