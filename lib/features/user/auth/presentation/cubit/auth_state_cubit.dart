import 'package:equatable/equatable.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahala/features/user/auth/data/models/user_model.dart';
import 'package:rahala/features/user/auth/data/repositories/auth_repository.dart';

part 'auth_state_state.dart';

class AuthStateCubit extends Cubit<AuthStateState> {
  final AuthRepository authRepository;

  AuthStateCubit({required this.authRepository}) : super(AuthStateInitial());

  Future<void> checkAuthState() async {
    try {
      final isLoggedIn = await authRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = await authRepository.getCachedUser();
        if (user != null) {
          emit(AuthStateSuccess(user: user));
          return;
        }
      }
      emit(AuthStateInitial());
    } catch (_) {
      emit(AuthStateInitial());
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthStateLoading());
    final result = await authRepository.login(email: email, password: password);
    result.fold(
      (failure) => emit(AuthStateError(failure.message)),
      (user) => emit(AuthStateSuccess(user: user)),
    );
  }

  Future<void> logout() async {
    emit(AuthStateLoading());
    await authRepository.logout();
    emit(AuthStateInitial());
  }
}
