import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:machine_test_practice/core/bloc/logged_in_cubit/logged_in_cubit.dart';
import 'package:machine_test_practice/core/bloc/selected_cubit/selected_cubit.dart';
import 'package:machine_test_practice/core/internet/connection_checker.dart';
import 'package:machine_test_practice/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:machine_test_practice/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:machine_test_practice/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:machine_test_practice/features/auth/domain/repository/auth_repo.dart';
import 'package:machine_test_practice/features/auth/domain/usecases/is_logged_in.dart';
import 'package:machine_test_practice/features/auth/domain/usecases/store_to_hive.dart';
import 'package:machine_test_practice/features/auth/domain/usecases/user_sign_in.dart';
import 'package:machine_test_practice/features/auth/domain/usecases/user_sign_out.dart';
import 'package:machine_test_practice/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initCore();

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: 'data'));
}

void _initCore() {
  serviceLocator.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(InternetConnection()));
}

void _initAuth() {
  //Datasource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator<ConnectionChecker>()))
    ..registerFactory<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(serviceLocator()))
    //Repository
    ..registerFactory<AuthRepository>(() => AuthRepoImpl(
          serviceLocator(),
          serviceLocator(),
        ))
    //Usecase
    ..registerFactory(() => UserSignIn(serviceLocator()))
    ..registerFactory(() => StoreToHive(serviceLocator()))
    ..registerFactory(() => IsLoggedInCheck(serviceLocator()))
    ..registerFactory(() => UserSignOut(serviceLocator()))
    //Bloc
    ..registerLazySingleton<LoggedInCubit>(() => LoggedInCubit())
    ..registerLazySingleton<SelectedCubit>(() => SelectedCubit())
    ..registerLazySingleton(
      () => AuthBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}
