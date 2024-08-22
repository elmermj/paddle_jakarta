// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paddle_jakarta/data/helpers/web_client_id_helper.dart';
import 'package:paddle_jakarta/data/models/timestamp_adapter.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';
import 'package:paddle_jakarta/data/sources/local_user_data_source.dart';
import 'package:paddle_jakarta/data/sources/remote_user_data_source.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';
import 'package:paddle_jakarta/domain/use_cases/auth/forgot_password.dart';
import 'package:paddle_jakarta/domain/use_cases/auth/login_email.dart';
import 'package:paddle_jakarta/domain/use_cases/auth/login_google.dart';
import 'package:paddle_jakarta/domain/use_cases/auth/register_email.dart';
import 'package:paddle_jakarta/domain/use_cases/home/logout.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/theme_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ThemeService());

  // register web client id from json
  locator.registerLazySingleton(() => WebClientIdHelper());

  // Register FirebaseAuth
  locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // Register Hive Adapters
  await Hive.initFlutter();
  Hive.registerAdapter<Timestamp>(TimestampAdapter());
  Hive.registerAdapter<UserModel>(UserModelAdapter());

  // Register Hive Box
  final userDataBox = await Hive.openBox<UserModel>('userDataBox');
  locator.registerSingleton<Box<UserModel>>(userDataBox);

  // Register Data Sources
  locator.registerFactory<RemoteUserDataSource>(() => RemoteUserDataSource(locator<FirebaseAuth>()));
  locator.registerFactory<LocalUserDataSource>(() => LocalUserDataSource(locator<Box<UserModel>>()));

  /// Register UserRepository
  locator.registerFactory<UserRepository>(() => UserRepositoryImpl(
    locator<RemoteUserDataSource>(),
    locator<LocalUserDataSource>()
  ));

  // Register Use Cases if needed
  locator.registerFactory<LoginEmail>(() => LoginEmail(locator<UserRepository>()));
  locator.registerFactory<LoginGoogle>(() => LoginGoogle(locator<UserRepository>()));
  locator.registerFactory<RegisterEmail>(() => RegisterEmail(locator<UserRepository>()));
  locator.registerFactory<ForgotPassword>(() => ForgotPassword(locator<UserRepository>()));
  locator.registerFactory<Logout>(() => Logout(locator<UserRepository>()));
}
