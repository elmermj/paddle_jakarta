// // GENERATED CODE - DO NOT MODIFY BY HAND

// // **************************************************************************
// // StackedLocatorGenerator
// // **************************************************************************

// // ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:paddle_jakarta/data/helpers/web_client_id_helper.dart';
// import 'package:paddle_jakarta/data/models/match_model.dart';
// import 'package:paddle_jakarta/data/models/statistics_model.dart';
// import 'package:paddle_jakarta/data/models/timestamp_adapter.dart';
// import 'package:paddle_jakarta/data/models/user_model.dart';
// import 'package:paddle_jakarta/data/sources/match_data_sources/local_match_data_source.dart';
// import 'package:paddle_jakarta/data/sources/match_data_sources/remote_match_data_source.dart';
// import 'package:paddle_jakarta/data/sources/timeline_data_sources/remote_timeline_data_source.dart';
// import 'package:paddle_jakarta/data/sources/user_data_sources.dart/local_user_data_source.dart';
// import 'package:paddle_jakarta/data/sources/user_data_sources.dart/remote_user_data_source.dart';
// import 'package:paddle_jakarta/domain/repository/match_repository.dart';
// import 'package:paddle_jakarta/domain/repository/timeline_repository.dart';
// import 'package:paddle_jakarta/domain/repository/user_repository.dart';
// import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
// import 'package:stacked_services/src/dialog/dialog_service.dart';
// import 'package:stacked_services/src/navigation/navigation_service.dart';
// import 'package:stacked_shared/stacked_shared.dart';

// import '../services/theme_service.dart';

// final locator = StackedLocator.instance;

// Future<void> setupLocator({
//   String? environment,
//   EnvironmentFilter? environmentFilter,
// }) async {
// // Register environments
//   locator.registerEnvironment(
//       environment: environment, environmentFilter: environmentFilter);

// // Register dependencies
//   locator.registerLazySingleton(() => BottomSheetService());
//   locator.registerLazySingleton(() => DialogService());
//   locator.registerLazySingleton(() => NavigationService());
//   locator.registerLazySingleton(() => ThemeService());

//   // register web client id from json
//   locator.registerLazySingleton(() => WebClientIdHelper());

//   // Register FirebaseAuth
//   FirebaseApp app = Firebase.app();
//   locator.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
//   locator.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instanceFor(app: app, databaseURL: "paddle-jakarta-dev"));

//   // Register Hive Adapters
//   await Hive.initFlutter();
//   Hive.registerAdapter<Timestamp>(TimestampAdapter());
//   Hive.registerAdapter<UserModel>(UserModelAdapter());
//   Hive.registerAdapter<MatchModel>(MatchModelAdapter());
//   Hive.registerAdapter<StatisticsModel>(StatisticsModelAdapter());

//   // Register Hive Box
//   final userDataBox = await Hive.openBox<UserModel>('userDataBox');
//   final matchesDataBox = await Hive.openBox<List<MatchModel>>('matchesDataBox');
//   locator.registerSingleton<Box<UserModel>>(userDataBox);
//   locator.registerSingleton<Box<List<MatchModel>>>(matchesDataBox);

//   // Register Data Sources
//   locator.registerFactory<RemoteUserDataSource>(() => RemoteUserDataSource(locator<FirebaseAuth>(), locator<FirebaseFirestore>()));
//   locator.registerFactory<LocalUserDataSource>(() => LocalUserDataSource(locator<Box<UserModel>>()));

//   locator.registerFactory<RemoteMatchDataSource>(() => RemoteMatchDataSource(locator<FirebaseFirestore>()));
//   locator.registerFactory<LocalMatchDataSource>(() => LocalMatchDataSource(locator<Box<List<MatchModel>>>()));
//   locator.registerFactory<RemoteTimelineDataSource>(() => RemoteTimelineDataSource(locator<FirebaseFirestore>(), locator<FirebaseAuth>()));

//   /// Register UserRepository
//   locator.registerFactory<UserRepository>(() => UserRepositoryImpl(
//     locator<RemoteUserDataSource>(),
//     locator<LocalUserDataSource>()
//   ));

//   locator.registerFactory<MatchRepository>(()=> MatchRepositoryImpl(
//     locator<RemoteMatchDataSource>(), 
//     locator<LocalMatchDataSource>()
//   ));

//   locator.registerFactory<TimelineRepository>(()=> TimelineRepositoryImpl(
//     locator<RemoteTimelineDataSource>(),
//   ));

// }
