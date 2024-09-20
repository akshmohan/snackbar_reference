import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_practice/core/bloc/logged_in_cubit/logged_in_cubit.dart';
import 'package:machine_test_practice/core/bloc/selected_cubit/selected_cubit.dart';
import 'package:machine_test_practice/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_practice/init_dependencies.dart';

class BlocProviders {
  BlocProviders._();

  static final dynamic providers = [
    BlocProvider<AuthBloc>(create: (context) => serviceLocator<AuthBloc>()),
    BlocProvider<LoggedInCubit>(
        create: (context) => serviceLocator<LoggedInCubit>()),
    BlocProvider<SelectedCubit>(
        create: (context) => serviceLocator<SelectedCubit>())
  ];
}
