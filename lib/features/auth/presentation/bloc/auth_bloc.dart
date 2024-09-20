import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_practice/core/bloc/logged_in_cubit/logged_in_cubit.dart';
import 'package:machine_test_practice/core/usecase/usecase.dart';
import 'package:machine_test_practice/features/auth/domain/entities/user_entity.dart';
import 'package:machine_test_practice/features/auth/domain/usecases/is_logged_in.dart';
import 'package:machine_test_practice/features/auth/domain/usecases/store_to_hive.dart';
import 'package:machine_test_practice/features/auth/domain/usecases/user_sign_in.dart';
import 'package:machine_test_practice/features/auth/domain/usecases/user_sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignIn _userSignIn;
  final IsLoggedInCheck _isLoggedInCheck;
  final StoreToHive _storeToHive;
  final LoggedInCubit _loggedInCubit;
  final UserSignOut _userSignOut;

  AuthBloc(
    UserSignIn userSignIn,
    IsLoggedInCheck isLoggedInCheck,
    StoreToHive storeToHive,
    LoggedInCubit loggedInCubit,
    UserSignOut userSignOut,
  )   : _userSignIn = userSignIn,
        _isLoggedInCheck = isLoggedInCheck,
        _storeToHive = storeToHive,
        _loggedInCubit = loggedInCubit,
        _userSignOut = userSignOut,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(AuthLoading()));

    on<SignInButtonPressed>((event, emit) async {
      try {
        final result = await _userSignIn.call(SignInParams(
          email: event.email,
          password: event.password,
        ));

        result.fold(
          (failure) => emit(AuthFailure(message: failure.message)),
          (user) => emit(AuthSuccess(user: user)),
        );
      } catch (e) {
        emit(AuthFailure(message: e.toString()));
      }
    });

    on<IsLoggedIn>((event, emit) async {
      final result = await _isLoggedInCheck(NoParams());
      result.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });

    on<LoadFromHive>((event, emit) async {
      final result = await _storeToHive(NoParams());
      result.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    });

    on<SignOutButtonPressed>((event, emit) {
      _userSignOut();
      emit(AuthFailure(message: "Logged Out Successfully!"));
    });
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit) {
    _loggedInCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
